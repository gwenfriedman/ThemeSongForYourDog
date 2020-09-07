//
//  SpinnerViewController.swift
//  Dog Theme Song
//
//  Created by Gwen Friedman on 8/10/20.
//  Copyright © 2020 Gwen Friedman. All rights reserved.
//

import UIKit

extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        gifImageView.animationDuration = 2.0
        return gifImageView
    }
}


class SpinnerViewController: UIViewController {
    
    // Screen width.
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        
        var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }
        
        var screenHeight: CGFloat {
            return UIScreen.main.bounds.height
        }
        let centerX = screenWidth / 2
        let centerY = screenHeight / 2
            
        guard let loadingImageView = UIImageView.fromGif(frame: view.frame, resourceName: "loading-big") else {
            return }
        loadingImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        loadingImageView.center = CGPoint(x: centerX, y: centerY)
        view.addSubview(loadingImageView)
        loadingImageView.startAnimating()
    }
}
