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
import ReachabilitySwift
import SDWebImage

class AddAdvertisementViewController: UIViewController  {
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
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var bedRoomStepper: UIStepper!
    @IBOutlet weak var bathRoomStepper: UIStepper!
    @IBOutlet var amentiesButton: [UIButton]!
    let networkIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var config = YPImagePickerConfiguration()
    var addAdvertisementVM: AddAdvertisementViewModel!
    var activityIndicator:UIActivityIndicatorView!
    var selectAmenitiesDic:[Int: String] = [Int:String]()
    var pickerViewPropertyType:[String] = [String]()
    var advertisementType:String = "Rent"
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
        blackIndicatorView.isHidden = true
        setTappedGesture()
        setupView()
       
        if(advertisementId.isEmpty == false)
        {
            reloadViewData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.chnageIndicatorStatus), name: .indicator, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewAlert), name: .alert, object: nil)
        
    }
    @objc func chnageIndicatorStatus()
    {
        stopIndicator()
        blackIndicatorView.isHidden = true
        
        let alertController = UIAlertController(title: "succes", message: "your advertrisement uploaded succesfuly" , preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "ok", style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(actionButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func viewAlert()
    {
        alertControllerMessage(title: "can't upload", message: "you have only 2 free advertisement if you want to add new add you should fo to payment")
        stopIndicator()
        blackIndicatorView.isHidden = true
        
        // go to payment page
        
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
        self.BedroomsTxtField.text = String(Int(sender.value))
    }
    @IBAction func increaseBathRoomNumber(_ sender: UIStepper) {
        self.BathroomTxtField.text = String(Int(sender.value))
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
            if checkNetworkConnection()
            {
                if switchButton.isOn
                {
                    showIndicator()
                    blackIndicatorView.isHidden = false
                    if(advertisementId.isEmpty == false)
                    {
                        addAdvertisementVM.editAdvertisement(id : advertisementId , date : dateOfAdvertisement)
                    }else{
                        addAdvertisementVM.save()
                    }
                    
                }else{
                    print("navegaion")
                }
            }
            else{
                alertControllerMessage(title: "Internet Connection Error", message: "Internet Connection Not Available")
            }
        }
    }
    
    //MARK: - func indicator show and hide
    func stopIndicator() {
        networkIndicator.stopAnimating()
    }
    
    func showIndicator()
    {
        networkIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        networkIndicator.center = view.center
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    //MARK: - func to chekc internet connection rechablity
    func checkNetworkConnection()->Bool
    {
        let connection = Reachability()
        guard let status = connection?.isReachable else{return false}
        return status
    }
    
    
    //MARK:- func setup image in letf textfield
    
    func setupImageInLeftTextField(){
        priceTxtField.setIcon(UIImage(named: "Advertisement_ic_monetization_on_24px.pdf")!)
        phoneTxtField.setIcon(UIImage(named: "Advertisement_flag.pdf")!)
        sizeTxtField.setIcon(UIImage(named:"Advertisement_house-size_2.pdf")!)
        addressTxtField.setIcon(UIImage(named: "Advertisement_Mask Group 22.pdf")!)
        BedroomsTxtField.setIcon(UIImage(named: "Advertisement_bed.pdf")!)
        BathroomTxtField.setIcon(UIImage(named: "Advertisement_Bathtub-bathroom-hotel-cleaning.pdf")!)
        countyTxtField.setIcon(UIImage(named: "Advertisement_flag.pdf")!)
    }
    
    //MARK:- alertMessage
    func alertControllerMessage(title: String , message : String ){
        let alertController = UIAlertController(title: title, message: message , preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(actionButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK:- switch toggle function
    @IBAction func switchToggle(_ sender: UISwitch) {
        
        if sender.isOn {
            self.payment = "free"
        }else{
            self.payment = "premium"
        }
    }
    
    //MARK: - deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - notification center

extension Notification.Name{
    static let indicator = Notification.Name("indicator")
    static let alert = Notification.Name("alert")
}

extension AddAdvertisementViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//
//extension AddAdvertisementViewController : UITextViewDelegate{
//    func textFieldShouldReturn(_ textView: UITextView) -> Bool {
//        textView.resignFirstResponder()
//        return true
//    }
//}
