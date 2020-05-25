//
//  AdminAdvertisementsViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminAdvertisementsViewController: UIViewController {

    @IBOutlet weak var advertisementsCollectionView: UICollectionView!
    @IBOutlet weak var advertisementsSearchBar: UISearchBar!
    
    private var adminAdvertisementListViewModel : AdminAdvertisementsListViewModel!
    private var dataAccess : AdminDataAccessLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        advertisementsCollectionView.register(UINib(nibName: "AdminAdvertisementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Advertisement Cell")
        advertisementsCollectionView.delegate = self
        advertisementsCollectionView.dataSource = self
    
        dataAccess = AdminDataAccessLayer()
        adminAdvertisementListViewModel = AdminAdvertisementsListViewModel(dataAccess:dataAccess)
        adminAdvertisementListViewModel.populateAdvertisements {
            print(self.adminAdvertisementListViewModel.adminAdvertisementsViewList[0].advertisementPropertyPrice)
            self.advertisementsCollectionView.reloadData()
        }
    }
}

extension AdminAdvertisementsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.adminAdvertisementListViewModel.adminAdvertisementsViewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let advertisementCell = advertisementsCollectionView.dequeueReusableCell(withReuseIdentifier: "Advertisement Cell", for: indexPath) as! AdminAdvertisementCollectionViewCell
        advertisementCell.advertisementPropertyType.text = self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyType
        advertisementCell.advertisementPropertyPrice.text = self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyPrice
        advertisementCell.advertisementPropertyAddress.text = self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyAddress
        advertisementCell.advertisementPropertySize.text = self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertySize
        advertisementCell.advertisementPropertyBedNumbers.text = self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyBedsNumber
        advertisementCell.advertisementPropertyBathRoomNumbers.text = self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyBathRoomsNumber
        if(self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyImages.isEmpty){
            let advertisementPropertyImageURL = URL(string: "https://image.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg")
            advertisementCell.advertisementPropertyImage.sd_setImage(with:advertisementPropertyImageURL , placeholderImage: UIImage(named: "signup_company"))
        }else{
            let advertisementPropertyImageURL = URL(string:self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyImages[0])
            advertisementCell.advertisementPropertyImage.sd_setImage(with:advertisementPropertyImageURL , placeholderImage: UIImage(named: "signup_company"))
        }
        return advertisementCell
    }
}

extension AdminAdvertisementsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 30 , height: collectionView.frame.height/3);
    }
}


