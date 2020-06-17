//
//  EditProfileViewController.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/28/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit
import GooglePlaces
import SDWebImage
import ReachabilitySwift
class EditProfileViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var companyTxtField: UITextField!
    @IBOutlet weak var experianceTxtField: UITextField!
    @IBOutlet weak var stepperExperiance: UIStepper!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var cameraChangeProfilePic: UIImageView!
    var imageViewPicker : UIImagePickerController?
    var autocompletecontroller : GMSAutocompleteViewController?
    var filter : GMSAutocompleteFilter?
    var profileData : ProfileDataAccess?
    var profileStore : ProfileStore?
    var editProfileViewModel :EditProfileViewModel?
    var role = ""
    var profilePic :Any!
    var alertController: UIAlertController!
    var alertAction : UIAlertAction!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupView()
        setUpObjects()
        setupTextFieldDelegates()
        setupProfilePic()
        setupImageTextField()
        setTappedGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(self.chnageIndicatorStatus), name: .indicator, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if addressTxtField.text?.isEmpty ?? true
        {
             fetchProfileDataFromFirebase()
        }
       
    }
    
    private func setUpObjects()
    {
        imageViewPicker = UIImagePickerController()
        autocompletecontroller = GMSAutocompleteViewController()
        autocompletecontroller?.delegate = self
        filter = GMSAutocompleteFilter()
    }
    @objc func chnageIndicatorStatus(){
        indicatorView.isHidden = true
        stopActivityIndicator()
         UIApplication.shared.endIgnoringInteractionEvents()
        
        let alertController = UIAlertController(title: "Edit Profile".localize, message: "Profile Edited Successfully".localize, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok".localize, style: .default) {[weak self] (_) in
            self!.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addAutoCompleteAddress(_ sender: Any)
    {
        filter?.type = .address //suitable filter type
        filter?.country = "eg"  //appropriate country code
        autocompletecontroller?.autocompleteFilter = filter
        addressTxtField.resignFirstResponder()
        present(autocompletecontroller!, animated: true, completion: nil)
    }
    
    @IBAction func expericanceStepper(_ sender: UIStepper)
    {
        self.experianceTxtField.text = self.convertNumbers(lang: "lang".localize, stringNumber: String(Int(sender.value))).1
    }
    
    @IBAction func editProfile(_ sender: Any)
    {
        editProfileViewModel = EditProfileViewModel(imageView:profilePic,
                                                    userName: self.userNameTxtField.text!,
                                                    phoneNumber: self.phoneNumberTxtField.text!,
                                                    address: self.addressTxtField.text!,
                                                    company: self.companyTxtField.text!,
                                                    experiance: self.experianceTxtField.text!,
                                                    role: self.role)
        if editProfileViewModel?.isValid == false
        {
            self.showAlert(title: editProfileViewModel?.borkenRule[0].brokenType ?? "", message: editProfileViewModel?.borkenRule[0].message ?? "")
        }else{
            
            if ProfileNetworking.checkNetworkConnection()
            {
                indicatorView.isHidden = false
                 showActivityIndicator()
                 UIApplication.shared.beginIgnoringInteractionEvents()
                editProfileViewModel?.updateProfileData()
            }else{
                showAlert(title: "Internet Connection".localize, message: "Internet Connection Not Available".localize)
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        editProfileViewModel?.removeAllEditProfileRef()
        imageViewPicker = nil
        autocompletecontroller = nil
        filter = nil
        profileData = nil
        profileStore = nil
        editProfileViewModel = nil
        alertController = nil
        alertAction = nil

    }
}


extension EditProfileViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
