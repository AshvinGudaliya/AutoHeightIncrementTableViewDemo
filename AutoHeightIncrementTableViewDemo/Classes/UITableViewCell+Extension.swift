//
//  UITableViewCell+Ex.swift
//  BaseProject
//
//  Created by Ashvin Gudaliya on 12/6/17.
//  Copyright © 2017 AshvinGudaliya. All rights reserved.
//

import UIKit


extension UITableViewCell {

    var superTableView: UITableView? {

        var view = superview

        while view != nil && !(view is UITableView) {
            view = view?.superview
        }

        return view as? UITableView
    }
}
