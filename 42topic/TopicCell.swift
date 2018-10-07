//
//  TopicCell.swift
//  42topic
//
//  Created by Hnat DANYLEVYCH on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    
    var aVictim : TopicData?
    {
        didSet{
            if let v = aVictim{
                topicLabel?.text = v.topic
                nameLabel?.text = v.name
                datelabel?.text = v.date
            }
        }
    }
}
