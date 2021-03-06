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
        if AgentRateViewModel.checkUser(userId: agentId){
            if "lang".localize == "en"{
                rateLabel.text = "Please rate".localize + agentName + "'s properties".localize
            }else{
                rateLabel.text = "Please rate".localize + agentName 
            }
            
            rate.didFinishTouchingCosmos = {[weak self]
                rating in
                self?.agentRate = AgentRate()
                self?.agentRateViewModel = AgentRateViewModel(agentRate: self!.agentRate)
                if(self?.agentRateViewModel.setRate(rate: rating,agentId:(self?.agentId)!) ?? false)
                {
                    self?.showAlert(text:"Thank You".localize, title: nil)
                    self?.rateHeight.constant = 0
                }else
                {
                    self?.showAlert(text:"Error occured Please try again later".localize, title: "Error".localize)
                }
            }
        }
        else
        {
            self.rateHeight.constant = 0
        }
    }
    
    private func showAlert(text:String,title:String?)
    {
        let alert = UIAlertController(title: title, message:text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localize, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
