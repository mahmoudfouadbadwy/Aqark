//
//  PropertyDetailView.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import MapKit
import ReachabilitySwift
import JJFloatingActionButton
import Cosmos

class PropertyDetailView: UIViewController,UIActionSheetDelegate{
   
    @IBOutlet weak var ReviewHeight: NSLayoutConstraint!
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
    private let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
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
    var arrOfReviewsViewModel : [ReviewViewModel]!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Property Details"
        if checkNetworkConnection(){
            self.showIndicator()
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
        servicesView.serviceRole = "lawyer"
        self.navigationController?.pushViewController(servicesView, animated: true)
    }
    
    
    @IBAction func showInteriorDesigners(_ sender: Any) {
        let servicesView = ServicesViewController()
        servicesView.serviceRole = "interior designer"
        self.navigationController?.pushViewController(servicesView, animated: true)
    }
    


    //MARK: - check network connnection
   private func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
}

//MARK: - UIViewIndicator
extension PropertyDetailView{
   private func showIndicator()
    {
        networkIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    func stopIndicator() {
        networkIndicator.stopAnimating()
    }
}


