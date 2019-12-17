//
//  FavoriteViewController.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/19.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import UIKit
import SafariServices

class FavoriteViewController: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteStations:[String:String] = [:]
    var favoriteStationsName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
        if let favoriteStations = UserDefaults.standard.dictionary(forKey: "favorite") {
            self.favoriteStations = favoriteStations as! [String : String]
        }
        for (_, value) in favoriteStations {
            favoriteStationsName.append(value)
        }
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteStationsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = favoriteStationsName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let urlString = "https://ja.wikipedia.org/wiki/\(favoriteStationsName[indexPath.row])駅"
        let encodeUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodeUrlString)!
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            for (key, value) in favoriteStations {
                if favoriteStationsName[indexPath.row] == value {
                    favoriteStations[key] = nil
                }
            }
            favoriteStationsName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            UserDefaults.standard.set(favoriteStations, forKey: "favorite")
        }
    }
}
