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
    func populateAdvertisement(id:String){
           dataAccess.getAdvertisementReviews(id: id)
       }
}

class AgentViewModel
{
    var username:String!
    var company:String!
    var rate:Double!
    
    init(agent:Agent) {
        self.username = agent.name
        self.company = agent.company
        self.rate = agent.rate
    }
