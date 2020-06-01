//
//  ReviewExtension.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension PropertyDetailView {
    func addReview(){
         
        advertisementReviewViewModel = ReviewsViewModel(dataAccess: reviewData)
        if !addReviewContentTextView.text.isEmpty{
        self.advertisementReviewViewModel.setReviewData(reviewContent: addReviewContentTextView.text, advertisementId : advertisementId)
            addReviewContentTextView.text = ""
            ReviewHeight.constant = 0
            submitReviewBtn.isHidden = true
        }
    }

    func setUpReviewsCollectionView()
      {
           reviewsCollectionView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
        
      }
    func manageReviewAppearence(){
          ReviewHeight.constant = 0
        submitReviewBtn.isHidden = true
        if propertyViewModel.checkAdvertisementOwner(agentId: advertisementDetails.userID) || !advertisementReviewViewModel.checkUserAuth(){
        addReviewBtn.isHidden = true
        }else{
            addReviewBtn.isHidden = false
        }
    }
    func manageAddReviewOutlets(){
          ReviewHeight.constant = 136
        submitReviewBtn.isHidden = false
        
        
    }

}
