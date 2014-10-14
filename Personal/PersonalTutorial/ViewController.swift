//
//  ViewController.swift
//  PersonalTutorial
//
//  Created by sdnmacmini18 on 13/10/14.
//  Copyright (c) 2014 Viver. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,NSURLConnectionDataDelegate,NSURLConnectionDelegate {
    @IBOutlet var tableView: UITableView!
    var items: [String] = ["We", "Heart", "Objective c"]
    let cellId: String = "cellId"
    let ROMAN_TYPE_STRING = "roman"
    var responseData: NSMutableData = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden=true
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(cellId) as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
        
        if indexPath.row==0{
            self.parseDataFromServer(10, serviceNameString: "https://juvora.com/app/topic/rest/newest/limit/30")
        }
        else if indexPath.row==2{
            self.loadUserListTableViewController()
        }
        
    }
    
    func loadUserListTableViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userListStoryboard = storyboard.instantiateViewControllerWithIdentifier("UserList") as UserListTableViewController
        userListStoryboard.userNameStringArray=items
        self.navigationController?.pushViewController(userListStoryboard, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UserList"{
            let userListStoryboard:UserListTableViewController = segue.destinationViewController as UserListTableViewController
            userListStoryboard.userNameStringArray=items
        }
    }
    
    func parseDataFromServer(timeOut:Int, serviceNameString:String ){
        let url:NSURL = NSURL.URLWithString(serviceNameString)
        var request:NSURLRequest=NSURLRequest(URL:url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
    func controllerValidation(typeString:String?, textFieldArray:[UITextField]?, validationStringArray:[String])->Bool{
        if typeString == ROMAN_TYPE_STRING{
            return false
        }
        else{
            return true
        }
    }
    
    // MARK: NSURLConnection Delegate Methods.
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Recieved a new request, clear out the data object
        self.responseData = NSMutableData()
    }
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append the recieved chunk of data to our data object
        self.responseData.appendData(data)
//        println("responseData: \(responseData)")
    }
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Request complete, self.data should now hold the resulting info
        // Convert the retrieved data in to an object through JSON deserialization
        var err: NSError?=nil
        var jsonResult: NSArray = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
        
        if jsonResult.count>0{
            println("results: \(jsonResult)")
        }
    }
}