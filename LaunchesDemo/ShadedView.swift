//
//  ShadedView.swift
//  LaunchesDemo
//
//  Created by hadi on 29/08/2022.
//

import Foundation
import MaterialComponents.MDCShadowElevations

class ShadedView:UIView{
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }
    
    var shadowLayer: MDCShadowLayer {
        return self.layer as! MDCShadowLayer
    }
    
    func setDefaultElevation() {
        self.shadowLayer.elevation = .cardResting
    }
    
    
}
