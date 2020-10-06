//
//  UIImageViewExtension.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/24/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    func load(url: URL, color: UIColor) {
        
        
        let request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 1)
    
 /*
        Alamofire.request(request).responseData { (response) in
            switch response.result{
            case .success(_) :
                if let image = UIImage(data: response.result.value!) {
                    DispatchQueue.main.async {
                        self.image = image
                        self.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                        // 76 130 200
                        self.tintColor = color
                    }
                }
            case .failure(_):
                print("xxxxxxxxx")
            }
        }
 */
    }
    
    func addImage(withImage image: String?, andPlaceHolder holder: String){
        guard let placeHolder = UIImage(named: holder) else {
            guard let imageURL = URL(string: image ?? "") else { return }
            self.sd_setImage(with: imageURL, completed: nil)
            return
        }
        guard let imageURL = URL(string: image ?? "") else {
            self.image = placeHolder
            return
        }
        self.sd_setImage(with: imageURL, placeholderImage: placeHolder, options: [], completed: { (_, error,_ , _) in
            if error != nil{
                self.image = placeHolder
            }
        })
    }
    func setRounded(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

class RoundedImageView: UIImageView {
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.layer.frame.width / 2
//        self.layer.borderColor  = UIColor.color("#eeeeee")?.cgColor
//        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
    }
    
}
