//
//  SwiftyRecordButton.swift
//  Dog Theme Song
//
//  Created by Gwen Friedman on 8/4/20.
//  Copyright © 2020 Gwen Friedman. All rights reserved.
//

import UIKit

class SwiftyRecordButton: SwiftyCamButton {
    
    private var circleBorder: CALayer!
    private var innerCircle: UIView!
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawButton()
    }
    
    private func drawButton() {
        self.backgroundColor = UIColor.clear
        
       circleBorder = CALayer()
        circleBorder.backgroundColor = UIColor.clear.cgColor
        circleBorder.borderWidth = 3.0
        circleBorder.borderColor = UIColor.white.cgColor
        circleBorder.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//        circleBorder.position = CGPoint(x: screenWidth / 2, y: self.bounds.midY)
        circleBorder.bounds = self.bounds
        circleBorder.cornerRadius = self.frame.size.width / 2
        self.circleBorder.setAffineTransform(CGAffineTransform(scaleX: 2, y: 2))
        layer.insertSublayer(circleBorder, at: 0)

    }
    
    public  func growButton() {
        innerCircle = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        innerCircle.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//        innerCircle.center = CGPoint(x: screenWidth / 2, y: self.bounds.midY)
        innerCircle.backgroundColor = UIColor.red
        innerCircle.layer.cornerRadius = innerCircle.frame.size.width / 2
        innerCircle.clipsToBounds = true
        self.addSubview(innerCircle)
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut, animations: {
            self.innerCircle.transform = CGAffineTransform(scaleX: 62.4, y: 62.4)
            self.circleBorder.setAffineTransform(CGAffineTransform(scaleX: 3, y: 3))
            self.circleBorder.borderWidth = (6 / 3)

        }, completion: nil)
    }
    
    public func shrinkButton() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.innerCircle.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.circleBorder.setAffineTransform(CGAffineTransform(scaleX: 2, y: 2))
            self.circleBorder.borderWidth = 3.0
        }, completion: { (success) in
            self.innerCircle.removeFromSuperview()
            self.innerCircle = nil
        })
    }
}
