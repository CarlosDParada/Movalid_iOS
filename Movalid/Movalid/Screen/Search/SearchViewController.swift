//
//  SearchViewController.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController  {
    
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var whiteView: UIView!
    
    
    var filteredContent : [Film]?
    
    let tableView = UITableView()
    
    /* Rx Swift */
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    let contents: BehaviorRelay<[Film]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeNavButton()
        setUpSearchBar()
        tableView.frame = self.whiteView.frame
        view.addSubview(tableView)
//        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchItemCell")
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchItemCell")
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createCallbacks()
        
    }
    //MARK: - RxSwift
    func createCallbacks (){
        viewModel.isErrorData.asObservable()
            .bind{ errorModel in
                if (errorModel.codeError != ErrorConnection.none ){
                    let messageAlert = MessageString.setupTextAlertLoading(by: errorModel)
                    let alertError : UIAlertController  =
                        UIAlertController.actionShowOneAction(by: "", message: messageAlert, button: MessageString.tryAgain) {_ in
                    }
                    self.present(alertError, animated: true, completion: nil)
                }else{
                    print("Success in \(errorModel.serviceName ?? "Empty")")
                }
            }.disposed(by: disposeBag)
        
        btnGoBack.rx.tap
            .bind{
                self.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        viewModel.isSuccessData.asObservable()
            .subscribe( onNext: { filSearch in
                print(filSearch)
                if(filSearch.count > 0){
                    self.contents.accept(filSearch)
                }})
            .disposed(by: disposeBag)
        
//        contents.bind(to: tableView.rx.items(cellIdentifier : "searchItemCell")) {
//            row, model, cell in
//            cell.textLabel?.text = "\(model.title!), \(model.release_date!)"
//            cell.textLabel?.numberOfLines = 0
//            cell.selectionStyle = .none
//            }.disposed(by: disposeBag)
        
        contents.bind(to: tableView.rx.items) { (tableView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchItemCell", for: indexPath) as! SearchTableViewCell

            cell.setupByContent(by: element)
            return cell
            }
            .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Film.self)
            .map {$0.title }
            .subscribe(onNext: { title in
                // Alert with advertis
                print(title ?? " - ")
            }).disposed(by: disposeBag)
    }
}

//extension SearchViewController : UITableViewDelegate , UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredContent?.count ?? 0
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
//        return cell
//    }
//}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let whitespaceSet = NSCharacterSet.whitespaces
        let range = searchText.rangeOfCharacter(from: whitespaceSet)
        
        if let _ =  searchText.rangeOfCharacter(from: whitespaceSet) {
            self.searchBar.text = ""
        }
        else {
            viewModel.getSearchMovies(by: "movie" , category: "movie", key: searchText)
        }
    }
}
