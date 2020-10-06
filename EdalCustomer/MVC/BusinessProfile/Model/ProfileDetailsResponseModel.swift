//
//  ProfileDetailsResponseModel.swift
//  EdalCustomer
//
//  Created by Mahmoud Maamoun on 22/05/2020.
//  Copyright © 2020 Mahmoud Maamoun. All rights reserved.
//

import UIKit
import ObjectMapper

class HomeProvidersDatum: Mappable {
    
   
    var id: Int? = 0
      var api_token: String? = ""
      var business_name: String? = ""
      var first_name: String? = ""
      var last_name: String? = ""
      var email: String? = ""
      var mobile: String? = ""
      var image: String? = ""
      var bg_image: String? = ""
      var phone: String? = ""
      var address = ""
      var latitude: String? = "0.0"
      var longitude: String? = "0.0"
      var about: String? = ""
      var website_link: String? = ""
      var facebook_link: String? = ""
      var city: City?
      var twitter_link: String? = ""
      var instagram_link: String? = ""
      var active: Int? = 0
      var visible: Int? = 0
      var images_count: Int? = 0
      var rate: Double? = 0.0
      var min_value: Int? = 0
      var max_value: Int? = 0
      var year: Year?
      var businessSize: BusinessSize?
      var district: District?
      var subCategory: SubCategory?
      var mainCategory: MainCategory?
     
      var isMain: Bool? = false
      var businessName: String? = ""
      var firstName: String? = ""
      var lastName: String? = ""
      
      var bgImage: String? = ""
     
      var yearId: Int?
      var businessSizeId: Int?
      var districtId: Int?
      
      var websiteLink: Any?
      var facebookLink: Any?
      var twitterLink: Any?
      var instagramLink: Any?
       
      var favorite: Bool? = false
      var subCategoryName: String? = ""
      var categoryName: String? = ""
      var imagesCount: Int? = 0

      var raters: Int? = 0
      var minValue: Int? = 0
      var maxValue: Int? = 0

      
      required init?(map: Map) {
          
      }
      
      // Mappable
      func mapping(map: Map) {
          district        <- map["district"]
          businessSize     <- map["business_size"]
          city   <- map["city"]
          mainCategory   <- map["main_category"]
          subCategory   <- map["sub_category"]
          year        <- map["year"]
          max_value     <- map["max_value"]
          min_value   <- map["min_value"]
          rate   <- map["rate"]
          images_count   <- map["images_count"]
          visible   <- map["visible"]
          active        <- map["active"]
          id     <- map["id"]
          api_token   <- map["api_token"]
          business_name   <- map["business_name"]
          first_name   <- map["first_name"]
          last_name   <- map["last_name"]
          last_name   <- map["last_name"]
          email   <- map["email"]
          mobile   <- map["mobile"]
          image   <- map["image"]
          bg_image   <- map["bg_image"]
          phone   <- map["phone"]
          address   <- map["address"]
          latitude   <- map["latitude"]
          longitude   <- map["longitude"]
          about   <- map["about"]
          websiteLink   <- map["website_link"]
          facebookLink   <- map["facebook_link"]
          twitterLink   <- map["twitter_link"]
          instagramLink   <- map["instagram_link"]
          isMain   <- map["is_main"]
          businessName   <- map["business_name"]
          firstName   <- map["first_name"]
          lastName   <- map["last_name"]
          yearId   <- map["year_id"]
          businessSizeId   <- map["business_size_id"]
          districtId   <- map["district_id"]
          websiteLink   <- map["website_link"]
          favorite <- map["favorite"]
          subCategoryName <- map["sub_category_name"]
          categoryName <- map["category_name"]
          maxValue <- map["max_value"]
          imagesCount <- map["images_count"]
          rate <- map["rate"]
          raters <- map["raters"]
          minValue <- map["min_value"]
          
      

}
}

class ProfileDetailsResponseModel: Mappable {
   
