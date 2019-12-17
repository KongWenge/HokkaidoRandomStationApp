//
//  CustomCell.swift
//  randomStation
//
//  Created by Yuki Homma on 2019/05/24.
//  Copyright © 2019 Yuki Homma(Personal Team). All rights reserved.
//

import UIKit

protocol BodyLabelDefinable {
    var bodyLabel: UILabel! { get }
}

class CustomCell: UITableViewCell, BodyLabelDefinable {
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
