//
//  AppDelegate.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 22/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
//import Firebase
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import FBSDKCoreKit
//import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        // Override point for customization after application launch.
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { (isSuccess, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            })
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        //firebase configuration
//        FirebaseApp.configure()
        application.registerForRemoteNotifications()
        
        //facebook sign in Integration
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Google Sign in Integration
        //GIDSignIn
        GIDSignIn.sharedInstance().clientID = "903375999556-7pjaj20ej7rgsu1m288grgi37j32fuql.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().uiDelegate = self
        // LanguageManger.shared.defaultLanguage = .en
        IQKeyboardManager.shared.enable = true
        setupGoogleMap()
        setupNavigationController()
        setupLanguage()
        print("Default token",Defaults.token)
//        gotoHomePage()
    
      //  print(Defaults.token)
       // print(Defaults.DeviceId)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options:[UIApplication.OpenURLOptionsKey : Any]=[:] ) -> Bool {
        
        //handling redirecting to facebook signin
//        let handled = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        //handling redirecting to google sign in
//      GIDSignIn.sharedInstance().handle(url ,  sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?,
//                                          annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//        return handled
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url)

        return googleDidHandle
    }
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setupGoogleMap(){
        let key = "AIzaSyBL8JJnr5yn1wO3HuaJ2FUyFIeoJEW18vA"
        GMSServices.provideAPIKey(key)
        GMSPlacesClient.provideAPIKey(key)
    }
    
    func setupNavigationController(){
        
    }
    func gotoHomePage() {
        //window = UIWindow(frame: UIScreen.main.bounds)
        if !(Defaults.token == "not yet") {
            Router().toHomeTabBarVC()

        } else {
            let loginController = UIStoryboard(name: "AuthenticationSB", bundle: nil).instantiateInitialViewController()
            window?.rootViewController = loginController
        }
    }
    
    func setupLanguage(){
        let shared = LanguageManger.shared
        if let currentLang = Languages(rawValue: NSLocale.current.languageCode ?? ""){
            shared.setLanguage(language: currentLang)
        }
    }
    
}


extension AppDelegate : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        }
        print("logged in successfully")
        //user.profile.gen
        Defaults.FirstName = user.profile.familyName
        
        
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate
{
    
    // Called when Registration is successfull
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
   /*     InstanceID.instanceID.instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                Defaults.FirebaseToken = result.token
                print(Defaults.FirebaseToken)
            }
            
        }*/
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registration failed!")
    }
    
    
    // Firebase notification received
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
        
        // custom code to handle push while app is in the foreground
        print("Handle push from foreground \(notification.request.content.userInfo)")
        
        
        // Reading message body
        let dict = notification.request.content.userInfo["aps"] as! NSDictionary
        
        var messageBody:String?
        var messageTitle:String = "Alert"
        
        if let alertDict = dict["alert"] as? Dictionary<String, String> {
            messageBody = alertDict["body"]!
            if alertDict["title"] != nil { messageTitle  = alertDict["title"]! }
            
        } else {
            messageBody = dict["alert"] as? String
        }
        
        print("Message body is \(messageBody!) ")
        print("Message messageTitle is \(messageTitle) ")
        // Let iOS to display message
        completionHandler([.alert,.sound, .badge])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Message \(response.notification.request.content.userInfo)")
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Entire message \(userInfo)")
        
        let state : UIApplication.State = application.applicationState
        switch state {
        case UIApplicationState.active:
            print("If needed notify user about the message")
        default:
            print("Run code to download content")
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
//    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
//        print("Token refreshed")
//
//        guard let newToken = Messaging.messaging().fcmToken else { return }
//
//        print("new token is here: \(newToken)")
//        connectToFcm(withToken: newToken)
//    }
    
    func connectToFcm(withToken token: String) {
        print("\nconnectToFCM\n")
        Defaults.FirebaseToken = token
//        Messaging.messaging().shouldEstablishDirectChannel = true
        
        refreshFirebaseToken()
    }
    
    func refreshFirebaseToken(){
        //        guard UsersDefault.Token == "" else { return }
        //        Services.RefreshFirebaseToken { (error, sucsess) in
        //            if let error = error{
        //                print("error in refreshFirebaseToken: \(error)")
        //                return
        //            }
        //
        //        }
    }
    
    func updateBadgeCount()
    {
        var badgeCount = UIApplication.shared.applicationIconBadgeNumber
        if badgeCount > 0
        {
            badgeCount = badgeCount-1
        }
        
        UIApplication.shared.applicationIconBadgeNumber = badgeCount
    }
    
}

//extension UIApplication {
//
//    static var loginAnimation: UIViewAnimationOptions = .transitionFlipFromRight
//    static var logoutAnimation: UIViewAnimationOptions = .transitionCrossDissolve
//
//    public static func setRootView(_ viewController: UIViewController,
//                                   options: UIViewAnimationOptions = .transitionFlipFromRight,
//                                   animated: Bool = true,
//                                   duration: TimeInterval = 0.5,
//                                   completion: (() -> Void)? = nil) {
//        guard animated else {
//            UIApplication.shared.keyWindow?.rootViewController = viewController
//            return
//        }
//
//        UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {
//            let oldState = UIView.areAnimationsEnabled
//            UIView.setAnimationsEnabled(false)
//            UIApplication.shared.keyWindow?.rootViewController = viewController
//            UIView.setAnimationsEnabled(oldState)
//        }) { _ in
//            completion?()
//        }
//    }
//}




