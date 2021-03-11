//
//  ViewController.swift
//  AutoHeightIncrementTableViewDemo
//
//  Created by AshvinGudaliya on 22/09/18.
//  Copyright © 2018 Ashvin Gudaliya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outerTableView: UITableView!
    var tableSize: [IndexPath: CGFloat] = [IndexPath: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.outerTableView.estimatedRowHeight(100)
        self.outerTableView.registerNib(InnerTableViewCell.self)
        self.outerTableView.delegate = self
        self.outerTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: InnerTableViewCell.self)
        cell.configuration(indexPath: indexPath, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section: \(section)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let size = tableSize[indexPath] {
            return size
        }
        return UITableViewAutomaticDimension
    }
}

extension ViewController: InnerTableViewCellDelegate {
    func innerTableView(forIndex: IndexPath, atSize size: CGFloat) {
        if let s = tableSize[forIndex] {
            if s != size {
                tableSize[forIndex] = size
                self.outerTableView.beginUpdates()
                self.outerTableView.endUpdates()
            }
        } else {
            tableSize[forIndex] = size
            self.outerTableView.beginUpdates()
            self.outerTableView.endUpdates()
        }
    }
}
