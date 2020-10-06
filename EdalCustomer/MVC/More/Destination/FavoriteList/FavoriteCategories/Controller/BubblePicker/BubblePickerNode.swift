//
//  BubblePickerNode.swift
//  BubblePicker
//
//  Created by Ronnel Davis on 25/07/18.
//

import UIKit
import SDWebImage

public class BubblePickerNode: UIView {

    public var textColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 1)

    var bubblepicker: BubblePicker!

    var label: UILabel!
    var imageView: UIImageView!

    var index: Int!
    var isExpanded = false

    public init(title: String, color: UIColor, imageUrl: String) {

        let isLeft = arc4random_uniform(2)
        var marginLeft:CGFloat = 300;
        if(isLeft == 0){
            marginLeft = -300
        }
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        super.init(frame: CGRect(x: screenWidth/2 + marginLeft - 100 + CGFloat(arc4random_uniform(100)), y: screenHeight/2 - 100 + CGFloat(arc4random_uniform(100)), width: 100, height: 100))

        //Image View
        imageView = UIImageView()
        let image_url = URL(string: imageUrl)
        if image_url != nil
        {
        print("image_url:\(image_url)")
       // imageView.sd_setImage(with: image_url)
        imageView.load(url: image_url!, color: .gray)
        //imageView.tintColor = .gray
        }
        
        
        if let label = label{
           label.textColor = .gray
        }
        
       // imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        //imageView.frame.width = 10
        //imageView.frame.height = 10
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 3, y: 3, width: frame.width - 6, height: frame.height - 6), cornerRadius: 50)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer

        //Text Label
        label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.adjustsFontSizeToFitWidth = true
       // label.minimumScaleFactor = 0.25
        self.label.widthAnchor.constraint(equalToConstant: 85).isActive = true
        //label.font = UIFont.systemFont(ofSize: 15)
        label.text  = title
        label.textColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 1.0)
        label.font = UIFont(name: "system", size: 7)
        label.textAlignment = .center

        self.backgroundColor = color
        self.clipsToBounds = true

        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 2
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BubblePickerNode.tapped))
        self.addGestureRecognizer(tapGesture)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @available(iOS 9.0, *)
    override public var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }

    override public var collisionBoundingPath: UIBezierPath{
        return UIBezierPath(ovalIn: self.bounds)
    }

    @objc func tapped(recogniser: UITapGestureRecognizer){
        if(isExpanded){
            self.bubblepicker.delegate?.bubblePicker(self.bubblepicker, didDeselectNodeAt: IndexPath(item: self.index, section: 0))
            self.bubblepicker.selectedIndices.remove(at: self.bubblepicker.selectedIndices.index(of: self.index)!)
        }
        else{
            self.bubblepicker.delegate?.bubblePicker(self.bubblepicker, didSelectNodeAt: IndexPath(item: self.index, section: 0))
            self.bubblepicker.selectedIndices.append(self.index);
        }
        setSelected(!isExpanded)
    }
    

  public func setSelected(_ flag: Bool){

        isExpanded = flag
        self.bubblepicker.BPAnimator.removeBehavior(self.bubblepicker.BPDynamics)
        self.bubblepicker.BPAnimator.removeBehavior(self.bubblepicker.BPGravity)
        self.bubblepicker.BPAnimator.removeBehavior(self.bubblepicker.BPCollision)

        var maskPath: UIBezierPath!

    
        if(!isExpanded){
            self.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))

            maskPath = UIBezierPath(roundedRect: CGRect(x: 3, y: 3, width: bounds.width - 6, height: bounds.height - 6), cornerRadius: 40)

            self.backgroundColor = .white
            self.label.widthAnchor.constraint(equalToConstant: 85).isActive = true
            self.label.textColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 1.0)
            self.label.textColor = .gray
            imageView.tintColor = .gray
            self.label.font = UIFont(name: "system", size: 7)
        }
        else{
            self.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 110, height: 110))

            maskPath = UIBezierPath(roundedRect: CGRect(x: 3, y: 3, width: bounds.width - 6, height: bounds.height - 6), cornerRadius: 55)

            self.backgroundColor = UIColor(red: 249/255, green: 118/255, blue: 32/255, alpha: 1.0)
            self.label.widthAnchor.constraint(equalToConstant: 95).isActive = true
            self.label.textColor = .white
            imageView.tintColor = .white
            self.label.font = UIFont(name: "system", size: 8)
        }

        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer

        self.bubblepicker.BPAnimator.addBehavior(self.bubblepicker.BPDynamics)
        self.bubblepicker.BPAnimator.addBehavior(self.bubblepicker.BPGravity)
        self.bubblepicker.BPAnimator.addBehavior(self.bubblepicker.BPCollision)
    }
}
