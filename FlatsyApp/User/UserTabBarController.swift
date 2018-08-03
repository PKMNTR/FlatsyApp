//
//  UserTabBarController.swift
//  FlatsyApp
//
//  Created by user140663 on 8/2/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class UserTabBarController: UITabBarController {
    
    let layerGradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layerGradient.colors = [UIColor(red: 40/255, green: 103/255, blue: 94/255, alpha: 1).cgColor, UIColor(red: 94/255, green: 190/255, blue: 178/255, alpha: 1).cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        layerGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        self.tabBar.layer.insertSublayer(layerGradient, at: 0)
    }

}
