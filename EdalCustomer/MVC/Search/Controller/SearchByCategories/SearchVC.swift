//
//  SearchVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/23/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var timeTextFiled: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var selectCityDistrictButton: TextFieldImage!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var categoriesPageControl: UIPageControl!
    
    @IBOutlet weak var CatCollectionView: UICollectionView!
    @IBOutlet weak var selectCityDistrictView: UIView!
    
    @IBOutlet weak var indicatorCityDistrictImage: UIImageView!
    var categoriesData = [CategoriesData]()
    var paginationCategoriesData = [CategoriesData]()
    var firstCollectionViewData = [CategoriesData]()
    var secondCollectionViewData = [CategoriesData]()
    var thirdCollectionViewData = [CategoriesData]()
    var fourthCollectionViewData = [CategoriesData]()
    var picker: UIPickerView?
    var searchByCategory: Bool = false
    var selectedDistrictId = 0
    var citiesData = [CitiesDistrictsDatum]()
    var citiesDataIds = [Int]()
    var districtData = [DistrictDatum]()
    var citiesDistrictsArray = [String]()
    var selectedCategoriesId = [Int]()
    var CategoriesTotalpages: Int = 1
    var current_page: Int = 1
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let categoriesVC = CategoriesVC()
    var categoryList = [[CategoriesData]]()
    var districtIds: [Int] = []
    var stopPagination = false
    var currentOffsetX = 0
    var time: Int = 0
    var cityDistrictDataPicker: [String] = ["Choose City, Distract"]
    var searchLookUpsResponse: SearchLookUpsResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        SingletonClass.shared.searchNav = self.navigationController!
        Configuartion()
        setupUI()
        getSearchLooksUp()
        //getAllCategoriesOneTime(for: 1)
    }
    
    
    func Configuartion() {
        CatCollectionView.delegate = self
        CatCollectionView.dataSource = self
        
        //loadMoreCategories(page: current_page)
        showDatePicker()
        showTimePicker()
        
    }
    
    func setupUI() {
        //searchTextField.addLeftView()
        SetLeftSIDEImage(TextField: searchTextField, ImageName: "searchIcon")
        SetLeftSIDEImage(TextField: dateTextField, ImageName: "dateIcon")
        SetLeftSIDEImage(TextField: timeTextFiled, ImageName: "timeIcon")
        searchTextField.roundView(withCorner: 8.0)
        selectCityDistrictButton.roundView(withCorner: 8.0)
        selectCityDistrictButton.placeholder = "Choose City, Distract"
        timeTextFiled.roundView(withCorner: 8.0)
        dateTextField.roundView(withCorner: 8.0)
        searchButton.roundView(withCorner: 8.0)
        selectCityDistrictView.roundView(withCorner: 8.0)
        searchButton.backgroundColor = #colorLiteral(red: 0.323800981, green: 0.5801380277, blue: 0.8052206635, alpha: 0.7860804966)
        [searchTextField, timeTextFiled, dateTextField, timeTextFiled,selectCityDistrictButton].forEach { (textField) in
            textField?.delegate = self
        }
    }
    
    func showPickerInActionSheet() {
        let title = ""
        let message = "\n\n\n\n\n\n\n\n\n\n"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        alert.modalPresentationStyle = .overCurrentContext
        //Create a frame (placeholder/wrapper) for the picker and then create the picker
        let pickerFrame: CGRect = CGRect(x: 17,y: 52,width: 270,height: 200) // CGRectMake(left), top, width, height) - left and top are like margins
        picker = UIPickerView(frame: pickerFrame)
        picker?.translatesAutoresizingMaskIntoConstraints = false
        //set the pickers datasource and delegate
        self.picker?.delegate = self
        self.picker?.dataSource = self
        //Create the toolbar view - the view witch will hold our 2 buttons
        let toolFrame = CGRect(x: 0,y:  7, width: alert.view.frame.width, height: 45)
        let toolView: UIView = UIView(frame: toolFrame)
        
        //add buttons to the view
        let buttonCancelFrame: CGRect = CGRect(x:0,y: 7,width: 100, height: 30) //size & position of the button as placed on the toolView
        
        //Create the cancel button & set its title
        let buttonCancel: UIButton = UIButton(frame: buttonCancelFrame)
        buttonCancel.setTitle("Cancel", for: UIControl.State.normal)
        buttonCancel.setTitleColor(UIColor.blueColor(), for: UIControl.State.normal)
        buttonCancel.addTarget(self, action: #selector(cancelSelection), for: .touchUpInside)
        toolView.addSubview(buttonCancel) //add it to the toolView
        
        //Add the target - target, function to call, the event witch will trigger the function call
        
        
        
        //add buttons to the view
        let buttonOkFrame: CGRect = CGRect(x: alert.view.frame.width - (100),y: 7, width: 100, height: 30) //size & position of the button as placed on the toolView
        //Create the Select button & set the title
        let buttonOk: UIButton = UIButton(frame: buttonOkFrame)
        buttonOk.setTitle("Done", for: UIControl.State.normal)
        buttonOk.setTitleColor(UIColor.blueColor(), for: UIControl.State.normal)
        toolView.addSubview(buttonOk); //add to the subview
        //Add the tartget. In my case I dynamicly set the target of the select button
        buttonOk.addTarget(self, action: #selector(doneSelection), for: .touchUpInside)
        let popUpStack = UIStackView(frame: self.view.bounds)
        popUpStack.axis = .vertical
        popUpStack.distribution = .fillEqually
        popUpStack.alignment = .fill
        popUpStack.spacing = 5
        popUpStack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        picker!.translatesAutoresizingMaskIntoConstraints = false
        popUpStack.addArrangedSubview(toolView)
        popUpStack.addArrangedSubview(picker!)
        //add the toolbar to the alert controller
        // alert.view.addSubview(picker!)
        alert.view.addSubview(popUpStack)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func cancelSelection(){
        print("Cancel")
        self.dismiss(animated: true, completion: nil)
        selectCityDistrictButton.text = ""
        // We dismiss the alert. Here you can add your additional code to execute when cancel is pressed
    }
    @objc func doneSelection(){
        print("Done")
        self.dismiss(animated: true, completion: nil)
        // We dismiss the alert. Here you can add your additional code to execute when cancel is pressed
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
        CatCollectionView.allowsMultipleSelection = false
        getAllCategoriesOneTime(for: 1)
        refreshAllInputs()
    }
    
    @IBAction func pressedCityAndDistrectied(_ sender: Any) {
        self.view.endEditing(true)
        searchTextField.endEditing(true)
        showPickerInActionSheet()
        getIndicatorTintColor(image: indicatorCityDistrictImage)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        print("window will go")
    }
    func refreshAllInputs(){
        searchTextField.text = ""
        dateTextField.text = ""
        timeTextFiled.text = ""
    }
    func getIndicatorTintColor(image: UIImageView?){
        guard let imageView = image else {
            return
        }
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
    }
    
    
    //MARK:- Handling Navigation Bar
    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = " "
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func SetLeftSIDEImage(TextField: UITextField, ImageName: String){
        // rgb 66 156 225
        
        let leftImageView = UIImageView()
        leftImageView.contentMode = .scaleAspectFit
        
        let leftView = UIView()
        
        leftView.frame = CGRect(x: 20, y: 0, width: 30, height: 20)
        leftImageView.frame = CGRect(x: 13, y: 0, width: 15, height: 20)
        TextField.leftViewMode = .always
        TextField.leftView = leftView
        
        let image = UIImage(named: ImageName)?.withRenderingMode(.alwaysTemplate)
        leftImageView.image = image
        if ImageName == "searchIcon"{
            leftImageView.tintColor = UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
            leftImageView.tintColorDidChange()
        } else {
            leftImageView.tintColor = UIColor(red: 66/255, green: 156/255, blue: 225/255, alpha: 1.0)
            leftImageView.tintColorDidChange()
        }
        
        leftView.addSubview(leftImageView)
    }
    
    func showDatePicker(){
        //Formate Date
        self.view.endEditing(true)
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        self.view.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.dismiss(animated: true)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func showTimePicker(){
        //Formate Date
        self.view.endEditing(true)
        timePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        timeTextFiled.inputAccessoryView = toolbar
        timeTextFiled.inputView = timePicker
        
    }
    
    @objc func doneTimePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        timeTextFiled.text = formatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelTimePicker(){
        self.view.endEditing(true)
    }
    
    
    var selectedDistrictIdWillPassed:Int?
    @IBAction func onTappedSearch(_ sender: UIButton) {
        guard let keyword = searchTextField.text else {return}
        guard let date = dateTextField.text else {return}
        guard let time = timeTextFiled.text else {return}
        print(keyword)
        print(date)
        print(time)
        let navigator = SearchNavigator(nav: self.navigationController)
        navigator.navigate(to: .providerServicesFromSearch(searchkey: keyword, cityDistrict: selectedDistrictId, date: date, time: time))
    }
    
    func gettotalPagesofCategories(){
        let services = CategoriesServices()
        services.getAllCategories(for: current_page, completion: { (error, data) in
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _data = data else{return}
            self.CategoriesTotalpages = ((_data.paginated_categories?.meta?.pagination?.total_pages)!)
        })
    }
    
    func getAllLookUps()  {
        let services = CategoriesServices()
        services.getAllCities { [weak self] (error: String?, data: SearchLookUpsResponse?) in
            guard error == nil else {
                self?.alertUser(title: "Error", message: error ?? "")
                return
            }
            self?.searchLookUpsResponse = data
        }
    }
    
    
    
    //MARK: fetchMoreCategories
    func loadMoreCategories(page: Int){
        print(current_page)
        if current_page <= CategoriesTotalpages {
            //getAllCategories(for: page)
            print("current_page<CategoriesTotalpages",current_page, CategoriesTotalpages)
           //current_page = current_page + 1
        }else {
            stopPagination = true
            return
        }
    }
    var allData = [[CategoriesData]]()
    func getAllCategoriesOneTime(for page: Int) {
        self.showLoading()
        let services = CategoriesServices()
        services.getAllCategories(for: page, completion: { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _data = data else{return}
            
            //self.categoriesData.removeAll()
            
            self.categoriesData = (_data.paginated_categories?.data)!
            self.CategoriesTotalpages = (_data.paginated_categories?.meta?.pagination?.total_pages)!
            self.categoriesPageControl.numberOfPages = self.CategoriesTotalpages
            self.allData = Array.init(repeating: [], count: self.CategoriesTotalpages)
            self.CatCollectionView.reloadData()
            print(self.categoriesData)
            
            
        })
        self.hideLoading()
    }
    
    func getAllCategories(for page: Int) {
        self.showLoading()
        let services = CategoriesServices()
        services.getAllCategories(for: page + 1, completion: { (error, data) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                return
            }
            guard let _data = data else{return}
            //self.categoriesData.removeAll()
            self.categoriesData = (_data.paginated_categories?.data)!
            self.CategoriesTotalpages = (_data.paginated_categories?.meta?.pagination?.total_pages)!
            self.categoriesPageControl.numberOfPages = self.CategoriesTotalpages
            self.allData[page] = (_data.paginated_categories?.data)!
            self.CatCollectionView.reloadData()
            print(self.categoriesData)
            
            
        })
        self.hideLoading()
    }
    
    func getSearchLooksUp() {
        let services = CategoriesServices()
        services.getAllCities { [weak self] (error: String?, data: SearchLookUpsResponse?) in
            guard error == nil else {
                self?.alertUser(title: "Error", message: error ?? "")
                return
            }
            self?.searchLookUpsResponse = data
            self?.picker?.dataSource = self
            self?.picker?.delegate = self
            self?.picker?.reloadAllComponents()

        }

    }
    
    
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    }
}

extension SearchVC: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //setting active indicator
        let pageNum = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        categoriesPageControl.currentPage = Int(pageNum)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentOffsetX = Int(scrollView.contentOffset.x)
        print("currentOffsetX",currentOffsetX)
        print("Int(scrollView.contentOffset.x)", Int(scrollView.contentOffset.x))
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("currentOffsetX",currentOffsetX)
        print("Int(scrollView.contentOffset.x)",Int(scrollView.contentOffset.x))
        print("(Int(UIScreen.main.bounds.width)*(CategoriesTotalpages)", (Int(UIScreen.main.bounds.width)*(CategoriesTotalpages)))
        print("(Int(UIScreen.main.bounds.width)*(CategoriesTotalpages-1)", (Int(UIScreen.main.bounds.width)*(CategoriesTotalpages-1)))
        
        //handling starting of scroll
        if currentOffsetX == 0 && Int(scrollView.contentOffset.x) < 0 {
            return
        }
        //handling next scrolling
        if currentOffsetX <= Int(scrollView.contentOffset.x) && Int(scrollView.contentOffset.x) < (Int(UIScreen.main.bounds.width)*(CategoriesTotalpages-1))  {
            print("(Int(UIScreen.main.bounds.width)*(CategoriesTotalpages))",(Int(UIScreen.main.bounds.width)*(CategoriesTotalpages)))
                current_page = current_page + 1
               // getAllCategories(for: current_page)
        }
        //handling previous scrolling
        if currentOffsetX > 0 && Int(scrollView.contentOffset.x) < currentOffsetX  {
            current_page = current_page - 1
            //getAllCategories(for: current_page)
        }
        // handling end of scroll
        if currentOffsetX <= Int(scrollView.contentOffset.x) && currentOffsetX == (Int(UIScreen.main.bounds.width)*(CategoriesTotalpages-1)) {
            return
//            current_page = CategoriesTotalpages
//            getAllCategories(for: current_page)
        }
    }
    
}


