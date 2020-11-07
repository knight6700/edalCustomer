//
//  ReopenComplaintVC.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 9/11/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ReopenComplaintVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    // MARK: Outlets
    
    // MARK: Properties
    
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setupUI()
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        
    }
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        configurationTextView()
    }
    
    func configurationTextView() {
        textView.text = "\n Enter your Comment here!"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: "verdana", size: 13.0)
        textView.returnKeyType = .done
        textView.delegate = self

    }
    // MARK: Actions
    @IBAction func onTapReopen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
extension ReopenComplaintVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "\n Enter your Comment here!" {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "verdana", size: 18.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "\n Enter your Comment here!"
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "verdana", size: 16.0)
        }
    }

}