     var id: Int? = 0
      var api_token: String? = ""
      var business_name: String? = ""
      var first_name: String? = ""
      var last_name: String? = ""
      var email: String? = ""
      var mobile: String? = ""
      var image: String? = ""
      var bg_image: String? = ""
      var phone: String? = ""
      var address = ""
      var latitude: String? = "0.0"
      var longitude: String? = "0.0"
      var about: String? = ""
      var website_link: String? = ""
      var facebook_link: String? = ""
      var city: City?
      var twitter_link: String? = ""
      var instagram_link: String? = ""
      var active: Int? = 0
      var visible: Int? = 0
      var images_count: Int? = 0
      var rate: Double? = 0.0
      var min_value: Int? = 0
      var max_value: Int? = 0
      var year: Year?
      var businessSize: BusinessSize?
      var district: District?
      var subCategory: SubCategory?
      var mainCategory: MainCategory?
      var images: ImagesProviderModel?
      var isMain: Bool? = false
      var businessName: String? = ""
      var firstName: String? = ""
      var lastName: String? = ""
      
      var bgImage: String? = ""
     
      var yearId: Int?
      var businessSizeId: Int?
      var districtId: Int?
      
      var websiteLink: Any?
      var facebookLink: Any?
      var twitterLink: Any?
      var instagramLink: Any?
       
      var favorite: Bool? = false
      var subCategoryName: String? = ""
      var categoryName: String? = ""
      var imagesCount: Int? = 0

      var raters: Int? = 0
      var minValue: Int? = 0
      var maxValue: Int? = 0
    var resources: Resources?
      var workingDays: WorkingDays?
      required init?(map: Map) {
          
      }
      
      // Mappable
      func mapping(map: Map) {
          district        <- map["district"]
          businessSize     <- map["business_size"]
          city   <- map["city"]
          mainCategory   <- map["main_category"]
          subCategory   <- map["sub_category"]
          year        <- map["year"]
          max_value     <- map["max_value"]
          min_value   <- map["min_value"]
          rate   <- map["rate"]
          images_count   <- map["images_count"]
          visible   <- map["visible"]
          active        <- map["active"]
          id     <- map["id"]
          api_token   <- map["api_token"]
          business_name   <- map["business_name"]
          first_name   <- map["first_name"]
          last_name   <- map["last_name"]
          last_name   <- map["last_name"]
          email   <- map["email"]
          mobile   <- map["mobile"]
          image   <- map["image"]
          bg_image   <- map["bg_image"]
          phone   <- map["phone"]
          address   <- map["address"]
          latitude   <- map["latitude"]
          longitude   <- map["longitude"]
          about   <- map["about"]
          websiteLink   <- map["website_link"]
          facebookLink   <- map["facebook_link"]
          twitterLink   <- map["twitter_link"]
          instagramLink   <- map["instagram_link"]
          isMain   <- map["is_main"]
          businessName   <- map["business_name"]
          firstName   <- map["first_name"]
          lastName   <- map["last_name"]
          yearId   <- map["year_id"]
          businessSizeId   <- map["business_size_id"]
          districtId   <- map["district_id"]
          websiteLink   <- map["website_link"]
          favorite <- map["favorite"]
          subCategoryName <- map["sub_category_name"]
          categoryName <- map["category_name"]
          maxValue <- map["max_value"]
          imagesCount <- map["images_count"]
          rate <- map["rate"]
          raters <- map["raters"]
          minValue <- map["min_value"]
         resources <- map["resources"]
         workingDays <- map["workingDays"]
         
      }
}

class ImagesProviderModel: Mappable {
    var data: [ImagesProviderDataModel]?
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        data        <- map["data"]
    }
}

class ImagesProviderDataModel: Mappable {
    var id, providerID: Int?
    var image: String?
     
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id        <- map["id"]
        providerID        <- map["provider_id"]
        image        <- map["image"]
        
    }

}
