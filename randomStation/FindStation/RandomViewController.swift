//
//  RandomViewController.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/29.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import UIKit
import Dispatch
import GoogleMaps
import SafariServices

class RandomViewController: UIViewController {
    
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var preStationLabel: UILabel!
    @IBOutlet weak var nextSataionLabel: UILabel!
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    var thisStation: Station?
    var stations: [Station] = []
    var selectedLine: Line?
    var favorite = false
    var favoriteStations: [String:String] = [:]
    
    @IBOutlet weak var mapView: UIView!
    var googleMap: GMSMapView!
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    let zoom: Float = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // ナビゲーションバーの設定
        navigationController?.navigationBar.isHidden = false
        let backButton = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = selectedLine!.name
        
        // ボタンの設定
        wikiButton.layer.cornerRadius = 10.0
        favoriteButton.layer.cornerRadius = 10.0
        
        // ネットワークの非同期処理をセマフォを使って対処
        // 駅一覧
        let request = ListAPI.SearchStationList(keyword: "\(self.selectedLine!.code)")
        let client = ListClient()
        let semaphore = DispatchSemaphore(value: 0)
        client.send(request: request) { result in
            switch result {
            case let .success(response):
                self.stations = response.stations
            case let .failure(error):
                print(error)
            }
            semaphore.signal()
        }
        semaphore.wait()
        let randNumber = Int.random(in: 0..<stations.count)
        thisStation = stations[randNumber]
        stationLabel.text = stations[randNumber].name
        if case 0..<stations.count = (randNumber - 1) {
            preStationLabel.text = stations[randNumber - 1].name
        }
        if case 0..<stations.count = (randNumber + 1) {
            nextSataionLabel.text = stations[randNumber + 1].name
        }
        
        // マップ設定
        latitude = thisStation!.lat
        longitude = thisStation!.lon
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: longitude, zoom: zoom)
        googleMap = GMSMapView(frame: mapView.frame)
        googleMap.camera = camera
        
        let marker: GMSMarker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.map = googleMap
        view.addSubview(googleMap)
        
        // お気に入り設定
        if let favoriteStations = UserDefaults.standard.dictionary(forKey: "favorite") {
            self.favoriteStations = favoriteStations as! [String : String]
            if favoriteStations["\(thisStation!.code)"] != nil {
                favorite = true
                favoriteImage.image = UIImage(named: "favoriteMark")
                favoriteButton.setTitle("お気に入りを解除する", for: .normal)
            }
        }
    }
    
    @objc func backButtonTapped() {
        UserDefaults.standard.set(favoriteStations, forKey: "favorite")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gotoWiki(_ sender: Any) {
        let urlString = "https://ja.wikipedia.org/wiki/\(thisStation!.name)駅"
        let encodeUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodeUrlString)!
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    @IBAction func tappedFavorite(_ sender: Any) {
        if favorite {
            favorite = false
            favoriteStations["\(thisStation!.code)"] = nil
            favoriteImage.image = UIImage(named: "nonfavoriteMark")
            favoriteButton.setTitle("お気に入りに登録する", for: .normal)
        } else {
            favorite = true
            favoriteStations["\(thisStation!.code)"] = thisStation!.name
            favoriteImage.image = UIImage(named: "favoriteMark")
            favoriteButton.setTitle("お気に入りを解除する", for: .normal)
        }
    }

}
