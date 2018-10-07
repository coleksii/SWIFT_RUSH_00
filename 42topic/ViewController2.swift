//
//  ViewController2.swift
//  42topic
//
//  Created by Chechuha Oleksii on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TopicLabel: UILabel!
    @IBOutlet weak var LoginLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    var data: [(String, String, String)] = [("topic", "login", "date"),
                                            ("lala", "loginlala", "1995")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Topic")
        cell?.textLabel?.text = data[indexPath.row].0
        cell?.detailTextLabel?.text = data[indexPath.row].2
        return cell!
    }
    
}
