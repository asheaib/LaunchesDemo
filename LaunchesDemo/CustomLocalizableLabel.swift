//
//  CustomLocalizableLabel.swift
//  LaunchesDemo
//
//  Created by hadi on 26/08/2022.
//

import Foundation
import UIKit

class CustomLocalizableLabel: UILabel {
    
    func assignLocalizableTextIfFound() {
        if let _text = self.text {
            self.text = NSLocalizedString(_text, comment: "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        assignLocalizableTextIfFound()
    }
}
