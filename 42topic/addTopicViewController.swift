//
//  addTopicViewController.swift
//  42topic
//
//  Created by Hnat DANYLEVYCH on 10/7/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

class addTopicViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var topicName: UITextField!
    @IBOutlet weak var kindPicker: UIPickerView!
    @IBOutlet weak var messageText: UITextView!
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
