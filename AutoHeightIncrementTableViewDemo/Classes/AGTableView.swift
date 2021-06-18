//
//  AGTableView.swift
//  BaseProject
//
//  Created by AshvinGudaliya on 22/08/18.
//  Copyright © 2018 AshvinGudaliya. All rights reserved.
//

import UIKit

class AGTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
    
    func defaultInit(){
        self.keyboardDismissMode = .onDrag
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.tableFooterView = UIView(frame: .zero)
        self.tableHeaderView = UIView(frame: .zero)
        self.sectionFooterHeight = 0
        self.sectionHeaderHeight = 0
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if self.nsHeightConstraint != nil {
            self.nsHeightConstraint?.constant = self.contentSize.height
        }
        else{
            self.heightAnchor.constraint(equalToConstant: self.contentSize.height).isActive = true
        }
        self.setNeedsDisplay()
    }
}

extension UITableView {
    
    public func estimatedRowHeight(_ height: CGFloat) {
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = height
    }
    
    func dequeueReusableCell<T : UITableViewCell>(withClassIdentifier cell: T.Type) -> T {
        if let Cell = dequeueReusableCell(withIdentifier: String(describing: cell.self)) as? T {
            return Cell
        }
        fatalError(String(describing: cell.self))
    }
    
    func registerNib(_ cellClass: UITableViewCell.Type) {
        let id = String(describing: cellClass.self)
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellReuseIdentifier: id)
    }
    
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0) {
            self.reloadData()
        } completion: { _ in
            completion()
        }
    }
}

extension UIView {
    
    var nsHeightConstraint: NSLayoutConstraint? {
        get {
            return constraints.filter {
                if $0.firstAttribute == .height, $0.relation == .equal {
                    return true
                }
                return false
                }.first
        }
        set{ setNeedsLayout() }
    }
}
