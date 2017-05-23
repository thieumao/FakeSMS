//
//  HomeViewController.swift
//  FakeSMS
//
//  Created by Thieu Mao on 4/2/17.
//  Copyright © 2017 Hay Nhanh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var statusHeight: NSLayoutConstraint!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UINib(nibName: "FriendTableViewCell", bundle: nil),
                         forCellReuseIdentifier: FriendTableViewCell.identifier)
        myTable.register(UINib(nibName: "MeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: MeTableViewCell.identifier)
        getMessages()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusHeight.constant = CommonUtility.isPortrait() ? 20 : 0
    }


    @IBAction func keyboardDidEndOnExit(_ sender: Any) {
    }

    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        print(segmentedControl.selectedSegmentIndex)
        let isFriend
    }

    func getMessages() {
        let message1 = Message(value: "Friend", isFriend: false)
        let message2 = Message(value: "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend ", isFriend: false)
        let message3 = Message(value: "Friend Friend Friend Friend Friend ", isFriend: false)
        let message4 = Message(value: "Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me ")
        let message5 = Message(value: "Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me ")
        let message6 = Message(value: "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend ", isFriend: false)
        let message7 = Message(value: "Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend Friend ", isFriend: false)
        let message8 = Message(value: "Friend FriendFriend ", isFriend: false)
        let message9 = Message(value: "Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me ")
        let message10 = Message(value: "Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me ")
        let message11 = Message(value: "Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me ")
        let message12 = Message(value: "Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me Me ")
        let message13 = Message(value: "Nguyen Van Thieu")
        let message14 = Message(value: "Nguyen Thi Thuy Linh", isFriend: false)
        messages.append(message1)
        messages.append(message2)
        messages.append(message3)
        messages.append(message4)
        messages.append(message5)
        messages.append(message6)
        messages.append(message7)
        messages.append(message8)
        messages.append(message9)
        messages.append(message10)
        messages.append(message11)
        messages.append(message12)
        messages.append(message13)
        messages.append(message14)
    }
    
}


extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if messages[row].isFriend {
            return cellForFriend(messages[row].value, tableView, cellForRowAt: indexPath)
        } else {
            return cellForMe(messages[row].value, tableView, cellForRowAt: indexPath)
        }
    }
    
    func cellForFriend(_ value: String, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier,
            for: indexPath) as? FriendTableViewCell else {
                return UITableViewCell()
        }
        cell.update(value)
        return cell
    }
    
    func cellForMe(_ value: String, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeTableViewCell.identifier,
            for: indexPath) as? MeTableViewCell else {
                return UITableViewCell()
        }
        cell.update(value)
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
