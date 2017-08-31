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
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    var messages = [Message]()
    var isFriend = true
    
    var isCanSend = false {
        didSet{
            sendButton.isEnabled = isCanSend
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UINib(nibName: "FriendTableViewCell", bundle: nil),
                         forCellReuseIdentifier: FriendTableViewCell.identifier)
        myTable.register(UINib(nibName: "MeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: MeTableViewCell.identifier)
        getMessages()
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusHeight.constant = CommonUtility.isPortrait() ? 20 : 0
    }

    func getMessages() {
        let message13 = Message(value: "This is my friend")
        let message14 = Message(value: "This is me", isFriend: false)
        messages.append(message13)
        messages.append(message14)
    }
    
    // MARK: IBAction
    @IBAction func sendButtonPush(_ sender: Any) {
        print("Send")
        //let message = Message(value: "This is me", isFriend: isFriend)
    }

    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        print(segmentedControl.selectedSegmentIndex) // 0 = friend, 1 = me
        isFriend = segmentedControl.selectedSegmentIndex == 0
    }
    
    @IBAction func saveButtonPush(_ sender: Any) {
        print("Save")
    }
    
    @IBAction func cancelButtonPush(_ sender: Any) {
        print("Cancel")
    }

}


extension HomeViewController: UITableViewDataSource {

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

extension HomeViewController: UITextFieldDelegate {

    func textFieldDidChange(_ textField: UITextField) {
        if let textInput = textField.text {
            isCanSend = textInput.characters.count > 0
        }
    }

}
