//
//  Extension.swift
//  Copy YouTube
//
//  Created by juju on 15/10/2016.
//  Copyright © 2016 juju. All rights reserved.
//

import UIKit

extension UIView{
    func addConstraintsWithVisualFormat(format:String,views:UIView...){
        var viewDict = [String:UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            viewDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil,views:viewDict))
    }
}
extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let imageCache = NSCache<NSString, UIImage>()


class CustomImageView: UIImageView {
    var originalUrl:String?
    
    func loadImageUrl(urlString: String) {
        let url = URL (string: urlString)
        originalUrl = urlString
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage (data: data!)
                if(self.originalUrl == urlString) {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
        }).resume()
    }
}
