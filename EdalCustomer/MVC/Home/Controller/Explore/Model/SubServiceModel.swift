//
//  SubServiceModel.swift
//  edal-IosCustomerApp
//
//  Created by Mahmoud Maamoun on 2/2/20.
//  Copyright © 2020 hesham ghalaab. All rights reserved.
//

import Foundation
import ObjectMapper

class SubServiceBooking: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        default_response  <- map["default_response"]
        status  <- map["status"]
        error_msg  <- map["error_msg"]
        errors  <- map["errors"]
               
    }
    
    var default_response: SubServiceDefaultResponse?
    var lang: String?
    var status: String?
    var error_msg: String?
    var errors: [String:String]?
    
}
class ResourcesDatum: Mappable {
    
    var id: Int?
    var name: String?
    var position: String?
    var image: String?
    var bio: String?
    var gender: Int?
    var status: Int?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        id  <- map["id"]
        name  <- map["name"]
        position  <- map["position"]
        image  <- map["image"]
        bio  <- map["bio"]
        gender  <- map["gender"]
        status  <- map["status"]
    }
}
class WorkingDays: Mappable {
    var data: [WorkingDaysDatum]?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        data  <- map["data"]
    }
}
class Breaks: Mappable {
    var data: [BreaksDatum]?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        data  <- map["data"]
    }
}

class BreaksDatum: Mappable {
    var id: Int?
    var from, to: String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        id  <- map["id"]
        from  <- map["from"]
        to  <- map["to"]
    }
}

class WorkingDaysDatum: Mappable {
    var id, day: Int?
    var from, to: String?
    var breaks: Breaks?
    required init?(map: Map) {
           
       }
       func mapping(map: Map) {
           breaks  <- map["breaks"]
           to  <- map["to"]
           from  <- map["from"]
           id  <- map["id"]
           day  <- map["day"]
       }
}
class SubServiceDefaultResponse: Mappable {
    required init?(map: Map) {
        
    }
     
    var sub_service: SubServiceModel?
    var resources: Resources?
    
    func mapping(map: Map) {
        sub_service  <- map["sub_service"]
        resources  <- map["resources"]
    }
}
class Resources: Mappable {
    required init?(map: Map) {
        
    }
   
    var data: [ResourcesDatum]?
    
    func mapping(map: Map) {
        data  <- map["data"]
      
    }
}

class SubServiceModel: Mappable {
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id  <- map["id"]
        step2  <- map["step2"]
        step3  <- map["step3"]
        step4  <- map["step4"]
        title  <- map["title"]
        service_name  <- map["service_name"]
        description  <- map["description"]
        class_capacity  <- map["class_capacity"]
        booking_question  <- map["booking_question"]
        padding_value  <- map["padding_value"]
        time_in_advance_value  <- map["time_in_advance_value"]
        time_in_advance_type  <- map["time_in_advance_type"]
        booking_question  <- map["booking_question"]
        time_before_value  <- map["time_before_value"]
        image  <- map["image"]
        fixed_hours  <- map["fixed_hours"]
        last_updated  <- map["last_updated"]
        creation_date  <- map["creation_date"]
        type  <- map["type"]
        location  <- map["location"]
        instant  <- map["instant"]
        price  <- map["price"]
        rotation  <- map["rotation"]
        fixed  <- map["fixed"]
        payment_method  <- map["payment_method"]
        deposit  <- map["deposit"]
        instant  <- map["instant"]
        price  <- map["price"]
        instant  <- map["instant"]
        status  <- map["status"]
        daily  <- map["daily"]
        price  <- map["price"]
        weekly  <- map["weekly"]
        monthly  <- map["monthly"]
        seasonal  <- map["seasonal"]
        
    }
    
   
    var id: Int = 0
    var step2  = false ,step3 = false ,step4 = false 
    var title = "", service_name = "", description = "", class_capacity: String = ""
    var booking_question: String = ""
    var image = "", fixed_hours = "",last_updated: String = ""
    var creation_date: String = ""
    var type = 0, location = 0, instant = 0 ,price = 0 ,rotation = 0 ,fixed: Int = 0
    var payment_method = 0, deposit: Int = 0
    var time_before_value = 0, time_in_advance_type = 0, time_in_advance_value = 0, padding_value: Int = 0
    var status: Int = 0
   
    var daily: WorkingDays?
    var weekly: WorkingDays?
    var monthly: WorkingDays?
    var seasonal: WorkingDays?
       

    
}
