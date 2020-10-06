//
//  ServiceItemDetailsViewController.swift
//  edal-IosCustomerApp
//
//  Created by Mahmoud Maamoun on 1/15/20.
//  Copyright © 2020 hesham ghalaab. All rights reserved.
//

import UIKit

class ServiceItemDetailsViewController: UIViewController,UIScrollViewDelegate {
var scrollView = UIScrollView(frame: CGRect(x:0, y:100, width:320 , height: 523))
var frame: CGRect = CGRect(x:20, y:0, width:0, height:0)
    
    @IBOutlet weak var servBtn: UIButton!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var reviewsBtn: UIButton!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var topHeaderV: UIView!
    @IBOutlet weak var detalsV: UIView!
    @IBOutlet weak var tbView: UITableView!
    
    var subServiceId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeImage.setRounded()
        detalsV.scale()
        //tbView.scale()
        getSubServiceInfo ()
        
       
               
        // Do any additional setup after loading the view.
    }
    func initScrollView() {
        scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:self.view.frame.width , height: 200 ))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = true
        self.topHeaderV.addSubview(scrollView)
        for index in 0..<4 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            let subView = Bundle.main.loadNibNamed("Intro", owner: self, options: nil)! [0] as! UIView
            subView.frame = frame
            subView.backgroundColor = UIColor.clear
            self.scrollView .addSubview(subView)
            //            scrollView.scale()
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 4,height: self.scrollView.frame.size.height)
               
    }
    var indecatorIndex = 0
    @IBAction func leftArrowBtn(_ sender: Any) {
        if indecatorIndex >= 1 && indecatorIndex <= 4 {
                 indecatorIndex -= 1
             let x = CGFloat(indecatorIndex) * scrollView.frame.size.width
             
             scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
             }
    }
    @IBAction func rightBtn(_ sender: Any) {
        if indecatorIndex >= 0 && indecatorIndex <= 3 {
            indecatorIndex += 1
        let x = CGFloat(indecatorIndex) * scrollView.frame.size.width
        
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        }
    }
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        
    }
    @IBAction func ServicesAction(_ sender: UIButton) {
           
        sender.backgroundColor = UIColor.init(displayP3Red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
        detailsBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
        reviewsBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
        
    }
    @IBAction func detailsAction(_ sender: UIButton) {
            sender.backgroundColor = UIColor.init(displayP3Red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
             servBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
           reviewsBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
    }
    @IBAction func reviewsActionBtn(_ sender: UIButton) {
         sender.backgroundColor = UIColor.init(displayP3Red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
          detailsBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
          servBtn.backgroundColor = UIColor.init(displayP3Red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - API Calls
    var bookngService = BookingServices()
    var bookingServiceDetailsModel :SubServiceDefaultResponse?
    private func getSubServiceInfo () {
        self.showLoading()
        bookngService.getSubBookingService(sub_service_id: self.subServiceId) { (error, details) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let data = details else {return}
            self.bookingServiceDetailsModel = data
            self.initScrollView()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ServiceItemDetailsViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
                 return UITableViewCell()
              }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = Initializer.createViewController(storyBoard: .HomeSB, andId: "BookingViewController") as! BookingViewController
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
