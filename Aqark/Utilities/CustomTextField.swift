//
//  CustomTextField.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

//MARK: TextField Left Icon
@IBDesignable class CustomTextField: UITextField {
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x = leftPadding
        return textRect
    }
    
    @IBInspectable var leftPadding : CGFloat = 0
    
    @IBInspectable var leftTextImage : UIImage? {
        didSet{
            updateTextImage()
        }
    }
    
    func updateTextImage(){
        if let leftImage = leftTextImage{
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame:CGRect(x:0,y:0,width:20,height:20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = leftImage
            leftView = imageView
        }else{
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
    
    //MARK: Floating Label
    
//        required init?(coder aDecoder: NSCoder) {
//            super.init(coder:aDecoder)
////            updateTextImage()
//            self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
//            placeholder = self._placeholder
//            self.floatingLabel = UILabel(frame: CGRect.zero)
//            self.addTarget(self, action: #selector(addFloatingLabel), for: .editingDidBegin)
//            self.addTarget(self, action:#selector(removeFloatingLabel), for: .editingDidEnd)
//        }
    
    var floatingLabel = UILabel(frame: CGRect.zero)
    var floatingLabelHeight : CGFloat = 14
    
    @IBInspectable var _placeholder : String?{
        didSet{
            updatePlaceHolder()
        }
    }
    @IBInspectable var floatingLabelColor : UIColor = UIColor.black{
        didSet{
            floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var activeBorderColor: UIColor = UIColor.blue
    @IBInspectable var floatingLabelFont : UIFont = UIFont.systemFont(ofSize: 14){
        didSet{
            floatingLabel.font = floatingLabelFont
            self.font = floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    func updatePlaceHolder(){
//        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
        placeholder = self._placeholder
        self.addTarget(self, action: #selector(addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action:#selector(removeFloatingLabel), for: .editingDidEnd)
    }
    
    @objc func addFloatingLabel(){
        if self.text == ""{
            self.floatingLabel.textColor = UIColor(rgb: 0x457b9d)
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = _placeholder
            self.floatingLabel.layer.backgroundColor = UIColor(rgb: 0xf1faee).cgColor
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true
            self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.floatingLabelHeight)
            self.layer.borderColor = self.activeBorderColor.cgColor
            self.addSubview(self.floatingLabel)
            self.floatingLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
            self.placeholder = ""
            self.setNeedsDisplay()
        }
    }
    
    @objc func removeFloatingLabel(){
        if self.text == "" {
            UIView.animate(withDuration: 0.13){
                self.subviews[3].removeFromSuperview()
                self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
        }
        self.layer.borderColor = UIColor.black.cgColor
    }
}


