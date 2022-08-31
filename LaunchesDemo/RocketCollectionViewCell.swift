//
//  RocketCollectionViewCell.swift
//  LaunchesDemo
//
//  Created by hadi on 26/08/2022.
//

import UIKit

class RocketCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var launchingImg: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    
    override func awakeFromNib() {
        progressView.isHidden = true
        detailsView.addRoundEdge(rounding: 6)
        launchingImg.addoverlay(color: UIColor(hexString: "134F89"), alpha: 0.5)
    }
    
    
    func setData(viewModel:LaunchViewModel){
        if let flightNumber = viewModel.flight_number {
        numberLabel.text = String(flightNumber)
        }
        nameLabel.text = viewModel.details
        dateLabel.text = viewModel.dateLocal
       
        
        if viewModel.upcoming == true {
            progressView.isHidden = false
        } else {
            progressView.isHidden = true
        }
        
    }
    
    
    
    
    
    
}
