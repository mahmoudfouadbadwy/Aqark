//
//  ReviewExtension.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension PropertyDetailView {
    func addReview(reviewText : String){
        advertisementReviewViewModel = ReviewsViewModel(dataAccess: reviewData)
        self.advertisementReviewViewModel.setReviewData(reviewContent: reviewText, advertisementId : advertisementId)
    }
    
    func setUpReviewsCollectionView()
    {
        reviewsCollectionView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
        reviewsCollectionView.backgroundColor = UIColor(rgb: 0xf1faee)
        
    }
    
    func bindReviewData(){
        self.reviewData = ReviewData()
        self.advertisementReviewViewModel = ReviewsViewModel(dataAccess: self.reviewData)
        self.manageReviewAppearence()
        self.advertisementReviewViewModel.populateAdvertisementReviews(id: self.advertisementId, completionForPopulateReviews: {[weak self] reviewsResults in
            self?.arrOfReviewsViewModel = reviewsResults
            self?.reviewsCollectionView.reloadData()
        })
    }
    func manageReviewAppearence(){
        if propertyViewModel.checkAdvertisementOwner(agentId: advertisementDetails.userID) || !advertisementReviewViewModel.checkUserAuth(){
            addReviewBtn.isHidden = true
        }else{
            addReviewBtn.isHidden = false
             
        }
    }
    func manageAddReviewOutlets(){
     
        let alert = UIAlertController(title: "Add Review", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.height(30)
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if textField?.text?.isEmpty == false{
                self.addReview(reviewText : (textField?.text)!)
            }
        }))
        alert.addAction(UIAlertAction(title: "cancle", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
