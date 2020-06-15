//
//  EditUiImagePicker.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 6/14/20.
//  Copyright © 2020 ITI. All rights reserved.
//
import UIKit
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
        imageViewPicker?.delegate = self
        imageViewPicker?.allowsEditing = true
        imageViewPicker?.sourceType = .photoLibrary
        self.present(imageViewPicker!, animated: true, completion: nil)
    }
    
}
