//
//  SubCategoriesVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/30/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class SubCategoriesVC: UITableViewController {
    
    
    @IBOutlet weak var noResultsView: UIView!
    var categoryId: Int = 0
    var categoryName: String = ""
    var subcategories = [SubCategoriesData]()
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        return refresher
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("category id",categoryId)
        getSubCategories()
       // tableView.estimatedRowHeight = 120
        tableView.estimatedRowHeight = 89
        noResultsView.isHidden = true
    }
    @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
        // Update your conntent here
        getSubCategories()
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        handleNavigationBar()
        self.title = categoryName
        // firstField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.reloadData()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = " "
        self.navigationItem.setHidesBackButton(true, animated:true);
        //  self.navigationController?.navigationBar
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func getSubCategories() {
        let services = SearchServices()
        self.showLoading()
        services.getSubCategory(by: categoryId, completion: { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let data = data else{return}
            print("welcome to egypt")
            self.subcategories = data.sub_categories.data
            if self.subcategories.count == 0 {
                self.noResultsView.isHidden = false
            }
            print(self.subcategories)
            
            self.tableView.reloadData()
            
            
        })
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subcategories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoriesCell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = UIColor.init(red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
        cell.tintColor = UIColor.gray
        
        cell.textLabel?.text = subcategories[indexPath.item].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let result = UIView()
        
        // recreate insets from existing ones in the table view
        let insets = tableView.separatorInset
        let width = tableView.bounds.width - insets.left - insets.right
        let sepFrame = CGRect(x: insets.left, y: -0.5, width: width, height: 0.5)
        
        // create layer with separator, setting color
        let sep = CALayer()
        sep.frame = sepFrame
        sep.backgroundColor = tableView.separatorColor?.cgColor
        result.layer.addSublayer(sep)
        
        return result
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
        selectedCell.selectedBackgroundView = backgroundView
        selectedCell.textLabel?.textColor = .white
       // sleep(1)
        DispatchQueue.main.async {
            let navigator = SearchNavigator(nav: self.navigationController)
            navigator.navigate(to: .servicesSubCategories(subCategoryId:self.subcategories[indexPath.item].id, subCategoryName: self.subcategories[indexPath.item].name))
        }
        
        
        //        DispatchQueue.main.async {
        ////            let backgroundView = UIView()
        ////            backgroundView.backgroundColor = UIColor.init(red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
        //           // selectedCell.selectedBackgroundView = backgroundView
        //            selectedCell.textLabel?.textColor = .white
        //            // selectedCell.tintColor = .white
        //
        //            let navigator = HomeNavigator(nav: self.navigationController)
        //            navigator.navigate(to: .servicesSubCategories(subCategoryId: self.subcategories[indexPath.item].id, subCategoryName: self.subcategories[indexPath.item].name))
        //        }
        
        //selectedCell.textLabel?.tintColor = .white
        
        
    }
    
    //    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
    ////        let backgroundView = UIView()
    ////        backgroundView.backgroundColor = .white
    ////        selectedCell.selectedBackgroundView = backgroundView
    ////        selectedCell.textLabel?.textColor = UIColor.init(red: 67/255, green: 128/255, blue: 194/255, alpha: 1.0)
    ////        selectedCell.tintColor = .gray
    //
    //        let backgroundView = UIView()
    //        backgroundView.backgroundColor = UIColor.init(red: 243/255, green: 116/255, blue: 33/255, alpha: 1.0)
    //        selectedCell.selectedBackgroundView = backgroundView
    //        selectedCell.textLabel?.textColor = .white
    //        selectedCell.tintColor = .white
    //    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
