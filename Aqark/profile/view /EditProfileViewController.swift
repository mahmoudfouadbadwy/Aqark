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
    
    var networkIndicator = UIActivityIndicatorView()
    var imageViewPicker = UIImagePickerController()
    var autocompletecontroller = GMSAutocompleteViewController()
    var filter = GMSAutocompleteFilter()
    var profileData : ProfileDataAccess!
    var editProfileViewModel :EditProfileViewModel!
    var role = ""
    var profilePic :Any!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupView()
        setupImageTextField()
       NotificationCenter.default.addObserver(self, selector: #selector(self.chnageIndicatorStatus), name: .indicator, object: nil)
    }
    @objc func chnageIndicatorStatus(){
        indicatorView.isHidden = true
        stopIndicator()
        let alertController = UIAlertController(title: "Edit Profile", message: "suceess edit profile", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default) {[weak self] (_) in
            self!.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    func setupView()
    {
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        indicatorView.isHidden = true
        countryView.isHidden = true
        autocompletecontroller.delegate = self
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLibrary)))
        fetchProfileDataFromFirebase()
       
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



extension EditProfileViewController{
    
   func showIndicator()
   {
       networkIndicator.color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
       networkIndicator.center = view.center
       networkIndicator.startAnimating()
       view.addSubview(networkIndicator)
   }
   
    func stopIndicator() {
        networkIndicator.stopAnimating()
    }
    
    func checkNetworkConnection()->Bool
    {
       let connection = Reachability()
       guard let status = connection?.isReachable else{return false}
       return status
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
         userNameTxtField.setIcon(UIImage(named: "profile_user")!)
         phoneNumberTxtField.setIcon(UIImage(named: "signup_phone")!)
         countryTxtField.setIcon(UIImage(named: "profile_country")!)
         addressTxtField.setIcon(UIImage(named: "Advertisement_flag")!)
         companyTxtField.setIcon(UIImage(named: "PropertyDetail_Barbecue")!)
         experianceTxtField.setIcon(UIImage(named: "profile_experience")!)
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
         self.experianceTxtField.text = "\(Int(sender.value))"
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
            
            if checkNetworkConnection()
            {
                indicatorView.isHidden = false
                showIndicator()
                editProfileViewModel.updateProfileData()
            }else{
               showAlert(title: "no Internet", message: "please check connection")
            }
        }
    }
    
    func showAlert(title: String , message : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
     
    
     func fetchProfileDataFromFirebase()
     {
         profileData = ProfileDataAccess()
         profileData.getProfileData(onSuccess: { (profile) in
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
                 self.phoneNumberTxtField.text = profile.phone
             }
             if(profile.country.isEmpty == false)
             {
                 self.countryTxtField.text = profile.country
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
                 self.experianceTxtField.text = profile.experience
                 self.stepperExperiance.value = Double(profile.experience)!
             }
             self.role = profile.role

         }) { (error) in
             print(error.localizedDescription)
         }
         
         
     }
    
}
