//
//  FriendTableViewCell.swift
//  FakeSMS
//
//  Created by Thieu Mao on 5/20/17.
//  Copyright © 2017 Hay Nhanh. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    static let identifier = "FriendTableViewCell"
    var closeKeyboard: ((Void) -> Void)?

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(_ value: String) {
        label.text = value
    }
    
    @IBAction func endKeyboardButtonPush(_ sender: Any) {
        closeKeyboard?()
    }
    
}
