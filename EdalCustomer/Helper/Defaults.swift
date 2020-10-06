//
//  Defaults.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/31/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

class Defaults {

    // MARK: registration
    
    static var FirstName: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "firstName")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "firstName") ?? ""
        }
    }
    
    static var isNotFirstTimeUsingApp: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: "isNotFirstTimeUsingApp")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: "isNotFirstTimeUsingApp")
        }
    }
    static var LastName: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "lastName")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "lastName") ?? ""
        }
    }
    
    static var Image: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "image")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "image") ?? ""
        }
    }
    
    
    
    static var Mobile: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "mobile")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "mobile") ?? ""
        }
    }
    static var Email: String {
          set{
              UserDefaults.standard.set(newValue, forKey: "email")
              UserDefaults.standard.synchronize()
          }
          get{
              return UserDefaults.standard.string(forKey: "email") ?? ""
          }
      }
    static var SocialId: String {
          set{
              UserDefaults.standard.set(newValue, forKey: "SocialId")
              UserDefaults.standard.synchronize()
          }
          get{
              return UserDefaults.standard.string(forKey: "SocialId") ?? ""
          }
      }
    static var SocialToken: String {
             set{
                 UserDefaults.standard.set(newValue, forKey: "SocialToken")
                 UserDefaults.standard.synchronize()
             }
             get{
                 return UserDefaults.standard.string(forKey: "SocialToken") ?? ""
             }
         }
    static var SocialProvider: String {
          set{
              UserDefaults.standard.set(newValue, forKey: "SocialProvider")
              UserDefaults.standard.synchronize()
          }
          get{
              return UserDefaults.standard.string(forKey: "SocialProvider") ?? ""
          }
      }
    static var AgeId: Int {
        set{
            UserDefaults.standard.set(newValue, forKey: "ageId")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: "ageId")
        }
    }
    
    static var AgeTitle: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "ageTitle")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "ageTitle")!
        }
    }
    
    static var CityId: Int {
        set{
            UserDefaults.standard.set(newValue, forKey: "cityId")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: "cityId")
        }
    }
    
    static var CityName: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "cityName")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "cityName")!
        }
    }
    static var DistrictName: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "DistrictName")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "DistrictName") ?? ""
        }
    }
    static var DistrictId: Int {
        set{
            UserDefaults.standard.set(newValue, forKey: "DistrictId")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: "DistrictId")
        }
    }
    static var Location: SelectedLocation {
        set{
            UserDefaults.standard.set(newValue.latitude, forKey: "BILocationLatitude")
            UserDefaults.standard.set(newValue.longitude, forKey: "BILocationLongitude")
            UserDefaults.standard.set(newValue.address, forKey: "BILocationAddress")
            UserDefaults.standard.synchronize()
        }
        get{
            let lat = UserDefaults.standard.double(forKey: "BILocationLatitude")
            let long = UserDefaults.standard.double(forKey: "BILocationLongitude")
            let address = UserDefaults.standard.string(forKey: "BILocationAddress") ?? ""
            return SelectedLocation(address: address, latitude: lat, longitude: long)
        }
    }
    
    
    static var termsAndConditions: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "termsAndConditions")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "termsAndConditions") ?? ""
        }
    }
    
    static var Latitude: Double {
        set{
            UserDefaults.standard.set(newValue, forKey: "Latitude")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.double(forKey: "Latitude")
        }
    }
    
    static var Longitude: Double {
        set{
            UserDefaults.standard.set(newValue, forKey: "Longitude")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.double(forKey: "Longitude")
        }
    }
    static var Password: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "Password")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "Password") ?? "123"
        }
    }
    static var code: Int {
        set{
            UserDefaults.standard.set(newValue, forKey: "code")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: "code")
        }
    }
    
    static var Gender: Int {
        set{
            UserDefaults.standard.set(newValue, forKey: "Gender")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: "Gender")
        }
    }
    
    static var Age: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "Age")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "Age")!
        }
    }
    
    static var FirebaseToken: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "firebaseToken")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "firebaseToken") ?? " "
        }
    }
    static var DeviceId: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "deviceId")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "deviceId") ?? "1"
        }
    }
    
    
    static var token: String {
        set{
            print("token not set yet")
                        UserDefaults.standard.set(newValue, forKey: "token")
                        UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: "token") ?? "not yet"
        }
    }
    
    static var servicesId: Int {
        set{
            UserDefaults.standard.set(newValue, forKey: "servicesId")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: "servicesId")
        }
    }
    
    static var isUserLogged: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: "isUserLogged")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: "isUserLogged")
        }
    }
    
    
    static func saveUserData(with customer: Customer){
        Defaults.FirstName = customer.first_name
        Defaults.LastName = customer.last_name
        guard let customerImage = customer.image else {
            return
        }
        Defaults.Image = customerImage
        Defaults.Email = customer.email
        Defaults.Mobile = customer.mobile
        Defaults.Gender = customer.gender
        Defaults.AgeId = customer.age_id
        
        if let age = customer.age.title {
             Defaults.AgeTitle = age
        }
        if let lat = Double(customer.latitude) {
          Defaults.Latitude = lat
        }
        if let long = Double(customer.longitude) {
           Defaults.Longitude = long
        }
        Defaults.Location.address = customer.location
        if let token = customer.api_token {
           Defaults.token = token
        }
       
        
    }
    
    static func deleteUserData(){
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: "id")
        defaults.removeObject(forKey: "firstName")
        defaults.removeObject(forKey: "lastName")
        defaults.removeObject(forKey: "mobile")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "password")
        defaults.removeObject(forKey: "code")
        defaults.removeObject(forKey: "businessName")
        defaults.removeObject(forKey: "businessPhone")
        defaults.removeObject(forKey: "BICityName")
        defaults.removeObject(forKey: "BICityId")
        defaults.removeObject(forKey: "BIDistrictName")
        defaults.removeObject(forKey: "BIDistrictId")
        defaults.removeObject(forKey: "BILocationLatitude")
        defaults.removeObject(forKey: "BILocationLongitude")
        defaults.removeObject(forKey: "BILocationAddress")
        defaults.removeObject(forKey: "BIBusinessSizeName")
        defaults.removeObject(forKey: "BIBusinessSizeId")
        defaults.removeObject(forKey: "BIYearsOfExperienceName")
        defaults.removeObject(forKey: "BIYearsOfExperienceId")
        defaults.removeObject(forKey: "BICategoryName")
        defaults.removeObject(forKey: "BICategoryId")
        defaults.removeObject(forKey: "BISubCategoryName")
        defaults.removeObject(forKey: "BISubCategoryId")
        defaults.removeObject(forKey: "image")
        defaults.removeObject(forKey: "bg_image")
        defaults.removeObject(forKey: "active")
        defaults.removeObject(forKey: "visible")
        defaults.removeObject(forKey: "imagesCount")
        defaults.removeObject(forKey: "about")
        defaults.removeObject(forKey: "rate")
        defaults.removeObject(forKey: "termsAndConditions")
        defaults.removeObject(forKey: "token")
        
        defaults.synchronize()
    }
    
    
    
    
    
}
