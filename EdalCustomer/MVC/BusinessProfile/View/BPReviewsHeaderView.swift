//
//  BPReviewsHeaderView.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 10/15/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit
import Cosmos

class BPReviewsHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var totalRatingLabel: UILabel!
    @IBOutlet weak var totalRatingView: CosmosView!
    @IBOutlet weak var basedOnLabel: UILabel!
    
    @IBOutlet weak var numberOfRatingInFive: UILabel!
    @IBOutlet weak var numberOfRatingInFour: UILabel!
    @IBOutlet weak var numberOfRatingInThree: UILabel!
    @IBOutlet weak var numberOfRatingInTwo: UILabel!
    @IBOutlet weak var numberOfRatingInOne: UILabel!
    
    @IBOutlet weak var progressViewInFive: UIProgressView!
    @IBOutlet weak var progressViewInFour: UIProgressView!
    @IBOutlet weak var progressViewInThree: UIProgressView!
    @IBOutlet weak var progressViewInTwo: UIProgressView!
    @IBOutlet weak var progressViewInOne: UIProgressView!
    
    var ratingAverage: Double = 0.0 {
        didSet{
            totalRatingLabel.text = ratingAverage.description
            totalRatingView.rating = ratingAverage
        }
    }
    
    var totalNumberOfUsersRated: Int = 0{
        didSet{
            basedOnLabel.text = "based on \(totalNumberOfUsersRated) clients reviews"
        }
    }
    
    func setRatings(inFive five: Int, four: Int, three: Int, two: Int, one: Int){
        // set the labels
        numberOfRatingInFive.text  = five.description
        numberOfRatingInFour.text  = four.description
        numberOfRatingInThree.text = three.description
        numberOfRatingInTwo.text   = two.description
        numberOfRatingInOne.text   = one.description
        
        // calculate the total Number Of Ratings
        let totalNumberOfRatings = five + four + three + two + one
        
        // calculate the progress of the progress view and convert it to double
        // because the value will always be less than zero.
        let progressInFive  = Double(five)  / Double(totalNumberOfRatings)
        let progressInFour  = Double(four)  / Double(totalNumberOfRatings)
        let progressInThree = Double(three) / Double(totalNumberOfRatings)
        let progressInTwo   = Double(two)   / Double(totalNumberOfRatings)
        let progressInOne   = Double(one)   / Double(totalNumberOfRatings)
        
        // set the progressViews
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.progressViewInFive.setProgress(Float(progressInFive), animated: true)
            self.progressViewInFour.setProgress(Float(progressInFour), animated: true)
            self.progressViewInThree.setProgress(Float(progressInThree), animated: true)
            self.progressViewInTwo.setProgress(Float(progressInTwo), animated: true)
            self.progressViewInOne.setProgress(Float(progressInOne), animated: true)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    

}
