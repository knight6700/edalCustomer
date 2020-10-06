//
//  BookingViewController.swift
//  edal-IosCustomerApp
//
//  Created by Mahmoud Maamoun on 1/19/20.
//  Copyright © 2020 hesham ghalaab. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController,CalenderDelegate {
    @IBOutlet weak var resourcesCollectionView: UICollectionView!
    @IBOutlet weak var timesCollectionView: UICollectionView!
     
    var resources: Resources!
    lazy var  calenderView: CalenderView = {
          let calenderView = CalenderView(theme: MyTheme.light)
          calenderView.translatesAutoresizingMaskIntoConstraints=false
          return calenderView
      }()
    // Do any additional
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.addSubview(calenderView)
        calenderView.delegate = self
        calenderView.topAnchor.constraint(equalTo: resourcesCollectionView.bottomAnchor, constant: 12).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 300).isActive=true
       
            // setup after loading the view.
    }
    func navigateToPayment(){
        let navigator = MoreNavigator(nav: self.navigationController)
        navigator.navigate(to: .paymentInfo)
    }
    @IBAction func confirmBooking(_ sender: Any) {
  
        let payVC = Initializer.createViewController(storyBoard: .PaymentInfoSB, andId:"PaymentInfoVC")
        self.navigationController?.pushViewController(payVC, animated: true)
    }
    func didTapDate(date: String, available: Bool) {
           if available == true {
               print(date)
           } else {
            self.alertUser(title: "you tapped", message: "\(date)")
           }
     }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == timesCollectionView {
            timesSelectedindex = indexPath.row
            timesCollectionView.reloadData()
        }
    }
    var timesSelectedindex = -1
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BookingViewController: UICollectionViewDelegate,UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == resourcesCollectionView {
        guard let count = resources?.data?.count else {return 5}
        return count
    } else {
        guard let count = resources?.data?.count else {return 5}
        return count
    }
      }
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == resourcesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resourcesCell", for: indexPath) as! ResourcesCollectionViewCell
            //          cell.resourcesImageView.addImage(withImage: resources.data[indexPath.row].image , andPlaceHolder: "")
            //          cell.resourcesNameLabel.text = resources.data[indexPath.row].name
            //          cell.resourcesTitleLabel.text = resources.data[indexPath.row].position
                      return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! UICollectionViewCell
            if timesSelectedindex == indexPath.row {
                cell.viewWithTag(2)?.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
                (cell.viewWithTag(2) as? UILabel)?.textColor = UIColor.white
            } else {
                cell.viewWithTag(2)?.backgroundColor = UIColor.white
                (cell.viewWithTag(2) as? UILabel)?.textColor = UIColor.darkGray
            }
                return cell
            
        }
          
      }
      

    
}
