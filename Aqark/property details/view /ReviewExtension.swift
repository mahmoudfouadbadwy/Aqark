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

            reviewMessage.isHidden = true
        }
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
        reviewMessage.isHidden = true
         bottomscrollView.constant = (keyboardHeight * 1)
        
        if propertyViewModel.checkAdvertisementOwner(agentId: advertisementDetails.userID) || !advertisementReviewViewModel.checkUserAuth(){
            addReviewBtn.isHidden = true
        }else{
            addReviewBtn.isHidden = false
             
        }
    }
    func manageAddReviewOutlets(){
        reviewMessage.isHidden = false
        
        
        
        addReviewContentTextView.becomeFirstResponder()
        addReviewContentTextView.layer.borderColor = UIColor(rgb: 0x1d3557).cgColor
        addReviewContentTextView.layer.borderWidth = 1.0
    }
    
}
