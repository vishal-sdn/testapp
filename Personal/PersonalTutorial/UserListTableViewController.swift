//
//  UserListTableViewController.swift
//  PersonalTutorial
//
//  Created by sdnmacmini18 on 13/10/14.
//  Copyright (c) 2014 Viver. All rights reserved.
//

import Foundation
import Foundation

import UIKit

class UserListTableViewController: UIViewController,UITableViewDataSource {
    // MARK: Declarations.
    var userDataStringArray:[String]?
    @IBOutlet   var userListTableView: UITableView!
    //    var userNameStringArray:[String]=["User A","User B","User C","User D"]
    var userNameStringArray:[String]=[]
    let cellIdString:String="cellId"
    
    // MARK: View Life Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdString)
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: UITableViewDataSource Methods.
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell=self.userListTableView.dequeueReusableCellWithIdentifier(cellIdString) as UITableViewCell
        cell.textLabel?.text=userNameStringArray[indexPath.row]
        cell.detailTextLabel?.text=userNameStringArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameStringArray.count
    }
}//test
