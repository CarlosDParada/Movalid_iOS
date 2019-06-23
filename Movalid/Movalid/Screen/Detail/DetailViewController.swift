//
//  DetailViewController.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewController: BaseViewController {

    @IBOutlet weak var imgGeneral: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var stackGeners: UICollectionView!
    @IBOutlet weak var txtResumen: UITextView!
    
    var filmShow : Film?
    
    /* Rx Swift */
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeNavButton()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createCallbacks()
        
    }
    //MARK: - RxSwift
    func createCallbacks (){
        btnGoBack.rx.tap
            .bind{
                let goToVC : UINavigationController = NavigationExtension.homeViewController()
                self.present(goToVC, animated: true) {
                    self.removeFromParent()
                }
            }.disposed(by: disposeBag)
        imgGeneral.cacheImage(urlString: WebService.urlImage + (filmShow?.poster_path)! )
        lblTitle.text = filmShow?.title
        lblDate.text = filmShow?.release_date
        txtResumen.text = filmShow?.overview
    }

}

extension DetailViewController :  UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmShow?.genre_ids!.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : GenersCollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.detailCollectIdentifier,
                                               for: indexPath) as! GenersCollectionViewCell
        let generSingle = filmShow?.genre_ids![indexPath.row]
        cell.setupByContent(by: generSingle ?? 0)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 20)
    }
    
    private func collectionView(collectionView: UICollectionView, didDeselectItemAt indexPath: NSIndexPath) {
        let cellToDeselect:UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath )!
        cellToDeselect.contentView.backgroundColor = UIColor.clear
    }
    
    
}
