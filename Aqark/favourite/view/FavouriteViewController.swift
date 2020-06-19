//
//  FavouriteViewController.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit


class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    @IBOutlet weak var labelPlaceHolder: UILabel!
    var coreDataViewModel: CoreDataViewModel!
    var adViewModel: FavouriteViewModel!
    var favouriteListViewModel:FavouriteListViewModel!
    var favouriteDataAccess : FavouriteDataAccess!
    var coreDataAccess : CoreDataAccess!
    var alert : UIAlertController!
    var propertyDetailVC : PropertyDetailView!

    var arrOfAdViewModel:[FavouriteViewModel]! = []{
        didSet{
            if arrOfAdViewModel.count == 0{
                setEmptyAdvertisments(flag: false)
            }else{
                setEmptyAdvertisments(flag: true)
            }
            self.favouriteCollectionView.reloadData()
        }
    }
    
    var adsCount:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourite".localize
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        favouriteCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if !FavoriteNetworking.checkNetworkConnection(){
            favouriteCollectionView.isHidden = true
            labelPlaceHolder.text = "Internet Connection Not Available".localize
        }else{
            labelPlaceHolder.isHidden = true
            setupObjects()
            getCollectionViewData()
        }
    }
    
    func showDeletedAdsAlert(){
        if (adsCount != 0){
            var message = ""
            if "lang".localize == "en" {
                if adsCount == 1{
                    message = "There is " + self.convertNumbers(lang: "lang".localize, stringNumber: String(adsCount)).1 + " Advertisment deleted from your Favourite List"
                         }else{
                     message = "There are " + self.convertNumbers(lang: "lang".localize, stringNumber: String(adsCount)).1 + " Advertisments deleted from your Favourite List"
                }
            }else{
                if adsCount == 1{
                    message = "لقد تم حذف إعلان من القائمة المفضلة"
                }else {
                    message = "لقد تم حذف " + self.convertNumbers(lang: "lang".localize, stringNumber: String(adsCount)).1 + "إعلان من القائمة المفضلة"
                    
                }
                
            }
            alert = UIAlertController(title: nil , message:message , preferredStyle: .alert)
            
            
            alert.addAction(UIAlertAction(title: "Ok".localize, style: .cancel, handler: nil))

            self.present(alert, animated: true, completion: nil)
            adsCount=0
        }
    }
    
    func setupObjects(){
        favouriteDataAccess = FavouriteDataAccess()
        coreDataAccess = CoreDataAccess()
        
        favouriteListViewModel = FavouriteListViewModel(dataAccess: favouriteDataAccess)
        coreDataViewModel = CoreDataViewModel(dataAccess:coreDataAccess )
    }
    
    func setEmptyAdvertisments(flag: Bool){
        self.labelPlaceHolder.isHidden = flag
        self.labelPlaceHolder.text = "There is no advertisements in favourite list.".localize
    }
 
    override func viewWillDisappear(_ animated: Bool) {

        if favouriteListViewModel != nil {
            favouriteListViewModel.removeFavObserver()
        }
        coreDataViewModel = nil
        adViewModel = nil
        favouriteListViewModel = nil
        favouriteDataAccess = nil
        coreDataAccess = nil
        alert = nil
        propertyDetailVC = nil
    }
   

}
