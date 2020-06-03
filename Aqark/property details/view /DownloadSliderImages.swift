//
//  DownloadSliderImages.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/24/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

extension PropertyDetailView{
  func getImages(images:[String],completion:@escaping ()->())
   {
      for image in images
      {
        downloadImage(from: URL(string: image)!, completion: {[weak self]
            (image) in
            self?.downloadedImages.append(UIImage(data: image) ?? UIImage(named: "NoImage")!)
               completion()
        })
      }
   
   }
    
   private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL,completion:@escaping(Data)->Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                completion(data)
            }
            
        }
    }
    
    func setSliderImages()
    {
        self.stopActivityIndicator()
        imageSlider.configure(with: downloadedImages)
        self.imageSlider.favBtnDelegate = self
    }
    
}
