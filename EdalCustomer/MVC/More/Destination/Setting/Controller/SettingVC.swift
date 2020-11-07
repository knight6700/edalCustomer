//
//  SettingVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 10/16/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class SettingVC: UITableViewController {
    @IBOutlet weak var switcher: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.selectionStyle = .none
        self.tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.selectionStyle = .none
        self.tableView.tableFooterView = UIView()
        //viewDidload
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTappedSwitcher(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.3) {
            sender.thumbTintColor = sender.isOn ?  #colorLiteral(red: 0.323800981, green: 0.5801380277, blue: 0.8052206635, alpha: 1) : #colorLiteral(red: 0.7472794652, green: 0.7472972274, blue: 0.7472876906, alpha: 1)
            sender.tintColor = .white
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let id = "LanguageVC"
            let vc = Initializer.createViewController(storyBoard: .SettingSB, andId: id) as! LanguageViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
