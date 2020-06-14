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
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var companyTxtField: UITextField!
    @IBOutlet weak var experianceTxtField: UITextField!
    @IBOutlet weak var stepperExperiance: UIStepper!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var cameraChangeProfilePic: UIImageView!
    var imageViewPicker = UIImagePickerController()
    var autocompletecontroller = GMSAutocompleteViewController()
    var filter = GMSAutocompleteFilter()
    var profileData : ProfileDataAccess!
    var profileStore : ProfileStore!
    var editProfileViewModel :EditProfileViewModel!
    var role = ""
    var profilePic :Any!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupView()
        setupImageTextField()
        setTappedGesture()
       NotificationCenter.default.addObserver(self, selector: #selector(self.chnageIndicatorStatus), name: .indicator, object: nil)
    }
    @objc func chnageIndicatorStatus(){
        indicatorView.isHidden = true
        showActivityIndicator()
        let alertController = UIAlertController(title: "Edit Profile".localize, message: "Profile Edited Successfully".localize, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok".localize, style: .default) {[weak self] (_) in
            self!.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    func setupView()
    {
        userNameTxtField.delegate = self
        phoneNumberTxtField.delegate = self
        countryTxtField.delegate = self
        addressTxtField.delegate = self
        companyTxtField.delegate = self
        experianceTxtField.delegate = self
        self.view.backgroundColor = UIColor(rgb: 0xf1faee)
        self.navigationItem.title = "Edit Profile".localize
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        viewForImage.layer.cornerRadius = viewForImage.bounds.height / 2
        indicatorView.isHidden = true
        countryView.isHidden = true
        autocompletecontroller.delegate = self
        cameraChangeProfilePic.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLibrary)))
        cameraChangeProfilePic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLibrary)))
        fetchProfileDataFromFirebase()
       
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        profileData  = nil
        profileStore = nil
        editProfileViewModel = nil
        print("deinit edit profile")
    }
}



extension EditProfileViewController: GMSAutocompleteViewControllerDelegate
{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        addressTxtField.text = place.name
        companyTxtField.becomeFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        // Handle the error
        print("Error configration for autocompleteview : ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController)
    {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}


extension EditProfileViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let info = info[.originalImage] as? UIImage else {return}
        imageView.image = info
        profilePic = info.jpegData(compressionQuality: 75)
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func openLibrary()
    {
        imageViewPicker.delegate = self
        imageViewPicker.allowsEditing = true
        imageViewPicker.sourceType = .photoLibrary
        self.present(imageViewPicker, animated: true, completion: nil)
    }
    
}

extension EditProfileViewController{
    func setupImageTextField()
     {
         userNameTxtField.setIcon(UIImage(named: "user")!)
         phoneNumberTxtField.setIcon(UIImage(named: "phone")!)
         countryTxtField.setIcon(UIImage(named: "country")!)
         addressTxtField.setIcon(UIImage(named: "profile_map")!)
         companyTxtField.setIcon(UIImage(named: "company")!)
         experianceTxtField.setIcon(UIImage(named: "experience")!)
     }
     
     @IBAction func countrySelected(_ sender: Any)
     {
         countryView.isHidden = false
     }
     
     @IBAction func changeCountry(_ sender: UIButton)
     {
         countryTxtField.text = sender.currentTitle
         countryView.isHidden = true
         companyTxtField.becomeFirstResponder()
     }
     
     @IBAction func addAutoCompleteAddress(_ sender: Any)
     {
         filter.type = .address  //suitable filter type
         filter.country = "eg"  //appropriate country code
         autocompletecontroller.autocompleteFilter = filter
         addressTxtField.resignFirstResponder()
         present(autocompletecontroller, animated: true, completion: nil)
     }
     
     @IBAction func expericanceStepper(_ sender: UIStepper)
     {
        self.experianceTxtField.text = self.convertNumbers(lang: "lang".localize, stringNumber: String(Int(sender.value))).1
     }
     
     @IBAction func editProfile(_ sender: Any)
     {
         editProfileViewModel = EditProfileViewModel(imageView:profilePic ,
                                                     userName: self.userNameTxtField.text!,
                                                     phoneNumber: self.phoneNumberTxtField.text!,
                                                     country: self.countryTxtField.text!,
                                                     address: self.addressTxtField.text!,
                                                     company: self.companyTxtField.text!,
                                                     experiance: self.experianceTxtField.text!,
                                                     role: self.role)
         if editProfileViewModel.isValid == false
         {
            self.showAlert(title: editProfileViewModel.borkenRule[0].brokenType, message: editProfileViewModel.borkenRule[0].message)
         }else{
            
            if ProfileNetworking.checkNetworkConnection()
            {
                indicatorView.isHidden = false
                showActivityIndicator()
                editProfileViewModel.updateProfileData()
            }else{
                showAlert(title: "Internet Connection".localize, message: "Internet Connection Not Available".localize)
            }
        }
    }
    
    func showAlert(title: String , message : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok".localize, style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
     
    
     func fetchProfileDataFromFirebase()
     {
        profileData = ProfileDataAccess()
        profileStore = ProfileStore(by: profileData)
        profileStore.getProfileData(onSuccess: { (profile) in
            if (profile.role == "user")
             {
                 self.phoneNumberTxtField.isHidden = true
                 self.countryTxtField.isHidden = true
                 self.addressTxtField.isHidden = true
                 self.companyTxtField.isHidden = true
                 self.experianceTxtField.isHidden = true
                 self.stepperExperiance.isHidden = true
             }
             if(profile.picture.isEmpty == false)
             {
                 self.imageView.sd_setImage(with: URL(string: profile.picture), placeholderImage: UIImage(named: "profile_user"))
                 self.profilePic = profile.picture
             }
             if(profile.username.isEmpty == false)
             {
                 self.userNameTxtField.text = profile.username
             }
             if(profile.phone.isEmpty == false)
             {
                self.phoneNumberTxtField.text = self.convertNumbers(lang: "lang".localize, stringNumber:"0").1 + self.convertNumbers(lang: "lang".localize, stringNumber: profile.phone).1
             }
             if(profile.country.isEmpty == false)
             {
               self.countryTxtField.text = profile.country.localize
             }
             if(profile.address.isEmpty == false)
             {
                 self.addressTxtField.text = profile.address
             }
             if(profile.company.isEmpty == false)
             {
                 self.companyTxtField.text = profile.company
             }
             if(profile.experience.isEmpty == false)
             {
                self.experianceTxtField.text = self.convertNumbers(lang: "lang".localize, stringNumber: profile.experience).1
                self.stepperExperiance.value = self.convertNumbers(lang: "lang".localize, stringNumber: profile.experience).0.doubleValue
             }
             self.role = profile.role

         }) { (error) in
             print(error.localizedDescription)
         }
     }
}

extension EditProfileViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
