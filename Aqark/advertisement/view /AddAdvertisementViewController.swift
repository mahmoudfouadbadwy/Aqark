//
//  AddAdvertisementViewController.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import YPImagePicker
import GooglePlaces
import SDWebImage

class AddAdvertisementViewController: UIViewController  {
    @IBOutlet weak var amenitiesTitle: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var sizeTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var BedroomsTxtField: UITextField!
    @IBOutlet weak var BathroomTxtField: UITextField!
    @IBOutlet weak var countyTxtField: UITextField!
    @IBOutlet weak var describtionTxtView: UITextView!
    @IBOutlet weak var saveAndEditButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var bedRoomStepper: UIStepper!
    @IBOutlet weak var bathRoomStepper: UIStepper!
    @IBOutlet var amentiesButton: [UIButton]!
    var config = YPImagePickerConfiguration()
    var addAdvertisementVM: AddAdvertisementViewModel!
    var activityIndicator:UIActivityIndicatorView!
    var selectAmenitiesDic:[Int: String] = [Int:String]()
    var pickerViewPropertyType:[String] = [String]()
    var advertisementType:String = "Rent".localize
    var propertyType:String = "Apartment"
    var numberOfAdvertisementPerMonth:Int!
    var payment = "free"
    var latitude : String = ""
    var longitude : String = ""
    var advertisementId = ""
    var selectedImages : [Data] = [Data]()
    var urlImages : [String] = [String]()
    var urlImageDeleted:[String]=[String]()
    var editAdvertisementDataSource :EditAdvertisementDataSource!
    var dateOfAdvertisement:String!
    var autocompletecontroller = GMSAutocompleteViewController()
    var filter = GMSAutocompleteFilter()
    @IBOutlet weak var blackIndicatorView: UIView!
    @IBOutlet weak var myView: UIView!
    
    //MARK:- viewdidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupView()
        // for edit view
        if(advertisementId.isEmpty == false)
        {
            reloadViewData()
        }
        setupNotificationCenter()
    }
    //MARK:- view will Apper
    override func viewWillAppear(_ animated: Bool)
    {
        updatePlaceholderForPriceTextFeild()
    }
    
    // show view to select countries
    @IBAction func showCounties(_ sender: Any)
    {
        countryView.isHidden = false
        scrollView.isScrollEnabled = false
    }
    @IBAction func selectCountryAndHideStack(_ sender: UIButton) {
        countryView.isHidden = true
        countyTxtField.text = sender.titleLabel?.text
        priceTxtField.becomeFirstResponder() // used to jump to next text feild
        scrollView.isScrollEnabled = true
    }
    // select address to open google autocomplete
    @IBAction func addAutoCompleteAddress(_ sender: Any) {
        filter.type = .address  //suitable filter type
        filter.country = "eg"  //appropriate country code
        autocompletecontroller.autocompleteFilter = filter
        addressTxtField.resignFirstResponder()
        present(autocompletecontroller, animated: true, completion: nil)
    }
    @IBAction func increaseBedRoomNumber(_ sender: UIStepper) {
        self.BedroomsTxtField.text = convertNumbers(lang: "lang".localize, stringNumber: String(Int(sender.value))).1
    }
    @IBAction func increaseBathRoomNumber(_ sender: UIStepper) {
        self.BathroomTxtField.text = convertNumbers(lang: "lang".localize, stringNumber: String(Int(sender.value))).1
    }
    //MARK: - func SaveButton
    @IBAction func saveAdvertisement(_ sender: Any) {
        addAdvertisementVM = AddAdvertisementViewModel(payment:self.payment,
                                                       propertyType: self.propertyType,
                                                       advertisementType: self.advertisementType,
                                                       price: self.priceTxtField.text!,
                                                       bedrooms: self.BedroomsTxtField.text!,
                                                       bathroom: self.BathroomTxtField.text!,
                                                       size: self.sizeTxtField.text!,
                                                       phone: self.phoneTxtField.text!,
                                                       location: self.addressTxtField.text!,
                                                       latitude: self.latitude,
                                                       longitude: self.longitude,
                                                       country: self.countyTxtField.text!,
                                                       description: self.describtionTxtView.text!,
                                                       aminities: self.selectAmenitiesDic,
                                                       dataImages: self.selectedImages,
                                                       urlImages:self.urlImages,
                                                       deletedImage : self.urlImageDeleted)
        
        if addAdvertisementVM.isValid == false{
            let alertValues = addAdvertisementVM.borkenRule[0]
            alertControllerMessage(title: alertValues.brokenType, message: alertValues.message)
        }else{
            //check rechability
            if AdvertisementNetworking.checkNetworkConnection()
            {
                    self.showActivityIndicator()
                    blackIndicatorView.isHidden = false
                    // check add or edit
                    if(advertisementId.isEmpty == false)
                    {
                        addAdvertisementVM.editAdvertisement(id : advertisementId , date : dateOfAdvertisement)
                    }else{
                        addAdvertisementVM.save()
                    }
            }
            else{
                alertControllerMessage(title: "Internet Connection".localize, message: "Internet Connection Not Available".localize)
            }
        }
    }
    //MARK: - deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


