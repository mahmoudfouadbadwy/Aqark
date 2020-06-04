//
//  RatingExtenesion.swift
//  Aqark
//
//  Created by Mahmoud Fouad on 5/29/20.
//  Copyright © 2020 ITI. All rights reserved.
//


import UIKit

extension AgentPropertiesView{
    func setupAgentRate(){
        if AgentRateViewModel.checkLogin(){
            rateLabel.text = "Please rate \(agentName ?? "Agent")'s properties"
            rate.didFinishTouchingCosmos = {[weak self]
                rating in
                self?.agentRateViewModel = AgentRateViewModel()
                if(self?.agentRateViewModel.setRate(rate: rating,agentId:(self?.agentId)!) ?? false)
                {
                    self?.showAlert(text:"Thank You", title: "Information")
                    self?.rateHeight.constant = 0
                }else
                {
                    self?.showAlert(text:"Error occured Please try again later", title: "Error")
                }
            }
        }
        else
        {
            self.rateHeight.constant = 0
        }
    }
    
    private func showAlert(text:String,title:String)
    {
        let alert = UIAlertController(title: title, message:text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