extension SearchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(collectionView.frame.width)
        let cell =  CatCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.categoriesObject = categoriesData
        ///cell.returnDate(stopPagination: stopPagination, data: [])
        if allData[indexPath.row].count == 0 {
            getAllCategories(for: indexPath.row)
        } 
        cell.returnDate(stopPagination: stopPagination, data: allData[indexPath.row])
//        if indexPath.item >= 0 {
//            if time == 1 {
//                self.stopPagination = false
//                cell.categoriesObject = []
//                cell.returnDate(stopPagination: stopPagination, data: [])
//                cell.returnDate(stopPagination: stopPagination, data: self.categoriesData)
//                time = 0
//            } else {
//                self.stopPagination = true
//                cell.returnDate(stopPagination: stopPagination, data: self.categoriesData)
//                time = 1
//            }
//        }
//        if indexPath.item == 0 && currentOffsetX == 0 {
//            self.stopPagination = false
//             cell.returnDate(stopPagination: stopPagination, data: self.categoriesData)
//             time = 0
//        }
//       
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
}
extension SearchVC: UIPickerViewDelegate {
    // returns number of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        self.view.endEditing(true)
        print(cityDistrictDataPicker.count)
        if component == 0 {
            return self.searchLookUpsResponse?.defaultResponse.citiesDistricts.data.count ?? 0
        }else {
            return 0
        }
    }
    
    // Return the title of each row in your picker ... In my case that will be the profile name or the username string
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(self.searchLookUpsResponse?.defaultResponse.citiesDistricts.data[row].name ?? "")"
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.view.endEditing(true)
        selectCityDistrictButton.text = self.searchLookUpsResponse?.defaultResponse.citiesDistricts.data[row].name ?? ""
        if row == 0 {
          selectedDistrictId = 0
        }else {
            selectedDistrictId = self.searchLookUpsResponse?.defaultResponse.citiesDistricts.data[row].id ?? 0
        }
        
        print("selectedDistrictId", selectedDistrictId)
        
    }
}
extension SearchVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
}
extension SearchVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchButton.isEnabled = false
        if timeTextFiled.text != "" , searchTextField.text != "",
            dateTextField.text != "", searchTextField.text != "",
        selectCityDistrictButton.text != "" {
            searchButton.isEnabled = true
            searchButton.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.5019607843, blue: 0.7607843137, alpha: 1)
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == selectCityDistrictButton {
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.view.endEditing(true)
        searchTextField.endEditing(true)
        selectCityDistrictButton.endEditing(true)
        searchButton.isEnabled = false
        searchButton.backgroundColor = #colorLiteral(red: 0.323800981, green: 0.5801380277, blue: 0.8052206635, alpha: 0.7860804966)
        if timeTextFiled.text != "" , searchTextField.text != "",
            dateTextField.text != "", searchTextField.text != "",
        selectCityDistrictButton.text != "" {
            searchButton.isEnabled = true
            searchButton.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.5019607843, blue: 0.7607843137, alpha: 1)
        }
    }
}














