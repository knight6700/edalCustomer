//
//  IntroUIScrollView.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/28/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit

class IntroUIScrollView: UIScrollView {

    @IBOutlet weak var image: UIImageView!
    var imageString: String? {
        didSet (newValue) {
            image.addImage(withImage: newValue, andPlaceHolder: "edallogo")
        }
    }
}
