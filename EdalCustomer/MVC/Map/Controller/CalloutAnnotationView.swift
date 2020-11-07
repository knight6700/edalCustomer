//
//  CalloutAnnotationView.swift
//  MacQueen
//
//  Created by trojan  on 12/26/19.
//  Copyright © 2019 Mahmoud Fares. All rights reserved.
//

import Foundation
import MapKit

protocol CalloutAnnotationViewDelegate: AnyObject {
    func calloutButtonClicked(_ title: String?, andIndex indx: Int)
}

class CalloutAnnotationView: MKAnnotationView {
    private var title_: String?
    private var titleLabel_: UILabel?
    private var button_: UIButton?
    private var img_: UIImageView?
    
    var title: String?
    weak var delegate: CalloutAnnotationViewDelegate?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0.0, y: 0.0, width: 120, height: 40)
        backgroundColor = UIColor.clear
        
        titleLabel_ = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 50.0))
        titleLabel_?.textColor = UIColor.black
        titleLabel_?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        img_ = UIImageView(frame: frame)
        img_?.isUserInteractionEnabled = true
        button_ = UIButton(frame: frame)
        button_?.setBackgroundImage(UIImage(named: "annot"), for: .normal)
        button_?.layer.cornerRadius = (button_?.frame.size.width ?? 0.0) / 2
        button_?.setTitleColor(UIColor.black, for: .normal)
        button_?.addTarget(self, action: #selector(calloutButtonClicked), for: .touchDown)
        if let button_ = button_ {
            addSubview(button_)
        }
        addSubview(img_!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        button_?.setTitle(title, for: .normal)
//        img_?.image = UIImage(named: "pin.png")
    }
    
    @objc func calloutButtonClicked(){
        
        let currentAnnotation = self.annotation as! myAnnotation
        delegate?.calloutButtonClicked(currentAnnotation.title, andIndex: currentAnnotation.index);
    }
}
