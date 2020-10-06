//
//  LoadingView.swift
//  LoadingTemplate
//
//  Created by hesham ghalaab on 6/16/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var loadingNamedLabel: UILabel!
    
    var loadingName: String = ""{
        didSet{
            self.loadingNamedLabel.text = loadingName
        }
    }
    
    override func draw(_ rect: CGRect) {
        mainView.layer.cornerRadius = 16
    }
 

}
