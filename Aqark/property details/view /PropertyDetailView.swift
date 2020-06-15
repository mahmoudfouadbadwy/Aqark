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
    @IBOutlet weak var amenitiesHeader: UILabel!
    @IBOutlet weak var cancelReview: UIButton!
    @IBOutlet weak var reviewSection: UIView!
    @IBOutlet weak var descriptionSection: UIView!
    @IBOutlet weak var agentSection: UIView!
    @IBOutlet weak var servicesSection: UIView!
    @IBOutlet weak var amenitiesSection: UIView!
    @IBOutlet weak var propertiesSection: UIView!
    @IBOutlet weak var locationSection: UIView!
    @IBOutlet weak var viewsSection: UIView!
    @IBOutlet weak var specificationSection: UIView!
    @IBOutlet weak var inputStack: UIStackView!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var agentTitle: UILabel!
    @IBOutlet weak var porperties: UIButton!
    @IBOutlet weak var interiorDesigner: UIButton!
    @IBOutlet weak var lawyers: UIButton!
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
    var favButton : UIButton!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        if PropertyDetailsNetworking.checkNetworkConnection(){
            self.showActivityIndicator()
            self.propertyDataAccess = PropertyDetailDataAccess()
            self.propertyViewModel = PropertyDetailViewModel(propertyDataAccess: self.propertyDataAccess)
            propertyViewModel.populateAdvertisement(id: advertisementId) {[weak self] (advertisement,agent) in
                self?.advertisementDetails = advertisement
                self?.agent = agent
                self?.bindAdvertisementData()
                self?.setUpReviewsCollectionView()
                self?.bindReviewData()
            }
            setupFavoriteButton()
            setupCoredata()
            checkIfFavourite()
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
        servicesView.serviceRole = "Lawyers".localize
        servicesView.advertisementCountry = advertisementDetails.country
        servicesView.advertisementLocation = advertisementDetails.location
        self.navigationController?.pushViewController(servicesView, animated: true)
    }
    
    @IBAction func showInteriorDesigners(_ sender: Any) {
        let servicesView = ServicesViewController()
        servicesView.serviceRole = "Interior Designers".localize
        servicesView.advertisementCountry = advertisementDetails.country
        servicesView.advertisementLocation = advertisementDetails.location
        self.navigationController?.pushViewController(servicesView, animated: true)
    }
    
    
    @IBAction func cancelReview(_ sender: Any) {
        
        inputStack.isHidden = true
        
    }
    
    
   private func setupViews()
    {
        self.navigationItem.title = "Property Details".localize
        lawyers.setTitleColor(UIColor(rgb: 0x1d3557), for: .normal)
        interiorDesigner.setTitleColor(UIColor(rgb: 0x1d3557), for: .normal)
        porperties.setTitleColor(UIColor(rgb: 0x1d3557), for: .normal)
        locationTitle.textColor = UIColor(rgb: 0x457b9d)
        agentTitle.textColor = UIColor(rgb: 0x457b9d)
        descriptionTitle.textColor = UIColor(rgb: 0x457b9d)
        reviewHeaderLabel.textColor = UIColor(rgb: 0x457b9d)
        specificationSection.backgroundColor = UIColor(rgb: 0xf1faee)
        viewsSection.backgroundColor = UIColor(rgb: 0xf1faee)
        locationSection.backgroundColor = UIColor(rgb: 0xf1faee)
        propertiesSection.backgroundColor = UIColor(rgb: 0xf1faee)
        amenitiesSection.backgroundColor = UIColor(rgb: 0xf1faee)
        agentSection.backgroundColor = UIColor(rgb: 0xf1faee)
        servicesSection.backgroundColor = UIColor(rgb: 0xf1faee)
        descriptionSection.backgroundColor = UIColor(rgb: 0xf1faee)
        reviewSection.backgroundColor = UIColor(rgb: 0xf1faee)
        amenitiesCollection.backgroundColor = UIColor(rgb: 0xf1faee)
        amenitiesHeader.textColor = UIColor(rgb: 0x457b9d)
    }
    
    
   private func setupFavoriteButton()
    {
        favButton = UIButton(type: .custom)
        favButton.setImage(UIImage(named: "heart"), for: .normal)
        favButton.addTarget(self, action: #selector(toogleFavorite), for: .touchUpInside)
        
        favButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        let barButton = UIBarButtonItem(customView: favButton)
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    deinit{
        print ("details deinit")
    }
}




