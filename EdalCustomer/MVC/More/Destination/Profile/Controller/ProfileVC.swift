//
//  ProfileVC.swift
//  edal-IosCustomerApp
//
//  Created by Mohamed Kelany on 8/20/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    //MARK:- Properties & Outlets
    //Properties
    var picker_Image: UIImage?{
        didSet{
            guard let image = picker_Image else { return }
            uploadImage(with: image)
        }
    }

    //Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    // MARK: Override Functions
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        setupUI()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        
    }
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        profileImageView.roundView(withCorner: profileImageView.frame.width/2)
        saveButton.roundView(withCorner: saveButton.frame.height/2)
        
    }

    //MARK:- Methods & Actions
    //Actions
    @IBAction func onTappedCamera(_ sender: UIButton) {
        addImage()
    }
    
    
    
    @IBAction func onTappedSave(_ sender: UIButton) {
        guard let picker = picker_Image else {
            self.alertUser(title: "", message: "you should pick an image")
            return
        }
        uploadImage(with: picker)
    //self.navigationController?.popToRootViewController(animated: true)
        let navigator = ProfileNavigator(nav: self.navigationController)
        navigator.navigate(to: .categories)
    }
    
    @IBAction func onTappedSkip(_ sender: UIButton) {
       // self.navigationController?.popToRootViewController(animated: true)
        // uploadImage(with: picker_Image!)
        let navigator = ProfileNavigator(nav: self.navigationController)
        navigator.navigate(to: .categories)
    }
    
    //MARK:- Methods
    //APIs Methods
    func uploadImage(with image: UIImage){
        showLoading()
        ProfileServices().updateImage(withImage: image) { (error, response) in
            self.hideLoading()
            if let error = error{
                self.alertUser(title: "", message: error)
                self.profileImageView.image =  #imageLiteral(resourceName: "avatar")
               // self.imagePath = nil
                return
            }
            
            guard let response = response else {
                self.profileImageView.image = #imageLiteral(resourceName: "avatar")
                return
            }
            
            self.profileImageView.image = self.picker_Image
            //Defaults.token = response.customer.api_token!
//            let navigator = ProfileNavigator(nav: self.navigationController)
//            navigator.navigate(to: .categories())
            
        }
    }
    
    //Other Methods
    
    

}


// MARK: UIImagePickerControllerDelegate , UINavigationControllerDelegate
extension ProfileVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func addImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.accessibilityLanguage = LanguageManger.shared.currentLanguage.rawValue
        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                imagePickerController.allowsEditing = true
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("camera is not available")
            }
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage{
            picker_Image = editedImage
        }else if let originalImage = info[.originalImage] as? UIImage{
            picker_Image = originalImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
