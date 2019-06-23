//
//  ViewController.swift
//  Movalid
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource{

    
    @IBOutlet weak var segmentTypeContent: UISegmentedControl!
    @IBOutlet weak var segmentCategory: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
         self.title = "MOVALID"
       buildNavButtons()
        
    }
    func LoadParameters() {
        segmentTypeContent.selectedSegmentIndex = IntContent.movie
        HandlerData.updateTypeContent(by: IntContent.movie)
        segmentCategory.selectedSegmentIndex = IntCategory.popular
        HandlerData.updateCategoryContent(by: IntCategory.popular)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HandlerData.getContentBySituation().count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ContentHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.homeCellIdentifier, for: indexPath) as! ContentHomeTableViewCell
        cell.setupByContent(by: HandlerData.getContentBySituation()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let tableViewCell = cell as? ContentHomeTableViewCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
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
