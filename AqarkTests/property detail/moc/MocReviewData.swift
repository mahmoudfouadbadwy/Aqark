//
//  MocReviewData.swift
//  AqarkTests
//
//  Created by Mostafa Samir on 6/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
@testable import Aqark

class MocReviewData {
    
    let review1=["334455":
        ["ReviewContent":"ReviewContent zeynab",
         "UserId":"010215684",
         "UserImage":" ",
         "UserName":"zeynab"]]
    let review2=["112233":
        ["ReviewContent":"ReviewContent yazan",
         "UserId":"010215684",
         "UserImage":" ",
         "UserName":"yazan"]]
    let agent=["334455":
        ["country":"Giza",
         "company":"iti",
         "email":"z@gmail.com",
         "experience":"1",
         "phone":"010215684",
         "role":"user",
         "picture":" ",
         "username":"zeynab",
         "rate":["":0.0] ]]
    
    let reviews = [review1,review2]
    let reviewsArray: [ReviewModel]=[]
    
    func getAdvertisementReviews(id :String,completionForGetAllReviews : @escaping (_ reviewsResults:[ReviewModel]) -> Void){
        
            if reviews.count != 0
            {
                for review in reviews {
                        let advertisementReviewContent = review["ReviewContent"] as? String ?? ""
                        let userId = review["UserId"] as? String ?? ""
                        let userName = review["UserName"] as? String ?? ""
                        let userImage = review["UserImage"] as? String ?? ""
                        reviewsArray.append( ReviewModel(reviewContent: advertisementReviewContent, userId: userId, advertisementId: id,userName: userName ,userImage: userImage ))
                }
                completionForGetAllReviews(reviewsArray)
                
            }else{
                completionForGetAllReviews([])
            }
            
    }
    
    func getUserDetails(id :String,completionForName : @escaping (_ userResults: ReviewUserModel) -> Void){
        
        if id != nil
        {
            let userName = agent["username"] as? String ?? ""
            let userImage = agent["picture"] as? String ?? "NoImage"
            let userData = ReviewUserModel(userName: self.userName,userImage: self.userImage)
        }else{
            self.userData = ReviewUserModel(userName: "",userImage: "")
            
        }
        completionForName(self.userData)
        
    }
}
