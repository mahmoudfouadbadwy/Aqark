//
//  ReviewData.swift
//  Aqark
//
//  Created by Shorouk Mohamed on 5/30/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import Firebase

class ReviewData{
    var dataBaseRef: DatabaseReference!
    var newReview : [String : String] = [String : String]()
    var reviewModel: ReviewModel!
    var idAutoGenerator :String!
    var advertisementReviewContent : String!
    var userId : String!
    var userName : String!
    var userImage : String!
    var reviewsData = [ReviewModel]()
    var userData : ReviewUserModel!
    var userDetailsDictionary:  [String : Any]!
    var emptyReviewModelArr :[ReviewModel] = [ReviewModel]()
    
    
    func addReview(reviewModel : ReviewModel){
        dataBaseRef = Database.database().reference()
        idAutoGenerator = dataBaseRef.childByAutoId().key!
        getUserDetails(id: reviewModel.userId) { userResults in
            self.newReview = [
                       "ReviewContent": reviewModel.reviewContent,
                       "UserId": reviewModel.userId,
                       "UserName" : userResults.userName,
                       "UserImage" : userResults.userImage
                   ]
            self.dataBaseRef.child("Advertisements").child(reviewModel.advertisementId).child("Reviews").child(self.idAutoGenerator!).setValue(self.newReview)

        }
       
    }
    
    func getAdvertisementReviews(id :String,completionForGetAllReviews : @escaping (_ reviewsResults:[ReviewModel]) -> Void){
        let ref = Database.database().reference()
        ref.child("Advertisements").child(id).child("Reviews").observe(.value, with: { (snapshot) in
            self.reviewsData.removeAll()
            if snapshot.exists()
            {
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    let dict = child.value as? [String : Any]
               
                    if let reviewsDictionary = dict {
                        self.advertisementReviewContent = reviewsDictionary["ReviewContent"] as? String ?? ""
                        self.userId = reviewsDictionary["UserId"] as? String ?? ""
                        self.userName = reviewsDictionary["UserName"] as? String ?? ""
                        self.userImage = reviewsDictionary["UserImage"] as? String ?? ""
                        self.reviewsData.append( ReviewModel(reviewContent: self.advertisementReviewContent, userId: self.userId, advertisementId: id,userName: self.userName ,userImage: self.userImage ))
                    }
                  
                }
                 completionForGetAllReviews(self.reviewsData)

            }else{
              completionForGetAllReviews([])
            }
            
        })
    }
    func getUserDetails(id :String,completionForName : @escaping (_ userResults: ReviewUserModel) -> Void){
        
        let ref = Database.database().reference()
        ref.child("Users").child(id).observe(.value, with: { (snapshot) in
            if snapshot.exists()
            {
                let dict = snapshot.value as? [String : Any]
                if let unwrappedReviewsDict = dict {
                    self.userDetailsDictionary = unwrappedReviewsDict
                    self.userName = self.userDetailsDictionary["username"] as? String ?? ""
                    self.userImage = self.userDetailsDictionary["picture"] as? String ?? "NoImage"
                    self.userData = ReviewUserModel(userName: self.userName,userImage: self.userImage)
                }else{
                    self.userData = ReviewUserModel(userName: "",userImage: "")

                }
                  completionForName(self.userData)
            }
        })
    }
}
