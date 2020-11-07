//
//  CustomAnnotaionView.swift
//  MacQueen
//
//  Created by trojan  on 12/26/19.
//  Copyright © 2019 Mahmoud Fares. All rights reserved.
//

import Foundation
import MapKit
import GoogleMaps
protocol AnnotationViewDelegateTap: AnyObject {
    func annotationClicked(_ title: String?, andIndex indx: Int)
}


class myAnnotation: NSObject, MKAnnotation,CalloutAnnotationViewDelegate {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var type: String?
    var subtitle: String?
    var subsubtitle: String?
    var index = 0
    var subsubsubtitle: String?
    var pinImageName: String?
    var imageview: UIImageView?
    weak var delegate: AnnotationViewDelegateTap?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, andSubsubTitle subSubTitle: String?) {
        // super.init()
        self.coordinate = coordinate
        if let  ti = title {
            self.title = ti
        }
        self.subtitle = subtitle
        subsubtitle = subSubTitle
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, andSubsubTitle subSubTitle: String?, andSubSubSubTitle subsubsubTitle: String?) {
        //  super.init()
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        subsubtitle = subSubTitle
        subsubsubtitle = subsubsubTitle
    }
    
    func calloutButtonClicked(_ title: String?, andIndex indx: Int) {
        self.delegate?.annotationClicked(title, andIndex: index)
    }
    
    func annotaionView() -> MKAnnotationView? {
        let annotationView = CalloutAnnotationView(annotation: self, reuseIdentifier: "myAnnotation")
        annotationView.isEnabled = true
        annotationView.delegate = self
//        annotationView.canShowCallout = true
        if let tl = title {
            annotationView.title = tl
        }
        return annotationView
    }
    
}
