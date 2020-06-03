//
//  PropertyDetailView.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import MapKit
import JJFloatingActionButton
import Cosmos

class PropertyDetailView: UIViewController,UIActionSheetDelegate{
   

   
    @IBOutlet weak var inputStack: UIStackView!
    @IBOutlet weak var addReviewContentTextView: UITextView!
    
    @IBOutlet weak var submitReviewBtn: UIButton!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var addReviewBtn: UIButton!
    @IBOutlet weak var reviewHeaderLabel: UILabel!
  
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var amenitiesTopSpace: NSLayoutConstraint!
    @IBOutlet weak var amenitiesHeight: NSLayoutConstraint!
    @IBOutlet weak var userRate: CosmosView!
    @IBOutlet weak var advertisementDescription: UITextView!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var amenitiesCollection: UICollectionView!
    @IBOutlet weak var bathrooms: UILabel!
    @IBOutlet weak var bedrooms: UILabel!
    @IBOutlet weak var propertySize: UILabel!
    @IBOutlet weak var propertyType: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var specification: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var dateOfAdvertisement: UILabel!
    @IBOutlet weak var numberOfViews: UILabel!
    @IBOutlet weak var imageSlider: ImageSlider!
    var propertyViewModel : PropertyDetailViewModel!
    var propertyDataAccess : PropertyDetailDataAccess!
    var advertisementDetails:AdverisementViewModel!
    var advertisementReportViewModel: ReportViewModel!
    var reviewData: ReviewData!
    var advertisementReviewViewModel: ReviewsViewModel!
    var reviewViewModel :ReviewViewModel!
    var reportData: ReportData!
    var agent:AgentViewModel!
    var advertisementId:String!
    var downloadedImages:[UIImage] = []
    let callButton = JJFloatingActionButton()

     var coreDataViewModel: CoreDataViewModel?
    var arrOfReviewsViewModel : [ReviewViewModel]!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Property Details"
        if PropertyDetailsNetworking.checkNetworkConnection(){
            self.showActivityIndicator()
            self.propertyDataAccess = PropertyDetailDataAccess()
            self.propertyViewModel = PropertyDetailViewModel(propertyDataAccess: self.propertyDataAccess)
            propertyViewModel.populateAdvertisement(id: advertisementId) {[weak self] (advertisement,agent) in
                self?.advertisementDetails = advertisement
                self?.agent = agent
                self?.reviewData = ReviewData()
                self?.bindAdvertisementData()
                self?.setUpReviewsCollectionView()
                self?.advertisementReviewViewModel = ReviewsViewModel(dataAccess: self!.reviewData)
                self?.manageReviewAppearence()
                self?.advertisementReviewViewModel.populateAdvertisementReviews(id: self!.advertisementId, completionForPopulateReviews: { reviewsResults in
                    self?.arrOfReviewsViewModel = reviewsResults
                    self!.reviewsCollectionView.reloadData()
                      })

                }
        }
        else{
            content.isHidden = true
        }
    }
    @IBAction func showMap(_ sender: Any) {
        let lat = Double(self.advertisementDetails.latitude)
        let long = Double(self.advertisementDetails.longitude)
        let coordinate = CLLocationCoordinate2D(latitude:lat!, longitude:long!)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02))
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = self.advertisementDetails.location
        mapItem.openInMaps(launchOptions: options)
    }
    

    @IBAction func addReviewBtn(_ sender: Any) {
        manageAddReviewOutlets()
    }
    
    @IBAction func submitReview(_ sender: Any) {
        addReview()
    }
    
    @IBAction func showReportActionSheet(_ sender: Any) {
        preformReport()
    }


    @IBAction func openPropertiesView(_ sender: Any) {
        let properties = AgentPropertiesView()
        properties.agentId =  advertisementDetails.userID
        properties.agentName = agent.username
        self.navigationController?.pushViewController(properties, animated: true)
        
    }

    @IBAction func showLawyers(_ sender: Any) {
        let servicesView = ServicesViewController()
        servicesView.serviceRole = "Lawyers"
        servicesView.advertisementCountry = advertisementDetails.country
        self.navigationController?.pushViewController(servicesView, animated: true)
    }
    
    @IBAction func showInteriorDesigners(_ sender: Any) {
        let servicesView = ServicesViewController()
        servicesView.serviceRole = "Interior Desigenrs"
         servicesView.advertisementCountry = advertisementDetails.country
        self.navigationController?.pushViewController(servicesView, animated: true)
    }


    @IBAction func cancelReview(_ sender: Any) {
        
        inputStack.isHidden = true
        
    }
    
  
}




