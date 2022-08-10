//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Doolot on 25/2/22.
//

import UIKit

class SplashController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        if UserDefaults.standard.string(forKey: "City") !=  nil {
            navigationController?.pushViewController(MainController(), animated: true)
        } else {
            navigationController?.pushViewController(SearchController(), animated: true)
        }
    }
}

