//
//  InnerTableViewCell.swift
//  AutoHeightIncrementTableViewDemo
//
//  Created by AshvinGudaliya on 22/09/18.
//  Copyright © 2018 Ashvin Gudaliya. All rights reserved.
//

import UIKit

protocol InnerTableViewCellDelegate: class {
    func innerTableView(forIndex: IndexPath, atSize size: CGFloat)
}

class InnerTableViewCell: UITableViewCell {

    @IBOutlet weak var innerTableView: AGTableView!
    
    private var indexPath: IndexPath!
    weak var delegate: InnerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.innerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.innerTableView.estimatedRowHeight(50)
        self.innerTableView.delegate = self
        self.innerTableView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateOuterTableView()
    }
    
    func configuration(indexPath: IndexPath, delegate: InnerTableViewCellDelegate) {
        self.indexPath = indexPath
        self.delegate = delegate
        
        innerTableView.reloadData {
            self.updateOuterTableView()
        }
    }
    
    func updateOuterTableView() {
        self.delegate?.innerTableView(forIndex: indexPath, atSize: self.innerTableView.contentSize.height)
    }
}

extension InnerTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexPath?.section ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") ?? UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = "Outer Section: \(self.indexPath.row)  innerRow: \(indexPath.row)"
        self.updateOuterTableView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
