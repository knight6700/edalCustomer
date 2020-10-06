//
//  SortingByVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 9/19/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class SortingByVC: UITableViewController {

    
    
    @IBOutlet weak var cancelDoneCell: UITableViewCell!
    @IBOutlet weak var atozCell: UITableViewCell!
    @IBOutlet weak var lowtohighPriceCell: UITableViewCell!
    @IBOutlet weak var hightolowPriceCell: UITableViewCell!
    @IBOutlet weak var topratedCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.tabBarController?.tabBar.layer.zPosition = -1
        // Do any additional setup after loading the view.
    }
    @IBAction func onTappedCancelButton(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTappedDoneButton(_ sender: UIButton) {
       // self.tabBarController?.tabBar.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // let cell = UITableViewCell()
        if indexPath.row == 0 {
            atozCell.accessoryType = .checkmark
            lowtohighPriceCell.accessoryType = .none
            hightolowPriceCell.accessoryType = .none
            topratedCell.accessoryType = .none
        }
        if indexPath.row == 1 {
            lowtohighPriceCell.accessoryType = .checkmark
            atozCell.accessoryType = .none
           // lowtohighPriceCell.accessoryType = .none
            hightolowPriceCell.accessoryType = .none
            topratedCell.accessoryType = .none
        }
        if indexPath.row == 2 {
           hightolowPriceCell.accessoryType = .checkmark
            atozCell.accessoryType = .none
            lowtohighPriceCell.accessoryType = .none
           // hightolowPriceCell.accessoryType = .none
            topratedCell.accessoryType = .none
        }
        if indexPath.row == 3 {
           topratedCell.accessoryType = .checkmark
            atozCell.accessoryType = .none
            lowtohighPriceCell.accessoryType = .none
            hightolowPriceCell.accessoryType = .none
           // topratedCell.accessoryType = .none
        }
       // cell.accessoryType = .none
    }
  
}
