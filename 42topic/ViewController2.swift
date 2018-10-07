//
//  ViewController2.swift
//  42topic
//
//  Created by Chechuha Oleksii on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var data : [TopicData] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        self.data.append(TopicData(topic: "ASDasdaSDsdasDasd;lakSJD;alskdj;alKSDJa;lskdja;lSKDJa;lskdja;lsKDJa;sldkja;SLDJas;ldkja;SLKDJa;lskdja;lSKDJ;alskdj;alSKDJ;alskdj;alKSDJ;alksdj;alsKDJa;lskdja;lsKDJa;lskdj;alKSDFJ;adlkfna;skjdvbna;wjdnv v", name: "Mario", date: "03-02-2016"))
        self.data.append(TopicData(topic: "Why my repo is empty?", name: "Eric Cartman", date: "23-03-2016"))
        self.data.append(TopicData(topic: "So close ...", name: "Luigi", date: "12-04-2016"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Topic") as? TopicCell
        cell?.aVictim = self.data[indexPath.row]
        return cell!
    }
}
