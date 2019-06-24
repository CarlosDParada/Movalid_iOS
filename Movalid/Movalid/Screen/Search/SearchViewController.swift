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
    @IBOutlet weak var segmentType: UISegmentedControl!
    
    
    var filteredContent : [Film]?
    
    let tableView = UITableView()
    
    /* Rx Swift */
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    let contents: BehaviorRelay<[Film]> = BehaviorRelay(value: [])
    
    var typeContent: BehaviorRelay<String> = BehaviorRelay(value: "movie")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeNavButton()
        setUpSearchBar()
        tableView.frame = self.whiteView.frame
        view.addSubview(tableView)
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchItemCell")
        tableView.backgroundColor = UIColor.backgroundColor
        tableView.allowsSelection = false
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
                if(filSearch.count > 0){
                    self.contents.accept(filSearch)
                }})
            .disposed(by: disposeBag)
        contents.bind(to: tableView.rx.items) { (tableView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchItemCell", for: indexPath) as! SearchTableViewCell
            cell.setupByContent(by: element, byType: self.typeContent.value)
            return cell
            }
            .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Film.self)
            .map {$0.title }
            .subscribe(onNext: { title in
            }).disposed(by: disposeBag)
        
        segmentType.rx.selectedSegmentIndex.asObservable()
            .subscribe(onNext: { index in
                self.typeContent.accept(HandlerData.getTypeContentString(by: index))
            }).disposed(by: disposeBag)
        
        typeContent.subscribe(onNext: { text in
            self.searchBar.text = ""
        }).disposed(by: disposeBag)
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let whitespaceSet = NSCharacterSet.whitespaces
        if let _ =  searchText.rangeOfCharacter(from: whitespaceSet) {
            self.searchBar.text = ""
        }
        else {
            viewModel.getSearchMovies(by: typeContent.value , category: typeContent.value, key: searchText)
        }
    }
}
