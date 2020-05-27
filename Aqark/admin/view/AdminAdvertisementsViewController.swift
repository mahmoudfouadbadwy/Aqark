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
        advertisementsSearchBar.delegate = self
        dataAccess = AdminDataAccessLayer()
        adminAdvertisementListViewModel = AdminAdvertisementsListViewModel(dataAccess:dataAccess)
        adminAdvertisementListViewModel.populateAdvertisements {
            self.advertisementsCollectionView.reloadData()
        }
    }
}

extension AdminAdvertisementsViewController : UICollectionViewDelegate,UICollectionViewDataSource,AdminAdvertisementsCollectionDelegate{
    
    func adminAdvertisementsCollectionDelegate(indexPath: IndexPath) {
        showAlert { (result) in
            if(result){
                self.advertisementsCollectionView.performBatchUpdates({
                    self.adminAdvertisementListViewModel.deleteAdvertisement(id: self.adminAdvertisementListViewModel.adminAdvertisementsViewList[indexPath.row].advertisementId)
                    self.adminAdvertisementListViewModel.adminAdvertisementsViewList.remove(at: indexPath
                        .row)
                    self.advertisementsCollectionView.deleteItems(at: [indexPath])
                }) { (finished) in
                    self.advertisementsCollectionView.reloadData()
                }
            }
        }
    }
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.adminAdvertisementListViewModel.adminAdvertisementsViewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let advertisementCell = advertisementsCollectionView.dequeueReusableCell(withReuseIdentifier: "Advertisement Cell", for: indexPath) as! AdminAdvertisementCollectionViewCell
        advertisementCell.adminAdvertisementsCollectionDelegate = self
        advertisementCell.adminAdvertisementsCellIndex = indexPath
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
    
    private func showAlert(completion:@escaping(Bool)->Void)
    {
        let alert:UIAlertController = UIAlertController(title: "Delete Adverisement", message: "Are You Sure You Want To Delete This Advertisement ?", preferredStyle: .actionSheet)
        let delete:UIAlertAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            completion(true)
        }
        let cancel:UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true)
            completion(false)
        }
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}

extension AdminAdvertisementsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 30 , height: collectionView.frame.height/3);
    }
}


extension AdminAdvertisementsViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        adminAdvertisementListViewModel.getFilteredAdvertisements(searchText: searchText)
        advertisementsCollectionView.reloadData()
    }
}


