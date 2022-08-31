//
//  LaunchDetailsVC.swift
//  LaunchesDemo
//
//  Created by hadi on 29/08/2022.
//

import Foundation
import UIKit


class LaunchDetailsVC:UIViewController {
    
    var viewModel:LaunchViewModel?
    
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rocketImg: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        setTextsForLabels()
        setProgressView()
   
    }
    
    func setDesign(){
        bottomSheetView.roundCorners([.topLeft,.topRight], radius: 18)
        rocketImg.addoverlay(color: UIColor(hexString: "134F89"), alpha: 0.3)
        readMoreBtn.backgroundColor = UIColor(hexString: "134F89")
        readMoreBtn.addRoundEdge(rounding: 10)
    }
    
    func setTextsForLabels(){
        numberLabel.text = NSLocalizedString("No_information_provided", comment: "")
        detailsLabel.text = NSLocalizedString("No_information_provided", comment: "")
        dateLabel.text = NSLocalizedString("No_information_provided", comment: "")
        nameLabel.text = NSLocalizedString("No_information_provided", comment: "")
        
        if let viewModel = viewModel {
            if let number = viewModel.flight_number {
                numberLabel.text = String(number)
            }
            if let details = viewModel.details {
                detailsLabel.text = details
            }
            if let date = viewModel.dateLocal {
                dateLabel.text = date
            }
            if let name = viewModel.name {
                nameLabel.text = name
            }
        }
    
    }
    
    func setProgressView(){
        progressView.isHidden = true
        
        if let viewModel = viewModel {
            if viewModel.upcoming == true {
                progressView.isHidden = false
            }
        }
        
    }
    
    
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMainVCfromLaunchDetailsVC", sender: nil)
    }
    
    
    @IBAction func readMoreTapped(_ sender: Any) {
        if let linkString = viewModel?.wikipediaLink {
            guard let url = URL(string:linkString) else {
                  showSnackBarVC(msg: "this link is not valid")
                  return }
              
              if #available(iOS 10.0, *) {
                  UIApplication.shared.open(url)
              } else {
                  UIApplication.shared.openURL(url)
              }
        }
    }
    
}
