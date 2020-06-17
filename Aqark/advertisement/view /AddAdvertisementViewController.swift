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
    @IBOutlet weak var describtionTxtView: UITextView!
    @IBOutlet weak var saveAndEditButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var bedRoomStepper: UIStepper!
    @IBOutlet weak var bathRoomStepper: UIStepper!
    @IBOutlet weak var blackIndicatorView: UIView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet var amentiesButton: [UIButton]!
    @IBOutlet var pickerView: UIPickerView!
    var config : YPImagePickerConfiguration?
    var addAdvertisementVM: AddAdvertisementViewModel?
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
    var editAdvertisementDataSource :EditAdvertisementDataSource?
    //var dateOfAdvertisement:String!
    var autocompletecontroller : GMSAutocompleteViewController?
    var filter : GMSAutocompleteFilter?
    var country:String!
    //MARK:- viewdidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        autocompletecontroller = GMSAutocompleteViewController()
        filter = GMSAutocompleteFilter()
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
    
    // select address to open google autocomplete
    @IBAction func addAutoCompleteAddress(_ sender: Any) {
        filter?.type = .address  //suitable filter type
        filter?.country = "eg"  //appropriate country code
        autocompletecontroller?.autocompleteFilter = filter
        addressTxtField.resignFirstResponder()
        present(autocompletecontroller!, animated: true, completion: nil)
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
                                                       country: self.country,
                                                       description: self.describtionTxtView.text!,
                                                       aminities: self.selectAmenitiesDic,
                                                       dataImages: self.selectedImages,
                                                       urlImages:self.urlImages,
                                                       deletedImage : self.urlImageDeleted)
        
        if addAdvertisementVM?.isValid == false{
            let alertValues = addAdvertisementVM!.borkenRule[0]
            alertControllerMessage(title: alertValues.brokenType, message: alertValues.message)
        }else{
            //check rechability
            if AdvertisementNetworking.checkNetworkConnection()
            {
                    self.showActivityIndicator()
                    UIApplication.shared.beginIgnoringInteractionEvents()
                    blackIndicatorView.isHidden = false
                    // check add or edit
                    if(advertisementId.isEmpty == false)
                    {
                        addAdvertisementVM?.editAdvertisement(id : advertisementId)
                    }else{
                        addAdvertisementVM?.save()
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
        if(!(advertisementId.isEmpty))
        {
            //edit
            addAdvertisementVM?.removeAllEditDataRefrance()
        }else{
            //add
            addAdvertisementVM?.removeAllAddDataRefrance()
        }
        addAdvertisementVM = nil
        editAdvertisementDataSource = nil
        activityIndicator = nil
        autocompletecontroller = nil
        filter = nil
    }
}


