//
//  ViewController.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource{
    
    
    @IBOutlet weak var segmentTypeContent: UISegmentedControl!
    @IBOutlet weak var segmentCategory: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var secondTime: Bool = false
    
    /* Rx Swift */
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        self.title = "MOVALID"
        loadLocalParameters()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createCallbacks()
        buildNavButtons()
    }
    func loadLocalParameters() {
        //FIXME : Revisar
        segmentTypeContent.selectedSegmentIndex = IntContent.movie
        HandlerData.updateTypeContent(by: IntContent.movie)
        segmentCategory.selectedSegmentIndex = IntCategory.popular
        HandlerData.updateCategoryContent(by: IntCategory.popular)
        tableView.reloadData()
    }
    
    //MARK: - RxSwift
    func createCallbacks (){
        /* Error Response */
        viewModel.isErrorData.asObservable()
            .bind{ errorModel in
                if (errorModel.codeError != ErrorConnection.none ){
                    let messageAlert = MessageString.setupTextAlertLoading(by: errorModel)
                    let alertError : UIAlertController  =
                        UIAlertController.actionShowOneAction(by: "", message: messageAlert, button: MessageString.accept) {_ in
                            self.loadLocalParameters()
                            self.removeLoadingView()
                    }
                    self.present(alertError, animated: true, completion: nil)
                }else{
                    print("Success in \(errorModel.serviceName ?? "Empty")")
                }
            }.disposed(by: disposeBag)
        
        viewModel.isSuccessData.asObservable()
            .bind{state in
                if (state){
                    self.removeLoadingView()
                    self.tableView.reloadData()
                }
            }.disposed(by: disposeBag)
        
        viewModel.isLoading.asObservable().bind { value in
            if value {
                self.showLoadignView()
            }else{
                self.removeLoadingView()
            }
            }.disposed(by: disposeBag)
        
        segmentTypeContent.rx.selectedSegmentIndex.asObservable()
            .subscribe(onNext: { index in
                print(index)
                if(self.secondTime){
                    self.contentTypeObserver(by: index)
                    //                    HandlerData.updateTypeContent(by: index)
                    //                    self.segmentTypeContent.selectedSegmentIndex = index
                    //                    self.viewModel.getFindMovies(by: HandlerData.getTypeContentString(by: index),
                    //                                                 category: HandlerData.getCategoryString(by: self.segmentCategory.selectedSegmentIndex))
                    
                }
            })
            .disposed(by: disposeBag)
        segmentCategory.rx.selectedSegmentIndex.asObservable()
            .subscribe(onNext: { index in
                if(self.secondTime){
                    print(index)
                    self.categoryObserver(by: index)
                    //                    self.segmentCategory.selectedSegmentIndex = index
                    //                    HandlerData.updateCategoryContent(by: index)
                    //                    self.viewModel.getFindMovies(by: HandlerData.getTypeContentString(by: self.segmentTypeContent.selectedSegmentIndex),
                    //                                                 category: HandlerData.getCategoryString(by: index))
                }else{
                    self.secondTime = true
                }
            })
            .disposed(by: disposeBag)
        
    }
    func contentTypeObserver(by index: Int){
        HandlerData.updateTypeContent(by: index)
        if (index == 1) {
            self.segmentCategory.setEnabled(false, forSegmentAt: 2)
            if (self.segmentCategory.selectedSegmentIndex == 2){
                self.segmentCategory.selectedSegmentIndex = 0
                HandlerData.updateCategoryContent(by: 0)
            }
            
            self.viewModel.getFindMovies(by: HandlerData.getTypeContentString(by: self.segmentTypeContent.selectedSegmentIndex),
                                         category: HandlerData.getCategoryString(by: self.segmentCategory.selectedSegmentIndex))
        }else{
            self.segmentCategory.setEnabled(true, forSegmentAt: 2)
            self.viewModel.getFindMovies(by: HandlerData.getTypeContentString(by: index),
                                         category: HandlerData.getCategoryString(by: self.segmentCategory.selectedSegmentIndex))
        }
    }
    
    func categoryObserver(by index: Int){
        if (index == 2) {
            if (self.segmentTypeContent.selectedSegmentIndex == 1) {
                self.segmentCategory.selectedSegmentIndex = 1
                HandlerData.updateCategoryContent(by: 1)
                self.segmentCategory.setEnabled(false, forSegmentAt: 2)
                
                self.viewModel.getFindMovies(by: HandlerData.getTypeContentString(by: self.segmentTypeContent.selectedSegmentIndex),
                                             category: HandlerData.getCategoryString(by: self.segmentCategory.selectedSegmentIndex))
                
            }else{
                self.segmentCategory.setEnabled(true, forSegmentAt: 2)
                HandlerData.updateCategoryContent(by: index)
                self.viewModel.getFindMovies(by:
                    HandlerData.getTypeContentString(by: self.segmentTypeContent.selectedSegmentIndex),
                                             category: HandlerData.getCategoryString(by:index))
            }
        }else{
            print(index)
            HandlerData.updateCategoryContent(by: index)
            self.viewModel.getFindMovies(by: HandlerData.getTypeContentString(by: self.segmentTypeContent.selectedSegmentIndex),
                                         category: HandlerData.getCategoryString(by: index))}
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(">>\(HandlerData.getContentBySituation().count)")
        if (HandlerData.getContentBySituation().count <= 0) {
            return 1
        }else{
            return HandlerData.getContentBySituation().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (HandlerData.getContentBySituation().count <= 0) {
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.emptyCell, for: indexPath) 
            cell.textLabel?.text  = TextString.noDataCell
            cell.textLabel?.textColor = UIColor.white
            return cell
        }else{
            let cell : ContentHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.homeCellIdentifier, for: indexPath) as! ContentHomeTableViewCell
            print(">>\(HandlerData.getContentBySituation()[indexPath.row])")
            cell.setupByContent(by: HandlerData.getContentBySituation()[indexPath.row])
            print(">>\(HandlerData.getContentBySituation()[indexPath.row].title)")
            return cell}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (HandlerData.getContentBySituation().count <= 0) {
           return 50
        }else{
            return 150
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? ContentHomeTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmSelected : Film = HandlerData.getContentBySituation()[indexPath.row]
        let goToVC : UIViewController = ViewControllerExtension.detailViewController(byFilm: filmSelected , typeContent: HandlerData.getTypeContentString(by: self.segmentTypeContent.selectedSegmentIndex))
        self.present(goToVC, animated: true) {
            self.removeFromParent()
        }
    }
    
}
extension HomeViewController :  UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HandlerData.getContentBySituation()[collectionView.tag].genre_ids!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : GenersCollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.homeCollectIdentifier,
                                               for: indexPath) as! GenersCollectionViewCell
        let generSingle = HandlerData.getContentBySituation()[collectionView.tag].genre_ids![indexPath.row]
        cell.setupByContent(by: generSingle)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 13)
    }
    
    private func collectionView(collectionView: UICollectionView, didDeselectItemAt indexPath: NSIndexPath) {
        let cellToDeselect:UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath )!
        cellToDeselect.contentView.backgroundColor = UIColor.clear
    }
    
    
}

extension HomeViewController {
    
}


