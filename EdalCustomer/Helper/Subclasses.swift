//
//  Subclasses.swift
//  Spoon
//
//  Created by abdelrahman.youssef on 4/3/18.
//  Copyright © 2018 hesham ghalaab. All rights reserved.
//

import Foundation
import UIKit

class IntinsicCollectionView : UICollectionView {
    
    override var contentSize: CGSize{
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize{
        self.layoutIfNeeded()
        return CGSize.init(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}

class TableView : UITableView {
    
    override var contentSize: CGSize{
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize{
        self.layoutIfNeeded()
        return CGSize.init(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}

class IntinsicView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentSize = frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentSize = frame.size
//        fatalError("init(coder:) has not been implemented")
    }
    
    var contentSize: CGSize?{
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize{
        self.layoutIfNeeded()
        return CGSize.init(width: UIView.noIntrinsicMetric, height: contentSize!.height)
    }
    
}

class LookUpCustomTableView : UITableView {
    
    override var contentSize: CGSize{
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize{
        self.layoutIfNeeded()
        let height = UIScreen.main.bounds.height - 100 - 50
        // 100 is the padding that we need, 50 is height of the stack
        let contentHeight = contentSize.height
        
        if contentHeight < height{
            return CGSize.init(width: UIView.noIntrinsicMetric, height: contentHeight)
        }else{
            return CGSize.init(width: UIView.noIntrinsicMetric, height: height)
        }
    }
    
}

class IntrinsicTableView: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}
