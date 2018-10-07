//
//  MessegeViewController.swift
//  42topic
//
//  Created by Hnat DANYLEVYCH on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var viewTable: UITableView!
    
    var mess : [MessageData] = []
    
    override func awakeFromNib() {
        self.mess.append(MessageData(message: "lol kek", name: "Meri", date: "03-02-2016"))
        self.mess.append(MessageData(message: "googli", name: "House", date: "23-03-2016"))
        self.mess.append(MessageData(message: "dosvidos", name: "Karter", date: "12-04-2016"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Topic") as? MessageTableViewCell
        cell?.message = self.mess[indexPath.row]
        return cell!
    }
}
