//
//  FindViewController.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/19.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import UIKit
import Dispatch

class FindViewController: UIViewController {
    
    @IBOutlet weak var selectTableView: UITableView!
    
    var lineList: [Line] = []
    var stationList: [Station] = []
    var selectedLines: [Line] = []
    var checked: [Int:Bool] = [:]
    var allTapped = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        selectTableView.delegate = self
        selectTableView.dataSource = self
        selectTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        // ナビゲーションバーの設定
        navigationController?.navigationBar.isHidden = false
        let backButton = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "検索設定画面"
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
        let semaphore = DispatchSemaphore(value: 0)
        // 路線一覧
        // APIクライアントの作成
        let client = ListClient()
        // リクエストの発行
        let request = ListAPI.SearchLineList(keyword: "1")
        // リクエストの送信
        client.send(request: request) { result in
            switch result {
            case let .success(response):
                for line in response.lines {
                    // チェックマーク初期化
                    self.checked[self.lineList.count] = false
                    self.lineList.append(line)
                }
            case let .failure(error):
                print(error)
            }
            semaphore.signal()
        }
        semaphore.wait()
        activityIndicatorView.stopAnimating()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRandom(_ sender: Any) {
        // 路線の初期化
        selectedLines.removeAll()
        for (key, value) in checked {
            if value {
                selectedLines.append(lineList[key])
            }
        }
        if selectedLines.count == 0 {
            // アラート
            nonselectionAlert()
            return
        }
        let randLine = Int.random(in: 0..<selectedLines.count)
        let viewController = RandomViewController()
        viewController.selectedLine = selectedLines[randLine]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func selectedAll(_ sender: Any) {
        if allTapped == 1 {
            for index in 0..<lineList.count {
                checked[index] = true
            }
        } else {
            for index in 0..<lineList.count {
                checked[index] = false
            }
        }
        selectTableView.reloadData()
        
        if allTapped == 0 {
            allTapped = 1
        } else {
            allTapped = 0
        }
    }
    
    func nonselectionAlert() {
        let alert: UIAlertController = UIAlertController(title: "条件を選択していません", message: "条件を選択してください", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension FindViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        
        (cell as BodyLabelDefinable).bodyLabel.text = lineList[indexPath.row].name
        // 初期化してるのでforceunwrapでok
        if checked[indexPath.row]! {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if checked[indexPath.row]! {
            checked[indexPath.row] = false
        } else {
            checked[indexPath.row] = true
        }
        tableView.reloadData()
    }
}
