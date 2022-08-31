//
//  CustomBlocker.swift
//  LaunchesDemo
//
//  Created by hadi on 29/08/2022.
//

import Foundation
import UIKit


import MaterialComponents
class CustomBlocker: UIView {
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak  var loadingView: ShadedView!

    @IBOutlet weak  var indicator: MDCActivityIndicator!
    
   
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
       
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    
    
    func xibSetup() {
     
        if self.subviews.count == 0  {
           
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "CustomBlocker", bundle: bundle)
            contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
              addSubview(contentView)
          
           
        }
        
        
    }
    
    func initParams(_ color:UIColor? = nil){
        
        if contentView != nil{
            
           loadingView.addFullRoundedWithShadow(opacity: 0.2 , sR: 2, sH:1 , sW:1)
            indicator.strokeWidth = 5.0;
            indicator.radius = 18
            if let selectedColor = color{
               self.indicator.cycleColors=[selectedColor]
            }else{
               self.indicator.cycleColors=[UIColor(hexString:"1D9EEF")]
            }
            
    
            stop()
        }
        
    }
   
    public func updateIndicatorColor(color:UIColor){
        
        if contentView != nil{
        self.indicator.cycleColors=[color]
        }
    }
 
    func start(){
        if contentView != nil{
          
            indicator.startAnimating()
            
        }
        self.superview?.addSubview(self)
        self.contentView.frame = self.bounds;
        self.isHidden = false
    }
    func stop(){
        if contentView != nil{
            indicator.stopAnimating()
            
        }
      self.isHidden = true
    }
    
    
    
    
    
    
    
    
}

