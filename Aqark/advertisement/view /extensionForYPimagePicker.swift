//
//  extensionForYPimagePicker.swift
//  Aqark
//
//  Created by AhmedSaeed on 5/20/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import Foundation
import YPImagePicker

extension AddAdvertisementViewController{
    
    @objc func choosePhotos(){
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            for item in items {
                switch item {
                case .photo(let photo):
                    
                    let myImage = photo.image.jpegData(compressionQuality: 0.75)
                    
                    if self.selectedImages.count > 0
                    {
                        if self.selectedImages.count >= 5{
                            
                            print("error you shokd have only five imae")
                            break
                        }
                        if self.selectedImages.contains(myImage!){
                            print("i found it her !")
                            continue
                        }
                        self.selectedImages.append(myImage!)
                        
                    }else{
                        self.selectedImages.append(myImage!)
                    }
                    
                    self.collectionView.reloadData()
                    
                case .video(let video):
                    print(video)
                }
            }
            print(self.selectedImages)
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
  
}
