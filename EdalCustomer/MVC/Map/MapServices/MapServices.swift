//
//  MapServices.swift
//  edal-IosApp
//
//  Created by hesham ghalaab on 7/29/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import GoogleMaps

class MapServices{
    
    func reverseGeocodeCoordinate(withLocation location: CLLocationCoordinate2D, completion: @escaping (_ error: String?, _ location: SelectedLocation?) -> ()) {
        
        let gmsGeocoder = GMSGeocoder()
        gmsGeocoder.reverseGeocodeCoordinate(location) { (gmsReverseGeocodeResponse, error) in
            guard error == nil else {
                completion("error in reverseGeocodeCoordinate with: \(error!.localizedDescription)" , nil)
                return
            }
            guard let response = gmsReverseGeocodeResponse else {
                completion(nil , nil)
                return
            }
            guard let gmsAddress = response.firstResult() else {
                completion(nil , nil)
                return
            }
            
            let theLatitude = gmsAddress.coordinate.latitude
            let theLongitude = gmsAddress.coordinate.longitude
            let theThoroughfare = gmsAddress.thoroughfare ?? ""
            let theLocality = gmsAddress.locality ?? ""
            let theSubLocality = gmsAddress.subLocality ?? ""
            let theAdministrativeArea = gmsAddress.administrativeArea ?? ""
            let thePostalCode = gmsAddress.postalCode ?? ""
            let theCountry = gmsAddress.country ?? ""
            let theLines = gmsAddress.lines ?? []
            
            var placeName = ""
            for line in theLines{
                placeName.append(line + " ")
            }
            
            print("\n*****************************")
            print("latitude: \(theLatitude)")
            print("longitude: \(theLongitude)")
            print("thoroughfare: \(theThoroughfare)")
            print("locality: \(theLocality)")
            print("subLocality: \(theSubLocality)")
            print("administrativeArea: \(theAdministrativeArea)")
            print("postalCode: \(thePostalCode)")
            print("country: \(theCountry)")
            print("lines: \(theLines)")
            print("*****************************\n")
            
            let selectedLocation = SelectedLocation(address: placeName, latitude: theLatitude, longitude: theLongitude)
            completion(nil, selectedLocation)
        }
    }
}
