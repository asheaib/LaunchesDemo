//
//  Extensions.swift
//  LaunchesDemo
//
//  Created by hadi on 26/08/2022.
//

import Foundation
import UIKit
import MaterialComponents.MaterialSnackbar


extension UIView {

    func addFullRoundEdges(){
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
    func addRoundEdge(rounding:CGFloat){
        self.layer.cornerRadius = rounding
        self.layer.masksToBounds = true
    }
    
    func addFullRoundedWithShadow( opacity:Float  = 0.3 , sR:CGFloat = 3, sH:CGFloat = 2 , sW:CGFloat = 2 ){
        
        layer.cornerRadius = self.frame.height/2
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
      
        layer.shadowRadius = sR
        layer.shadowOffset = CGSize(width: sW, height: sH)
        
    }

    func addoverlay(color: UIColor = .black,alpha : CGFloat = 0.6) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
        }
        //This function will add a layer on any `UIView` to make that `UIView` look darkened
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

extension Date {

    public  func addYear(n: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .year, value: n, to: self)!
    }


}

extension String {
    
    func dateFormatter(givenPattern:String,pattern:String)->String {

        let formatter  = DateFormatter()
        let myCalendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(identifier:"GMT")
        formatter.calendar = myCalendar
        formatter.dateFormat = givenPattern
        if let date = formatter.date(from: self){
            formatter.dateFormat = pattern
            return formatter.string(from: date)
        }
        return self
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
     
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIViewController {
    func showSnackBarVC(msg:String){
        let message = MDCSnackbarMessage()
        message.text = msg
        if !MDCSnackbarManager.default.hasMessagesShowingOrQueued() {
            MDCSnackbarManager.default.show(message)
        }
    }
}

extension UILabel {
@IBInspectable var letterSpacing: CGFloat {
    get {
        var range:NSRange = NSMakeRange(0, self.text?.count ?? 0)
        let nr = self.attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: &range) as! NSNumber
        return CGFloat(truncating: nr)
    }

    set {
        let range:NSRange = NSMakeRange(0, self.text?.count ?? 0)

        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: range)
        self.attributedText = attributedString
    }
}
}
