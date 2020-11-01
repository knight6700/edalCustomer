//
//  BookingViewController.swift
//  edal-IosCustomerApp
//
//  Created by Mahmoud Maamoun on 1/19/20.
//  Copyright © 2020 hesham ghalaab. All rights reserved.
//

import UIKit
struct BookingParameters: Encodable {
    var subServiceId: String?
    var resourceId: String?
    var date:String?
    var timeFrom: String?
    var answer: String?
    var note: String?
    var deviceType = "2"
    init(subServiceId: String? ,resourceId: String? ,date:String?, timeFrom: String? ,answer: String?,note: String?) {
        self.subServiceId = subServiceId
        self.resourceId = resourceId
        self.date = date
        self.timeFrom = timeFrom
        self.answer = answer
        self.note = note
    }
    enum CodingKeys: String, CodingKey {
        case subServiceId = "sub_service_id"
        case resourceId = "resource_id"
        case date = "start_date"
        case timeFrom = "start_time"
        case answer = "answer"
        case note = "note"
        case deviceType = "device_type"
    }
}

class BookingViewController: UIViewController,CalenderDelegate {
    @IBOutlet weak var resourcesCollectionView: UICollectionView!
    @IBOutlet weak var timesCollectionView: UICollectionView!
    // Service View
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var capictyLabel: UILabel!
    @IBOutlet weak var availabiltyNumberLabel: UILabel!
    @IBOutlet weak var fromToTimeLabel: UILabel!
    @IBOutlet weak var resourceNameLabel: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var bookingQuestionLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var leaveNoteTextView: UITextView!
    @IBOutlet weak var timesHightConstraint: NSLayoutConstraint!
    
    //    var resources: Resources!
    var resources: [ResourcesDatumm]?
    var serviceItemDetailsResponseModel: ServiceItemDetailsResponseModel?
    lazy var  calenderView: CalenderView = {
        let calenderView = CalenderView(theme: MyTheme.light)
        calenderView.translatesAutoresizingMaskIntoConstraints=false
        return calenderView
    }()
    var bookingParameters: BookingParameters = BookingParameters(subServiceId: "", resourceId: "", date: "", timeFrom: "",  answer: "", note: "")
    var selectData: DatesTime?
    var selectedIndexResource: Int?
    var firstTime = 0
    // Do any additional
    func setupServiceView() {
        guard let data = serviceItemDetailsResponseModel?.defaultResponse else {return}
        price.text = "\(data.subService?.price ?? 0) EGP"
        capictyLabel.text = "Capacity : \(data.subService?.classCapacity ?? "") Seating"
        bookingQuestionLabel.text = data.subService?.bookingQuestion ?? ""
    }
    let services = BookingServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(calenderView)
        setupServiceView()
        calenderView.delegate = self
        bookingParameters.subServiceId = "\(serviceItemDetailsResponseModel?.defaultResponse?.subService?.id ?? 4)"
        calenderView.topAnchor.constraint(equalTo: resourcesCollectionView.bottomAnchor, constant: 12).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 300).isActive=true
        // setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.timesCollectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if object is UICollectionView {
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                     let count =  selectData?.times?.count ?? 0
                    let cG = CGSize(width: count - 10, height: count)
                    self.timesHightConstraint.constant = firstTime == 0 ? 50 : count == 0 ?  50 : (newSize.height - cG.width)
                    self.timesCollectionView.isScrollEnabled = false
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timesCollectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    func navigateToPayment(){
        let navigator = MoreNavigator(nav: self.navigationController)
        navigator.navigate(to: .paymentInfo)
    }
    
    @IBAction func confirmBooking(_ sender: Any) {
        
//        let payVC = Initializer.createViewController(storyBoard: .PaymentInfoSB, andId:"PaymentInfoVC")
//        self.navigationController?.pushViewController(payVC, animated: true)
        bookingParameters.note = leaveNoteTextView.text ?? ""
        bookingParameters.answer = questionTextView.text ?? ""
        self.showLoading()
        services.bookAppointment(parameters: bookingParameters) { [weak self] (error: String?, data: BookAppointment?) in
            self?.hideLoading()
            if error == nil {
                self?.alertUser(title: "Success", message: " your Book ID : \(data?.defaultResponse?.bookID ?? 0)")
                self?.navigationController?.popViewController(animated: true)
            }else {
                self?.alertUser(title: "Error", message: error ?? "")
            }
        }
    }
    
    func didTapDate(date: String, available: Bool) {
        if available == true {
            print(date)
            bookingParameters.date = date
            guard  let index = selectedIndexResource else {
                return
            }
        
            if resources?[index].datesTimes?.filter({$0.date == date}).count ?? 0 > 0 {
                selectData = resources?[index].datesTimes?.filter({$0.date == date})[0]
                firstTime = 1
            }
        } else {
            self.alertUser(title: "No Available Date", message: "\(date)")
        }
        firstTime = 1
        timesCollectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == timesCollectionView {
            bookingParameters.timeFrom = selectData?.times?[indexPath.row].from ?? ""
            timesSelectedindex = indexPath.row
            timesCollectionView.reloadData()
        }else {
            let selectedCell:ResourcesCollectionViewCell = resourcesCollectionView.cellForItem(at: indexPath) as! ResourcesCollectionViewCell
            selectedIndexResource = indexPath.row
            bookingParameters.resourceId = "\(resources?[indexPath.row].id ?? -1)"
            selectedCell.setupSelectView(selected: true)
            resourcesCollectionView.reloadData()
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

extension BookingViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == resourcesCollectionView {
            guard let count = resources?.count else {return 0}
            if count == 0 {
                resourcesCollectionView.setEmptyMessage("No Resources Available")
                return 0
            }else {
                resourcesCollectionView.restore()
                return count
            }
        } else {
            guard let data = selectData else {
                timesCollectionView.setEmptyMessage(firstTime == 0 ? "Please Select Resources and Date": (bookingParameters.date == "" && selectedIndexResource == nil) ? "Please Select Resources and Date" : "No Time Slots Available")
                return 0
            }
            guard let count = data.times?.count else {
                return 0
            }
            if count == 0 {
                timesCollectionView.setEmptyMessage("No Time Slots Available")
                return 0
            }else {
                timesCollectionView.restore()
                return count

            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == resourcesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resourcesCell", for: indexPath) as! ResourcesCollectionViewCell
            guard let resources = resources else {return cell}
            cell.resourcesImageView.addImage(withImage: resources[indexPath.row].image , andPlaceHolder: "")
            cell.resourcesNameLabel.text = resources[indexPath.row].name
            cell.resourcesTitleLabel.text = resources[indexPath.row].position
            if selectedIndexResource == indexPath.row {
                cell.setupSelectView(selected: true)
            }else {
                cell.setupSelectView(selected: false)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! TimeCellCollectionViewCell
            guard let data = selectData else {return cell}
            cell.timeLabel.text = "\(data.times?[indexPath.row].from ?? "") to \(data.times?[indexPath.row].to ?? "")"
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 3 
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

}

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height + 20))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}

