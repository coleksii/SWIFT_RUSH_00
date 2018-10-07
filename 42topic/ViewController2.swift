//
//  ViewController2.swift
//  42topic
//
//  Created by Chechuha Oleksii on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit
var dataTopic : [TopicData] = []
var dataMessage: [MessageData] = []
class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct Author : Decodable {
        let login: String
    }
    
    struct Topic : Decodable{
        let id: Int
        let name: String
        let author: Author
        let created_at: String
    }
    
    struct Messages : Decodable {
        let id: Int
        let author: Author
        let content: String
    }
    
    @IBOutlet weak var tableView: UITableView!
    
//    override func awakeFromNib() {
//        self.data.append(TopicData(topic: "ASDasdaSDsdasDasd;lakSJD;alskdj;alKSDJa;lskdja;lSKDJa;lskdja;lsKDJa;sldkja;SLDJas;ldkja;SLKDJa;lskdja;lSKDJ;alskdj;alSKDJ;alskdj;alKSDJ;alksdj;alsKDJa;lskdja;lsKDJa;lskdj;alKSDFJ;adlkfna;skjdvbna;wjdnv v", name: "Mario", date: "03-02-2016"))
//        self.data.append(TopicData(topic: "Why my repo is empty?", name: "Eric Cartman", date: "23-03-2016"))
//        self.data.append(TopicData(topic: "So close ...", name: "Luigi", date: "12-04-2016"))
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTopic.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Topic") as? TopicCell
        cell?.aVictim = dataTopic[indexPath.row]
        return cell!
    }
    
    override func viewDidAppear(_ animated: Bool){
        loadTopics()
    }
    
    func loadTopics(){
            let url = URL(string: "https://api.intra.42.fr//v2/topics.json")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            print("Bearer " + accesToken!)
            request.setValue("Bearer " + accesToken!, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                
                guard let data = data else{ return}
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let topics = try jsonDecoder.decode([Topic].self, from: data)
                    
                    print(topics[0].author.login)
                    for topic in topics{
                        dataTopic.append(TopicData(topic: topic.name, name: topic.author.login, date: topic.created_at))
                    }
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                    
                    
                }catch let err{
                    print("ERROR", err)
                }
                
                }.resume()
        loadMessages()
        }
    
    func loadMessages(){
        let url = URL(string: "https://api.intra.42.fr/v2/messages")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print("Bearer " + accesToken!)
        request.setValue("Bearer " + accesToken!, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data else{ return}
            
            do {
                let jsonDecoder = JSONDecoder()
                let messages = try jsonDecoder.decode([Messages].self, from: data)
                
                print("MESSAGES");
                print(messages[0].author.login)
                for message in messages{
                    print(message.author.login)
//                    dataTopic.append(TopicData(topic: topic.name, name: topic.author.login, date: topic.created_at))
                    dataMessage.append(MessageData(message: message.content, name: message.author.login))
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            }catch let err{
                print("ERROR", err)
            }
            
            }.resume()
    }
}
