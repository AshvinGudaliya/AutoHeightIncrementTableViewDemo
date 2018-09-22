//
//  ViewController.swift
//  AutoHeightIncrementTableViewDemo
//
//  Created by Wholly-iOS on 22/09/18.
//  Copyright © 2018 Ashvin Gudaliya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outerTableView: UITableView!
    
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: InnerTableViewCell.self)
        cell.outerRow = indexPath.section
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section: \(section)"
    }
}

