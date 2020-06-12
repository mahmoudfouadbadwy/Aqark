//
//  AdminAdvertisementDelete.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 6/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import UIKit

extension AdminAdvertisementsViewController : AdminAdvertisementsCollectionDelegate{

func removeAdvertisementDelegate(at indexPath: IndexPath) {
    showAlert { (result) in
        if(result){
            if(self.adminAdvertisementViewModel.checkNetworkConnection()){
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
                }){ (finished) in
                    self.advertisementsCollectionView.reloadData()
                }
            }else{
                self.showAlert(title: "Connection".localize, message: "Internet Connection Not Available".localize)
            }
        }
    }
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
