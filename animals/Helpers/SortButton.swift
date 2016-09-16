//
//  SortButton.swift
//  animals
//
//  Created by Sergio Orozco  on 9/15/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit

typealias SortChangeState = (checkbox: SortButton) -> ()

@objc class SortButton: UIButton {
    
    private var sortDESCImageName = "down-thin-chevron"
    private var sortASCImageName = "up-thin-chevron"
    private var oldSortState: Bool = false
    
    var changeStateSort: SortChangeState?
    
    override func awakeFromNib() {
        self.customView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.customView()
    }
    
    private func customView() {
        self.backgroundColor = UIColor.clearColor()
        self.setTitle("", forState: .Normal)
        self.setBackgroundImage(UIImage(named: self.getImageFor(self.isAsc)), forState: .Normal)
        
    }
    
    @IBInspectable
    var respondsToActions: Bool = false {
        didSet {
            if self.respondsToActions {
                self.addTarget(self, action: #selector(SortButton.checkSortState), forControlEvents: .TouchUpInside)
            } else {
                self.removeTarget(self, action: #selector(SortButton.checkSortState), forControlEvents: .TouchUpInside)
            }
        }
    }
    
    @IBInspectable
    var isAsc: Bool = true {
        willSet {
            self.oldSortState = self.isAsc
        }
        didSet {
            if let changeSortState = self.changeStateSort where self.isAsc && !self.disableCallback {
                changeSortState(checkbox: self)
            }
            let changeImage = { () -> Void in
                self.customView()
            }
            if self.isAsc != self.oldSortState {
                let trantionStyle = UIViewAnimationOptions.TransitionFlipFromBottom
                UIView.transitionWithView(self, duration: 0.2, options: trantionStyle, animations: {
                    changeImage()
                    }, completion:nil)
            }
        }
    }
    
    var disableCallback: Bool = false
    
    func checkSortState() {
        self.isAsc = !self.isAsc
    }
    
    func getImageFor(checked: Bool) -> String {
        return checked ? self.sortASCImageName : self.sortDESCImageName
    }
    
}

