//
//  SignUpView.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/11/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class SignUpView: UIViewController  {
    
    @IBOutlet private weak var signUpCollection: UICollectionView!
    var accountViewModel:AccountViewModel!
    let cellIdentifier = "signUpCell"
    override func viewDidLoad() {
        super.viewDidLoad()
       // register cell.
        self.signUpCollection.register(UINib(nibName: "SignUpCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.signUpCollection.delegate = self
        self.signUpCollection.dataSource = self
        accountViewModel = AccountViewModel()
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
    }
}

extension SignUpView:UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell:SignUpCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SignUpCollectionCell
            cell.email.setIcon(UIImage(named: "mail")!)
            cell.password.setIcon(UIImage(named: "mail")!)
            cell.username.setIcon(UIImage(named: "mail")!)
            cell.phoneNumber.setIcon(UIImage(named: "mail")!)
            cell.confirmPassword.setIcon(UIImage(named: "mail")!)
            return cell
        }
}

extension SignUpView:UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height)
        }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}


