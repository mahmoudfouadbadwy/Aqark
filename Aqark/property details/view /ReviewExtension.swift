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
            inputStack.isHidden = true
            submitReviewBtn.isHidden = true
        }
    }
    
    func setUpReviewsCollectionView()
    {
        reviewsCollectionView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
        
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
        inputStack.isHidden = true
        submitReviewBtn.isHidden = true
        if propertyViewModel.checkAdvertisementOwner(agentId: advertisementDetails.userID) || !advertisementReviewViewModel.checkUserAuth(){
            addReviewBtn.isHidden = true
        }else{
            addReviewBtn.isHidden = false
        }
    }
    func manageAddReviewOutlets(){
        inputStack.isHidden = false
        submitReviewBtn.isHidden = false
        addReviewContentTextView.layer.cornerRadius = 20
        
    }
    
}
