//
//  InnerTableViewCell.swift
//  AutoHeightIncrementTableViewDemo
//
//  Created by Wholly-iOS on 22/09/18.
//  Copyright © 2018 Ashvin Gudaliya. All rights reserved.
//

import UIKit

class InnerTableViewCell: UITableViewCell {

    @IBOutlet weak var innerTableView: AGTableView!
    
    var outerRow: Int = 0 {
        didSet {
            self.innerTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.innerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.innerTableView.estimatedRowHeight(50)
        self.innerTableView.delegate = self
        self.innerTableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.innerTableView.layoutSubviews()
        self.superTableView?.beginUpdates()
        self.superTableView?.endUpdates()
    }
    
}

extension InnerTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") ?? UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = "Outer Section: \(outerRow)  innerRow: \(indexPath.row)"
        return cell
    }
}
