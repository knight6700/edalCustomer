//
//  MyEdalDetailsViewController.swift
//  EdalCustomer
//
//  Created by Mahmoud Fares on 10/27/20.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import Cosmos
class MyEdalDetailsViewController: UIViewController {
    // MARK: Outlet UI
    @IBOutlet weak var providerImage: UIImageView!
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var providerTypeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var resourceNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeFromToLabel: UILabel!
    @IBOutlet weak var bookinAnswerLabel: UILabel!
    @IBOutlet weak var leavingNoteAnswerLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    // MARK: Variables
    var data: Datum?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }


    private func setupUI() {
        guard let data = data else { return }
        providerImage.setRounded(color: .gray)
        providerImage.addImage(withImage: data.providerImage ?? "", andPlaceHolder: "oval3Copy")
        providerNameLabel.text = data.providerName ?? ""
        providerTypeLabel.text = data.subServiceTitle ?? ""
        statusLabel.text = data.statusText ?? ""
        dateLabel.text = data.startDate ?? ""
        serviceTypeLabel.text = data.subServiceTitle ?? ""
        resourceNameLabel.text = data.resourceName ?? ""
        priceLabel.text = "\(data.price ?? 0.0) EGP"
        timeFromToLabel.text = "\(data.from ?? "") - \(data.to ?? "")"
        setStatusColor(id: data.status ?? -1)
        // MARK: TO DO
//        bookinAnswerLabel.text = ""
//        leavingNoteAnswerLabel.text = ""
    }
    
    
    fileprivate  func setStatusColor(id: Int) {
        switch id {
            case 1:
                statusLabel.textColor = .yellow
            case  2:
                break
            case 3:
                statusLabel.textColor = .green
            case 4:
                statusLabel.textColor = #colorLiteral(red: 0.3541823626, green: 0.6177722812, blue: 0.9613298774, alpha: 1)
            case 5:
                statusLabel.textColor = .orange
            case 6:
                statusLabel.textColor = .green
            case 7:
                statusLabel.textColor = .red
            case 8:
                statusLabel.textColor = .red
            default:
                statusLabel.textColor = .black
        }
    }
    
    @IBAction func complaintPressed(_ sender: Any) {
    }
    
    fileprivate func handleRateView() {
        UIView.transition(with: rateView , duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.rateView.isHidden.toggle()
        })

        rateView.didFinishTouchingCosmos = { [weak self] rating in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.transition(with: self?.rateView ?? UIView(), duration: 0.4,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self?.rateView.isHidden = true
                })
                self?.showToast(message: "Rating Done")
            }
        }
    }
    
    @IBAction func ratePressed(_ sender: Any) {
        handleRateView()

    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension MyEdalDetailsViewController {
    
}
