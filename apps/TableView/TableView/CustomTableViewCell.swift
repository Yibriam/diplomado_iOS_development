//
//  CustomTableViewCell.swift
//  TableView
//
//  Created by Yibriam on 15/11/25.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
