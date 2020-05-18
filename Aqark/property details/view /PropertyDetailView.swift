//
//  PropertyDetailView.swift
//  Aqark
//
//  Created by Mostafa Samir on 5/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
import ReachabilitySwift

class PropertyDetailView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var AmenitiesCollectionView: UICollectionView!
    @IBOutlet weak var imageMapView: UIImageView!
    @IBOutlet weak var makeCall: UIButton!
    @IBOutlet weak var scrollImage: UIScrollView!
    @IBOutlet weak var agentCompany: UILabel!
    @IBOutlet weak var agentName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var dascription: UITextView!
    @IBOutlet weak var report: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var fullType: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var bedroom: UILabel!
    @IBOutlet weak var bathroom: UILabel!
    @IBOutlet weak var wholeView: UIScrollView!
    @IBOutlet weak var noNetConnection: UIView!
    
    var images = [UIImage]()
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var phoneNum:String=""
    var lonitude:String=""
    var latitude:String=""
    var locationn:String=""
    var fullDate:String=""
    var apartmenTypetForCall:String=""
    var arrayOfImages:[String]!
    private let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private var propertyViewModel : PropertyDetailViewModel!
    private var propertyDataAccess : PropertyDetailDataAccess!
    var adviewmodel:AdverisementViewModel!
    var adOfViewModel : [AdverisementViewModel]?{
        didSet{
            self.AmenitiesCollectionView.reloadData()
            stopIndicator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !checkNetworkConnection(){
            wholeView.isHidden = true
            makeCall.isHidden = true
            noNetConnection.isHidden = false
            
        }else{
            self.showIndicator()
            self.AmenitiesCollectionView.register(UINib(nibName: "AmenitiesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
            setUpButtonCallPhonConstraints()
            self.propertyDataAccess = PropertyDetailDataAccess()
            self.propertyViewModel = PropertyDetailViewModel(propertyDataAccess: self.propertyDataAccess)
            propertyViewModel.populateAdvertisement{(dataResult) in
                self.adOfViewModel = dataResult
                
                self.setUpPropertyDetailView()
                self.setImageMap()
                self.setScrollImage()
            }
        }
    }
    
    // MARK: - check network connnection
    
    func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }

     // MARK: - SetUp View Data
    
    func setUpPropertyDetailView(){
        self.adviewmodel = adOfViewModel![0]
        self.size.text = "\(adviewmodel.propertysize ?? "size") sqm"
        self.price.text = "\(adviewmodel.price ?? "price") EGP"
        self.apartmenTypetForCall=adviewmodel.propertyType
        self.type.text = self.apartmenTypetForCall
        self.fullDate = adviewmodel.date
        let fullDateArray = fullDate.components(separatedBy: " ")
        self.hours.text = fullDateArray[0]
        self.bathroom.text = adviewmodel.bathroom
        self.bedroom.text = adviewmodel.bedroom
        self.dascription.text = adviewmodel.description
        self.address.text = adviewmodel.location
        self.arrayOfImages = adviewmodel.images
        self.phoneNum = adviewmodel.phone
        self.lonitude = adviewmodel.longitude
        self.latitude = adviewmodel.latitude
        self.locationn = adviewmodel.location
        self.fullType.text = "\(adviewmodel.propertyType ?? "Apartment") for \(adviewmodel.advertismentType ?? "Rent") in \(String(describing: adviewmodel.country ?? "Damiette"))"
        self.AmenitiesCollectionView.reloadData()
  
    }
    
    // MARK: - Button constraint and Call Tha ad Owner
    
    func setUpButtonCallPhonConstraints(){
        let buttonBottomConstraint = NSLayoutConstraint(item: makeCall, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraint(buttonBottomConstraint)
    }

    func makePhoneCall(phoneNumber: String) {
        if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {
            let alert = UIAlertController(title: (" Call The \(apartmenTypetForCall) Owner ? "), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func callSomeone(_ sender: Any) {
        
        makePhoneCall(phoneNumber: self.phoneNum)
    }
   
    // MARK: - Make Scroll Image View
    
    func setScrollImage(){
        scrollImage.showsHorizontalScrollIndicator = true
        scrollImage.isPagingEnabled = true
        for index in 0..<arrayOfImages.count {
            frame.origin.x = scrollImage.frame.size.width * CGFloat(index)
            frame.size = scrollImage.frame.size
            let imageView = UIImageView(frame: frame)
         imageView.sd_setImage(with: URL(string: arrayOfImages[index]), placeholderImage: nil)
            self.scrollImage.addSubview(imageView)
        }
        scrollImage.contentSize = CGSize(width: scrollImage.frame.size.width * CGFloat(images.count), height: scrollImage.frame.size.height)
        self.scrollImage?.delegate = self as UIScrollViewDelegate
    
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
    
    // MARK: - Make Clickable image and Map Action
    
    func setImageMap(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageMapView.isUserInteractionEnabled = true
        imageMapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let lat = Double(self.latitude)
        let long = Double(self.lonitude)
        let coordinate = CLLocationCoordinate2D(latitude:lat!, longitude:long!)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02))
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = self.locationn
        mapItem.openInMaps(launchOptions: options)
        
    }

  // MARK: - Make collection view functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let array = self.adOfViewModel{
            self.adviewmodel = array[0]
            return self.adviewmodel.amenities.count
            }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AmenitiesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AmenitiesCollectionViewCell
        self.adviewmodel = adOfViewModel![0]
        cell.AmenitiesType.text = self.adviewmodel.amenities[indexPath.row]
        
        switch cell.AmenitiesType.text {
        case "Balcony":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Balacony")
        case "Covered Parking":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Covered Parking")
        case "Barbecue Area":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Barbecue")
        case "Central A/C":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Central")
        case "kitchen":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_children")
        case "Furnished":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Furnished")
        case "Private Garden":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_garden")
        case "kitchen Appliances":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_kitchen")
        case "Maids Room":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Maids room")
        case "Networked":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_networked")
        case "Pets Allowed":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Pets")
        case "Security":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Security")
        case "Shared Spa":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_shared spa")
        case "Study":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_study")
        case "Walk-in Closet":
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Walk")
       
        default:
            cell.AmenitiesImage?.image = UIImage(named: "PropertyDetail_Furnished")
        }
        
        return cell
    }
  
//MARK: - Make row of collection has 2 cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width:AmenitiesCollectionView.frame.width/2,height:AmenitiesCollectionView.frame.height/2)
    }
    
}

//MARK: - UIViewIndicator
extension PropertyDetailView{
    func showIndicator()
    {
        self.wholeView.isHidden=true
        self.makeCall.isHidden=true
        networkIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    
    func stopIndicator() {
        self.wholeView.isHidden=false
        self.makeCall.isHidden=false
        networkIndicator.stopAnimating()
    }
}
