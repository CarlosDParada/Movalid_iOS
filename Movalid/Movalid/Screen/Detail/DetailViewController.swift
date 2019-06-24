//
//  DetailViewController.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
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
    var typeContent : String?
    var isTapped: Bool?
    
    /* Rx Swift */
    let viewModel = DetailViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeNavButton()
        self.stackGeners.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createCallbacks()
        stackGeners.reloadData()
        btnVideo.addTarget(self, action: #selector(actionBtnVideo), for: .touchUpInside)
    }
    //MARK: - RxSwift
    func createCallbacks (){
        
        viewModel.isErrorData.asObservable()
            .bind{ errorModel in
                if (errorModel.codeError != ErrorConnection.none ){
                    let messageAlert = MessageString.setupTextAlertLoading(by: errorModel)
                    let alertError : UIAlertController  =
                        UIAlertController.actionShowOneAction(by: "",
                                                              message: messageAlert,
                                                              button: MessageString.tryAgain) {_ in
                    }
                    self.present(alertError, animated: true, completion: nil)
                }else{
                    print("Success in \(errorModel.serviceName ?? "Empty")")
                }
            }.disposed(by: disposeBag)
        
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
        
        viewModel.isSuccessVideo.asObservable()
            .bind{videoObjec in
                if (((videoObjec) != nil)&&(self.isTapped == true)){
                    let video = videoObjec?.results?[0].key
                    self.loadVideoByKey(byKey:video ?? "")
                }else{
                    self.removeLoadingView()
                }
            }.disposed(by: disposeBag)
        
        viewModel.isLoading.asObservable().bind { value in
            if value {
                self.showLoadignView()
            }else{
                self.removeLoadingView()
            }
            }.disposed(by: disposeBag)

    }

     @objc func actionBtnVideo(sender: UIButton!) {
        if(self.filmShow?.id != nil){
            self.isTapped = true
            let idString = String(self.filmShow!.id!)
            self.viewModel.getVideoContent(by: self.typeContent!, stringKey: idString)
        }else{
            self.removeLoadingView()
        }
    }
    /* Video */
    func loadVideoByKey(byKey:String){
        
        let videoURL = URL(string: "http://www.youtube.com/watch?v=\(byKey)")
        let player = AVPlayer(url: videoURL!)
        let vc = AVPlayerViewController()
        vc.player = player
        
        present(vc, animated: true) {
            vc.player?.play()
            self.isTapped = false
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
