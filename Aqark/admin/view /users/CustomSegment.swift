//
//  AppDelegate.swift
//  Aqark
//
//  Created by ZeyadEl3ssal on 5/22/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

@IBDesignable class CustomSegment : UIControl{
    
    private var labels = [UILabel]()
    var thumbView = UIView()
    
    var items:[String] = ["Users","Lawyers","Interior Designers"]{
        didSet{
            setupLabels()
        }
    }
    
    var selectedIndex : Int = 0{
        didSet{
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
//        //layer.cornerRadius = frame.height / 2
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 2
        
        backgroundColor = UIColor.clear
        setupLabels()
        insertSubview(thumbView, at: 0)
    }
    
    
    func setupLabels(){
        for label in labels{
            label.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity: true)
        for index in 1...items.count{
            let label = UILabel(frame: CGRect.zero)
            label.text = items[index - 1]
            label.textAlignment = .center
            label.textColor = UIColor.black
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var selectedFrame = self.bounds
        let newWidth = selectedFrame.width / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        thumbView.frame = selectedFrame
        thumbView.backgroundColor = .lightGray
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(items.count)
        for index in 0...labels.count - 1{
            let label = labels[index]
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        var calculatedIndex : Int?
        for(index,item) in labels.enumerated(){
            if item.frame.contains(location){
                calculatedIndex = index
            }
        }
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        return false
    }
    
    func displayNewSelectedIndex(){
        let label = labels[selectedIndex]
        self.thumbView.frame = label.frame
    }
}
