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
    
    var arryData: [(String, String, String)] = [("topic", "login", "date"),
                                            ("lala", "loginlala", "1995")]

    
    struct Author : Decodable {
        let login: String
    }
    
    struct Topic : Decodable{
        let id: Int
        let name: String
        let author: Author
    }
    
    override func viewDidAppear(_ animated: Bool){
        loadTopics()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Topic")
        cell?.textLabel?.text = arryData[indexPath.row].0
        cell?.detailTextLabel?.text = arryData[indexPath.row].2
        return cell!
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
                print(topics[0].author.login);
            
//            let dataString = String(data: data, encoding: .utf8);
////           print(dataString)
//
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(json)
            }catch let err{
                print("ERROR", err)
            }
            
             }.resume()
        print("RESUME");
        }
    }
