//
//  ViewController.swift
//  DAY03
//
//  Created by Chechuha Oleksii on 10/5/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
 
    var numberSuccesLoad = 0;
    
    
    let array: [String] = ["1", "2", "3", "4"]
    let arrayUrl: [String] = ["https://stmed.net/sites/default/files/mountaineering-wallpapers-31239-587218.jpg",
                              "https://i.pinimg.com/originals/02/88/f2/0288f2387bdf90f1dd60a44b50bc6a10.jpg",
                              "https://stmed.net/sites/default/files/mountaineering-wallpapers-31239-9945909.jpg",
                              "https://images3.alphacoders.com/189/189865.jpg",
                              "https://wallpaperstudio10.com/static/wpdb/wallpapers/1920x1080/177982.jpg",
                              "https://stmed.net/sites/default/files/mountaineering-wallpapers-31239-7419295.jpg",
                              "https://;oeirngpod"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        cell.spinner.startAnimating();
        cell.spinner.isHidden = false;
        cell.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        let url = URL(string: arrayUrl[indexPath.row])
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.global().async {

            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.myImageView.image = image
                        cell.spinner.isHidden = true;
                        cell.spinner.stopAnimating();
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    self.displayAllert(message: "Cannot acces to " + self.arrayUrl[indexPath.row])
                    cell.spinner.isHidden = true;
                    cell.spinner.stopAnimating();
                }
            }
            self.numberSuccesLoad += 1;
            DispatchQueue.main.async {
                if (self.arrayUrl.count == self.numberSuccesLoad){
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
        return cell
    }
    
    func displayAllert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionView: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let size CGSize
//    }
}



