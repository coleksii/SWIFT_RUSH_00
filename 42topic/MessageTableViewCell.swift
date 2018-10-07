//
//  MessegeTableViewCell.swift
//  42topic
//
//  Created by Hnat DANYLEVYCH on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameMLabel: UILabel!
    @IBOutlet weak var dateMDate: UILabel!
    
    var message : MessageData?
    {
        didSet{
            if let v = message{
                messageLabel?.text = v.message
                nameMLabel?.text = v.name
                dateMDate?.text = v.date
            }
        }
    }

}
