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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UINib(nibName: "FriendTableViewCell", bundle: nil),
                         forCellReuseIdentifier: FriendTableViewCell.identifier)
        myTable.register(UINib(nibName: "MeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: MeTableViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusHeight.constant = CommonUtility.isPortrait() ? 20 : 0
    }


    @IBAction func keyboardDidEndOnExit(_ sender: Any) {
    }
    
}


extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            return cellForFriend(tableView, cellForRowAt: indexPath)
        } else {
            return cellForMe(tableView, cellForRowAt: indexPath)
        }
    }
    
    func cellForFriend(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier,
            for: indexPath) as? FriendTableViewCell else {
                return UITableViewCell()
        }
        return cell
    }
    
    func cellForMe(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeTableViewCell.identifier,
            for: indexPath) as? MeTableViewCell else {
                return UITableViewCell()
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
