//
//  Extensions.swift
//  Sentia
//
//  Created by Matthew on 7/5/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()


extension UIImageView {
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        self.image = nil

        var timeout = "timeout" + urlString
        // check for timeout placeholder image first - set as image and then delete from cache
        if let cachedImageFromTimeout = imageCache.object(forKey: timeout as AnyObject) as? UIImage {
            print("flameon", urlString)
            self.image = cachedImageFromTimeout
            imageCache.removeObject(forKey: timeout as AnyObject)
        } else if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            // check cache for image first - return if it exists
            print("NOflame", urlString)
            self.image = cachedImage
            return
        }
        // This adds the loading image to the cache until the real image is loaded
        DispatchQueue.main.async {
        if let loading = UIImage(named: "loading") {
            imageCache.setObject(loading, forKey: urlString as AnyObject)
            self.image = loading
            }
        }
        // This uses the url to fetch the image
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//            if error != nil { return }
            if error != nil {
                DispatchQueue.main.async {
                    if let code = error?.localizedDescription {
                        if code == "The network connection was lost." {
                            print("So the network connection was lost")
                            var combined = "timeout" + urlString
                            // if there was a timeout - it enters the house image slightly differently so it can be remedied later on.
                            if let tornado = UIImage(systemName: "house") {
                                print("combined", combined)
                                imageCache.setObject(tornado, forKey: combined as AnyObject)
                                self.image = tornado
                            }
                        } else {
                            // this loads a house image into the cashe if the call returns an error
                            if let tornado = UIImage(systemName: "house") {
                                imageCache.setObject(tornado, forKey: urlString as AnyObject)
                                self.image = tornado
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async(execute: {
                if let data = data {
                if let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                } else {
                // if data fails to load an image- systemName house is inserted
                    if let tornado = UIImage(systemName: "house") {
                        imageCache.setObject(tornado, forKey: urlString as AnyObject)
                        self.image = tornado
                        }
                    }
                }
            })
        }).resume()
    }
}


extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2;
//        self.clipsToBounds = true
    }
}
extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
