//
//  AuthenticationVC.swift
//  edalCustomerTest
//
//  Created by Mohamed Kelany on 7/31/18.
//  Copyright © 2018 Mohamed Kelany. All rights reserved.
//

import UIKit
import GoogleSignIn
//import FacebookLogin
import FBSDKLoginKit
//import FacebookCore

class AuthenticationVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var socialMediaView: UIView!
    
    // MARK: Properties
    var dict : [String : AnyObject]!
    var email: String!
    var firstName: String!
    var lastName: String!
    // MARK: Override Functions
    // viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(AccessToken.current == nil)
        {
            print(AccessToken.current)
            print("not logged in")
        }
        else{
            print("logged in already")
        }
        
        // facebookButton.readPermissions = ["public_profile","email"]
        //facebookButton.delegate = self
        
        //  handleLocalization()
        configuration()
        setupUI()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Methods
    // configuration: to configure any protocols
    func configuration(){
        
    }
    
    
    // setupUI: to setup data or make a custom design
    func setupUI(){
        loginButton.roundView(withCorner: loginButton.frame.height/2)
        socialMediaView.roundView(withCorner: socialMediaView.frame.height/2)
    }
    
    func handleNavigationBar(){
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // MARK: Actions
    @IBAction func onTapLogin(_ sender: UIButton) {
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .login)
    }
    
    @IBAction func onTapChangeLanguage(_ sender: UIButton) {
        let alert = UIAlertController(title: "change language", message: "", preferredStyle: .alert)
        let arabicAction = UIAlertAction(title: "arabic", style: .default) { (_) in
            let selectedLanguage: Languages = .ar
            LanguageManger.shared.setLanguage(language: selectedLanguage)
            self.goToMain()
        }
        let englishAction = UIAlertAction(title: "english", style: .default) { (_) in
            let selectedLanguage: Languages = .en
            LanguageManger.shared.setLanguage(language: selectedLanguage)
            self.goToMain()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alert.addAction(arabicAction)
        alert.addAction(englishAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToMain(){
        // return to root view contoller and reload it
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: StoryBoard.AuthenticationSB.rawValue, bundle: nil)
        delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
        delegate.window?.makeKeyAndVisible()
    }
    
    @IBAction func onTapGoogleSignUp(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func navigateToRegister() {
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .registration(firstName: firstName, lastName: lastName, email: email))
    }
    
    @IBAction func onTapFacebookSignUp(_ sender: UIButton) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, gender, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as? [String : AnyObject]
                    print(result!)
                    self.firstName = self.dict["first_name"]! as? String
                    self.lastName = self.dict["last_name"]! as? String
                    self.email = self.dict["email"] as! String
                    let gender =  self.dict["gender"] as? String
//                    print(gender)
                    
//                    let navigator = AuthNavigator(nav: self.navigationController)
//                    navigator.navigate(to: .registration(firstName: self.firstName, lastName: self.lastName, email: self.email))
                    self.showLoading()
                    let services = AuthenticationServices()
                    services.LoginSocialMedia(provider_token: AccessToken.current!.tokenString, AndSocialMediaId:  self.dict["id"] as! String, AndSocialMediaType: "facebook") { (error, model) in
                        
                        self.hideLoading()
                        if let _ = error {
                            Defaults.SocialId = self.dict["id"] as! String
                            Defaults.SocialToken = AccessToken.current!.tokenString
                            Defaults.SocialProvider = "facebook"
                            
                            let navigator = AuthNavigator(nav: self.navigationController)
                            navigator.navigate(to: .registration(firstName: self.firstName, lastName: self.lastName, email: self.email))
                            
                        }
                        
                        guard let data = model else {return}
                        Defaults.token = (data.customer?.api_token)!
                        print("token:\(Defaults.token)")
                        Defaults.FirstName = (data.customer?.first_name)!
                        Defaults.LastName = (data.customer?.last_name)!
                        Defaults.Email = (data.customer?.email)!
                        if Defaults.isNotFirstTimeUsingApp {
                            let navigator = ProfileNavigator(nav: self.navigationController)
                            navigator.navigate(to: .home)
                        } else {
                            let navigator = ProfileNavigator(nav: self.navigationController)
                            navigator.navigate(to: .categories)
                        }
                      
                        
                    }
                }
            })
        }
    }
    @IBAction func onTapSignUp(_ sender: UIButton) {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        let navigator = AuthNavigator(nav: self.navigationController)
        navigator.navigate(to: .registration(firstName: nil, lastName: nil, email: nil))
    }
    
    
    
    func handleCustomFBLogin() {
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil {
                print("FB Login failed", err ?? "")
                return
            }
            
            print(result?.token?.tokenString ?? "")
            self.showFBEmailAddress()
        }
    }
    
    func showFBEmailAddress() {
        GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email,gender"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            let arr : [String] = result as! [String]
            print(arr)
        }
    }
}


extension AuthenticationVC: /*GIDSignInUIDelegate,*/ GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            let idToken = user.authentication.idToken
            guard let fullName = user.profile.name else { return }
            let fullNameArr = fullName.components(separatedBy: " ")
            let _firstName    = fullNameArr[0]
            let _lastName = fullNameArr[1]
            guard let _email = user.profile.email else { return }
            firstName = _firstName
            lastName = _lastName
            email = _email
            self.showLoading()
            let services = AuthenticationServices()
            services.LoginSocialMedia(provider_token: idToken!, AndSocialMediaId:  user.userID, AndSocialMediaType: "google") { (error, model) in
                self.hideLoading()
                if let _ = error {
                    Defaults.SocialId = user.userID
                    Defaults.SocialToken = idToken!
                    Defaults.SocialProvider = "google"
                    let navigator = AuthNavigator(nav: self.navigationController)
                    navigator.navigate(to: .registration(firstName: self.firstName, lastName: self.lastName, email: self.email))
                }
                
                guard let data = model else {return}
                Defaults.token = (data.customer?.api_token)!
                print("token:\(Defaults.token)")
                Defaults.FirstName = (data.customer?.first_name)!
                Defaults.LastName = (data.customer?.last_name)!
                Defaults.Email = (data.customer?.email)!
                 
                if Defaults.isNotFirstTimeUsingApp {
                    let navigator = ProfileNavigator(nav: self.navigationController)
                    navigator.navigate(to: .home)
                } else {
                    let navigator = ProfileNavigator(nav: self.navigationController)
                    navigator.navigate(to: .categories)
                }
            }
            
//            navigateToRegister()
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
        guard error == nil else {
            print("Error while trying to redirect : \(error)")
            return
        }
        print("Successful Redirection")
    }
    
    
    
}
