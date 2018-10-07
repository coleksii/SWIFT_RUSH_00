//
//  TableViewControllerMessage.swift
//  42topic
//
//  Created by Chechuha Oleksii on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

class TableViewControllerMessage: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagesTableChe")
        cell?.textLabel?.text = dataMessage[indexPath.row].name
        cell?.detailTextLabel?.text = dataMessage[indexPath.row].message
        //        cell.death = Data.deths[indexPath.row]
        return cell!
    }
}
