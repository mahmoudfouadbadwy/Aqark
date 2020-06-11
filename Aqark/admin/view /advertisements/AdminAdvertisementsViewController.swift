//
//  AdminAdvertisementsViewController.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class AdminAdvertisementsViewController: UIViewController {
    
  
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var advertisementsCollectionView: UICollectionView!
    @IBOutlet weak var advertisementsSearchBar: UISearchBar!
    
    private var adminAdvertisementViewModel : AdminAdvertisementsListViewModel!
    private var dataAccess : AdminDataAccess!
    static var reportedAdvertisementId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataAccess = AdminDataAccess()
        adminAdvertisementViewModel = AdminAdvertisementsListViewModel(dataAccess:dataAccess)
        advertisementsSearchBar.backgroundColor = UIColor(rgb: 0xf1faee)
        advertisementsSearchBar.barTintColor = UIColor(rgb: 0xf1faee)
            view.backgroundColor = UIColor(rgb: 0xf1faee)
        if(adminAdvertisementViewModel.checkNetworkConnection()){
            showActivityIndicator()
            self.view.alpha = 0
            advertisementsCollectionView.register(UINib(nibName: "AdminAdvertisementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Advertisement Cell")
            advertisementsCollectionView.delegate = self
            advertisementsCollectionView.dataSource = self
            advertisementsSearchBar.delegate = self
            adminAdvertisementViewModel.populateAdvertisements {
                self.stopActivityIndicator()
                UIView.animate(withDuration:2) {
                    self.view.alpha = 1
                }
                if(self.adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                    self.setLabelForZeroCount(text: "No advertisements available")
                }
                self.advertisementsCollectionView.reloadData()
            }
        }else{
            noLabel.isHidden = false
            noLabel.text = "Internet Connection Not Available"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Advertisements"
        advertisementsSearchBar.isHidden = true
        if let reportedAdvertisementId = AdminAdvertisementsViewController.reportedAdvertisementId{
            adminAdvertisementViewModel.getFilteredAdvertisements(searchText: reportedAdvertisementId)
            advertisementsCollectionView.reloadData()
            if(adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
                setLabelForZeroCount(text: "Advertisement is deleted.")
            }
            AdminAdvertisementsViewController.reportedAdvertisementId = nil
              setLabelForZeroCount(text: "No advertisements available")
        }else{
            advertisementsCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)
            noLabel.isHidden = true
            advertisementsSearchBar.isHidden = false
            adminAdvertisementViewModel.getFilteredAdvertisements(searchText: "")
            advertisementsCollectionView.reloadData()
        }
    }
    
    private func setLabelForZeroCount(text:String){
        noLabel.isHidden = false
        noLabel.text = text
    }
    
    func showAlert(title:String,message:String){
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
         let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){(okAction) in
             alert.dismiss(animated: true, completion: nil)}
         alert.addAction(okAction)
         self.present(alert, animated: true, completion: nil)
     }
    
}
extension AdminAdvertisementsViewController : UICollectionViewDelegate,UICollectionViewDataSource,AdminAdvertisementsCollectionDelegate{
    
    func removeAdvertisementDelegate(at indexPath: IndexPath) {
        showAlert { (result) in
            if(result){
                self.advertisementsCollectionView.performBatchUpdates({
                    self.adminAdvertisementViewModel.deleteAdvertisement(adminAdvertisement: self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row]){(deleted) in
                        if(deleted){
                            self.adminAdvertisementViewModel.adminAdvertisementsViewList.remove(at: indexPath
                                .row)
                            self.advertisementsCollectionView.deleteItems(at: [indexPath])
                            self.showAlert(title: "Advertisement",message: "Advertisement deleted successfully")
                        }else{
                            self.showAlert(title: "Advertisement", message: "There is problem with deleting advertisement")
                        }
                    }
                    
                }) { (finished) in
                    self.advertisementsCollectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.adminAdvertisementViewModel.adminAdvertisementsViewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let advertisementCell = advertisementsCollectionView.dequeueReusableCell(withReuseIdentifier: "Advertisement Cell", for: indexPath) as! AdminAdvertisementCollectionViewCell
        advertisementCell.adminAdvertisementsDelegate = self
        advertisementCell.adminAdvertisementsCellIndex = indexPath
        advertisementCell.advertisementPropertyType.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyType
        advertisementCell.advertisementPropertyPrice.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyPrice
        advertisementCell.advertisementPropertyAddress.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyAddress
        advertisementCell.advertisementPropertySize.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertySize
        advertisementCell.advertisementPropertyBedNumbers.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyBedsNumber
        advertisementCell.advertisementPropertyBathRoomNumbers.text = self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyBathRoomsNumber
        let advertisementPropertyImageURL = URL(string:self.adminAdvertisementViewModel.adminAdvertisementsViewList[indexPath.row].advertisementPropertyImages[0])
        advertisementCell.advertisementPropertyImage.sd_setImage(with:advertisementPropertyImageURL , placeholderImage: UIImage(named: "NoImage"))
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
        return CGSize(width: collectionView.frame.width - 40, height: 150)
    }
}


extension AdminAdvertisementsViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        adminAdvertisementViewModel.getFilteredAdvertisements(searchText: searchText)
        advertisementsCollectionView.reloadData()
        if(self.adminAdvertisementViewModel.adminAdvertisementsViewList.isEmpty){
            self.setLabelForZeroCount(text: "No available advertisements")
        }else{
            noLabel.isHidden = true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


