//
//  WebViewController.swift
//  42topic
//
//  Created by Chechuha Oleksii on 10/6/18.
//  Copyright © 2018 chechuha. All rights reserved.
//

import UIKit
import WebKit

// ссылка на доки на интру
// https://api.intra.42.fr/apidoc/guides/web_application_flow
// https://api.intra.42.fr/apidoc/guides/getting_started
//Инструкция. Если чего - звони
//Сначала мы переходим по сслыке на https://api.intra.42.fr/oauth/authorize с нужными параметрами
//после чего переходим по предложенной ссылке, сервси редиректит юзера на ссылку
//С этой ссылки берем уже параметр code (нам нужен только code - это пиздец костыльно как мне кажется)
//После чего делаем POST-request на https://api.intra.42.fr/oauth/token c имеющимся кодом
//что бы получить acess-token - и с ним уж делать все остальные операции - считай это конец авторизации.

class WebViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var myWebView: WKWebView!
    
    //параметры моего application в интре
    let uid = "ad54c5ee7cbc4f4d2be86eb3edfbd113c644e389bbfad5db8da7961ac4cf55bb"
    let secret = "84d60e8a03cbf18a857b9d00895a9b9d03714682f30e4a08907322c1c3246fdd"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=ad54c5ee7cbc4f4d2be86eb3edfbd113c644e389bbfad5db8da7961ac4cf55bb&redirect_uri=https%3A%2F%2Fwww.awd.com%2F&response_type=code")
        myWebView.load(URLRequest(url: url!))
        myWebView.navigationDelegate = self
        self.myWebView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        self.myWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
    }
    
    //ловим ивент смены ссылки
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            let url = self.myWebView.url!
            if ((url.valueOf("code")) != nil){
                print("CATCH" + url.valueOf("code")!)
                //todo redirect тут надо сделать переход на другую вьюшку!!! пока не знаю как;
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "control") as! UINavigationController
                self.present(vc, animated: true, completion: nil)
                
                getAuthorithationCode(parameter: url.valueOf("code")!)
            }
            print("### URL:", self.myWebView.url!)
        }
    }
    
    func getAuthorithationCode(parameter: String){
        //подготавливаем вся для того что бы сделать запрос
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "grant_type=authorization_code&client_id=" + self.uid + "&client_secret=" + self.secret +
            "&code=" + parameter +
            "&redirect_uri=https://www.awd.com/"
        request.httpBody = postString.data(using: .utf8)
        
        //выполняем запрос
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
