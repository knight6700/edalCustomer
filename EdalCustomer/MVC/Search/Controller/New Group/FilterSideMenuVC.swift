//
//  FilterSideMenuVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/16/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class FilterSideMenuVC: UIViewController {

    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var sliderPrice: RangeSeekSlider!
    @IBOutlet weak var categoryButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setupUI(){
        ratingButton.roundView(withCorner: 4, borderColor: .lightGray , borderWidth: 1.0)
        categoryButton.roundView(withCorner: 4, borderColor: .lightGray , borderWidth: 1.0)
        indicatorImageView.image = indicatorImageView.image!.withRenderingMode(.alwaysTemplate)
        indicatorImageView.tintColor = .lightGray
        
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    @IBAction func onTappedResetButton(_ sender: UIButton) {
        
    }
    @IBAction func onTappedDone(_ sender: UIButton) {
        
    }
    @IBAction func onTappedSelectCategory(_ sender: UIButton) {
        
    }
    
    
}
