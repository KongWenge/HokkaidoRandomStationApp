//
//  StartViewController.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/19.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "メニュー"
    }
    
    @IBAction func tapFind(_ sender: Any) {
        let viewController = FindViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapMap(_ sender: Any) {
        let viewController = MapViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapFavorite(_ sender: Any) {
        let viewController = FavoriteViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
