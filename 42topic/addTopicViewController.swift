//
//  addTopicViewController.swift
//  42topic
//
//  Created by Hnat DANYLEVYCH on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

var myId: Int?

class addTopicViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var topicName: UITextField!
    @IBOutlet weak var kindPicker: UIPickerView!
    @IBOutlet weak var messageText: UITextView!
    
    struct User : Decodable{
        let id : Int
    }
    
    let kind : [String] = ["Normal", "Survey", "Stack Overflow"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kind[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kind.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

         self.messageText?.layer.borderWidth = 1
    }

    @IBAction func done(_ sender: UIButton) {
        
        
        let urlMe = URL(string: "https://api.intra.42.fr/v2/me")!
        var requestMe = URLRequest(url: urlMe)
        requestMe.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        requestMe.httpMethod = "GET"
        requestMe.setValue("Bearer " + accesToken!, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: requestMe) {(data, response, error) in
            guard let data = data else{ return}
            do {
                let jsonDecoder = JSONDecoder()
                let user = try jsonDecoder.decode(User.self, from: data)
                myId = user.id
                print("USERID", user.id)
                }catch let err{
                    print("ERROR", err)
                }
            }.resume()
        
        
        
        
        let url = URL(string: "https://api.intra.42.fr/v2/topics")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let json: [String: Any] =
            ["topic":
                ["name":topicName.text,
                 "kind":"normal",
                 "language_id":"3",
                 "author_id":nil,
                 "messages_attributes":["author_id":  myId, "content": messageText.text, "messageable_type": "Topic"
                    ]
                    ,
                 "tag_ids":nil,
                 "cursus_ids":nil,
                 "survey_attributes":nil,
                ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.setValue("Bearer " + accesToken!, forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()

    }
    
}

