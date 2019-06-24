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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner : UIActivityIndicatorView!

    
    var filteredContent : [Film]?
    /* Rx Swift */
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    let contents: BehaviorRelay<[Film]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeNavButton()
        
        setUpSearchBar()
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func configView(){
        
        self.tableView.delegate = self
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
        
        viewModel.isLoading.asObservable().bind { value in
            if value {
                self.showLoadignView()
            }else{
                self.removeLoadingView()
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
                    self.filteredContent = filSearch
                }})
                .disposed(by: disposeBag)
        
        contents.bind(to: tableView.rx.items(cellIdentifier: "cell")) {
            row, model, cell in
            cell.textLabel?.text = "\(model.name), \(model.desc)"
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Film.self)
            .map{ URL(string: $0.url) }
            .subscribe(onNext: { [weak self] url in
                guard let url = url else {
                    return
                }
                self?.present(SFSafariViewController(url: url), animated: true)
            }).disposed(by: disposeBag)
    }
}
extension SearchViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContent?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = filteredContent[indexPath.row].title
        return cell
    }
    
    
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getSearchMovies(by: "movie" , category: "movie", key: searchText)
    }
}
