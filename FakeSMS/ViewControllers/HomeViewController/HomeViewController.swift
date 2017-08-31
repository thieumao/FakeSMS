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
    @IBOutlet weak var bottonInputViewConstraint: NSLayoutConstraint!
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
        myTable.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: FriendTableViewCell.identifier)
        myTable.register(UINib(nibName: "MeTableViewCell", bundle: nil), forCellReuseIdentifier: MeTableViewCell.identifier)
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusHeight.constant = CommonUtility.isPortrait() ? 20 : 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func handleKeyboardWillShowNotification(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                let heightKeyboard = keyboard.cgRectValue.size.height
                bottonInputViewConstraint.constant = heightKeyboard
                myTable.reloadData()
                scrollBottonTableView()
            }
        }
    }
    
    func handleKeyboardWillHideNotification(_ notification: NSNotification) {
        bottonInputViewConstraint.constant = 0
        myTable.reloadData()
        scrollBottonTableView()
    }
    
    private func scrollBottonTableView() {
        if messages.count > 0 {
            myTable.scrollToRow(at: IndexPath(item:messages.count - 1, section: 0), at: .bottom, animated: true)
        }
//        if myTable.contentSize.height > myTable.frame.size.height {
//            let offset = CGPoint(x: 0, y: myTable.contentSize.height - myTable.frame.size.height)
//            myTable.setContentOffset(offset, animated: true)
//        }
    }
    
    // MARK: IBAction
    @IBAction func sendButtonPush(_ sender: Any) {
        print("Send")
        let text: String = inputTextField.text ?? ""
        let message = Message(value: text, isFriend: isFriend)
        messages.append(message)
        myTable.reloadData()
        inputTextField.text = ""
        scrollBottonTableView()
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
        cell.closeKeyboard = { [unowned self] in
            self.view.endEditing(true)
        }
        return cell
    }
    
    func cellForMe(_ value: String, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeTableViewCell.identifier,
            for: indexPath) as? MeTableViewCell else {
                return UITableViewCell()
        }
        cell.update(value)
        cell.closeKeyboard = { [unowned self] in
            self.view.endEditing(true)
        }
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
