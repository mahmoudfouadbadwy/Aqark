//
//  ReviewViewModel.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

class ReviewsViewModel{
    
       var dataAccess : ReviewData!
       var reviewModel: ReviewModel!
    var userModel : ReviewUserModel!
    var reviewsViewModel : [ReviewViewModel] = [ReviewViewModel]()
    
    

 
    init(dataAccess : ReviewData) {
          self.dataAccess = dataAccess
      }
    func setReviewData(reviewContent : String, advertisementId : String){
        reviewModel = ReviewModel(reviewContent: reviewContent,userId: self.getUserId(), advertisementId : advertisementId)
        dataAccess.addReview(reviewModel: reviewModel)
        }
    
    func getUserId()-> String{
        if let user = Auth.auth().currentUser{
            return user.uid
            
        }
       return ""
    }
   
  
    
    func checkUserAuth()-> Bool{
          if Auth.auth().currentUser != nil {
              return true
          }else{
              return false
          }
      }
    
    func populateAdvertisementReviews(id:String,completionForPopulateReviews : @escaping (_ reviewsResults:[ReviewViewModel]) -> Void){
        dataAccess.getAdvertisementReviews(id: id, completionForGetAllReviews:  { reviewsResults in
            self.reviewsViewModel = reviewsResults.map{ review in
                ReviewViewModel(reviewModel: review)
               }
            
            completionForPopulateReviews(self.reviewsViewModel)
           })
    }

    

      }
   
    

class ReviewViewModel
{
  
    var reviewContent : String!
    var userName : String!
    var userImage : String!
    
    init(reviewModel: ReviewModel) {
      
        self.reviewContent = reviewModel.reviewContent
        self.userName = reviewModel.userName
        self.userImage = reviewModel.userImage
    }
}
    
 

