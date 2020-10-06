// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


/*
 {
 data =         (
 {
 about = "<null>";
 active = 1;
 address = "Gardenia, Aboi Gazia, Al Kom Al Akhdar, Al Omraneyah, Giza Governorate, Egypt";
 "api_token" = e49d41fe11207c7db2ebc0209e783c7d8c1a81e00cb5ca2fc40b11111b1dcd322a4bef84d8a3c59b22d7c730fa64ff2ad296;
 "bg_image" = "http://192.81.221.63/assets/front/assets/img/edal-bg.jpg";
 "business_name" = edigits;
 "business_size" =                 {
 id = 1;
 title = Small;
 };
 "business_size_id" = 1;
 "category_name" = Beauty;
 city =                 {
 id = 2;
 name = Alexandria;
 };
 district =                 {
 id = 2;
 title = "mahtet el raml";
 };
 "district_id" = 2;
 email = "demo@demo.com";
 favorite = 0;
 "first_name" = mohamed;
 id = 6;
 image = "http://192.81.221.63/assets/front/assets/img/business_avatar2.png";
 "images_count" = 1;
 "is_main" = 1;
 "last_name" = kelany;
 latitude = "29.99303974332087";
 longitude = "31.159083656966686";
 "main_category" =                 {
 icon = "http://192.81.221.63/uploads/categories/73511535371956.png";
 id = 1;
 name = Beauty;
 };
 "max_value" = 0;
 "min_value" = 0;
 mobile = 01022627813;
 phone = 0224024024;
 rate = 0;
 raters = 0;
 "sub_category" =                 {
 id = 1;
 name = "Make-Up";
 };
 "sub_category_name" = "Make-Up";
 visible = 1;
 "year_id" = 1;
 }
 */
import Foundation

//struct HomeResponse: Decodable {
//    
//    let lang, status, errorMsg: String
//    let errors: [String: String]
//    let defaultResponse: [DefaultResponse]?
//    let homeProviders: Providers
//    let recentServices: RecentServices
//    let recommendedProviders: Providers
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case lang, status
//        case errorMsg = "error_msg"
//        case errors
//        case defaultResponse = "default_response"
//        case homeProviders = "home_providers"
//        case recentServices = "recent_services"
//        case recommendedProviders = "recommended_providers"
//    }
//}
//
//struct Errors: Decodable {
//}
//
//struct Providers: Decodable {
//    let data: [HomeProvidersDatum]
//}
//
//struct HomeProvidersDatum: Decodable {
//    let about: String?
//    let active: Int
//    let address: String
//   // let api_token: String
//    let bg_image: String
//    let business_name: String
//    let business_size: LookupAllData
//    let business_size_id: Int
//    let category_name: String
//    let city: LookupAllData
//    let district: LookupAllData
//    let district_id: Int
//    let email: String
//    let facebook_link: String?
//    let favorite: Bool
//    let first_name: String
//    let id: Int
//    let image: String
//   // let images: Images?
//    let images_count: Int
//    let instagram_link: String?
//    let is_main: Bool
//    let last_name: String
//    let latitude: String?
//    let longitude: String?
//    let main_category: LookupAllData
//    let max_value: Int
//    let min_value: Int
//    let mobile: String
//    let phone: String
//    let rate: Int
//    let raters: Int
//    let sub_category: LookupAllData
//    let sub_category_name: String
//    let visible: Int
//    let website_link: String?
//   // let year: LookupAllData?
//    let year_id: Int
//}
//
//
//
//struct RecentServices: Codable {
//    let data: [RecentServicesDatum]
//}
//struct RecentServicesDatum: Codable {
//    let id: Int
//    let name, icon: String
//    let minValue, maxValue: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name, icon
//        case minValue = "min_value"
//        case maxValue = "max_value"
//    }
//}
//
//struct Images: Decodable {
//    let data: ImagesData
//}
//struct ImagesData: Decodable {
//    let id: Int
//    let image: String
//    let provider_id: String
//}
