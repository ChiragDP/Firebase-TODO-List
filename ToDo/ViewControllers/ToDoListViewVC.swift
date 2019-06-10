//
//  ToDoListViewVC.swift
//  ToDo
//
//  Created by Chirag Paneliya on 06/06/19.
//  Copyright © 2019 CugnusSoftTech. All rights reserved.
//

import UIKit
import Firebase

let headerHeight : CGFloat = 40.0

class ToDoListViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblToDo: UITableView!
    @IBOutlet weak var lblNoData: UILabel!

    var todoListPending = [ToDo]()
    var todoListCompleted = [ToDo]()
    var isPendingPressed : Int!
    var isCompletedPressed : Int!
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isPendingPressed = 0
        isCompletedPressed = 0
        
        self.tblToDo.tableFooterView = UIView.init(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "To Do List"
        loadToDoData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    //MARK:- Button Click Events
    @objc func btnPendingPressed(sender:UIButton) {
        
        if isPendingPressed == 0 {
            
            isPendingPressed = 1
        }
        else {
            
            isPendingPressed = 0
        }
        tblToDo.reloadData()
    }
    
    
    @objc func btnCompletedPressed(sender:UIButton) {
        
        if isCompletedPressed == 0 {
            
            isCompletedPressed = 1
        }
        else {
            
            isCompletedPressed = 0
        }
        tblToDo.reloadData()
    }
    
    //MARK:- TableView Datasource & Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            
            return self.todoListCompleted.count > 0 ? (isCompletedPressed == 0 ? self.todoListCompleted.count : 0) : 0
        }
        else if section == 1 {
            
            return self.todoListPending.count > 0 ? (isPendingPressed == 0 ? self.todoListPending.count : 0) : 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {

            return self.todoListCompleted.count > 0 ? headerHeight : 0.0
        }
        else if section == 1 {
            
            return self.todoListPending.count > 0 ? headerHeight : 0.0
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            if self.todoListCompleted.count > 0 {
                
                let headerView : UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: headerHeight))
                headerView.backgroundColor = UIColor.darkGray
                
                let headerLabel = UILabel(frame: CGRect(x: 10.0, y: 0.0, width:headerView.frame.size.width - 20.0, height: headerView.frame.size.height))
                headerLabel.textColor = UIColor.white
                headerLabel.text = "Completed"
                headerView.addSubview(headerLabel)
                
                let headBttn:UIButton = UIButton(frame: CGRect(x:0.0, y:0.0, width:headerView.frame.size.width, height: headerView.frame.size.height))
                headBttn.addTarget(self, action: #selector(btnCompletedPressed(sender:)), for: UIControl.Event.touchUpInside)
                headerView.addSubview(headBttn)
                
                return headerView
            }
            
        }
        else if section == 1 {
            if self.todoListPending.count > 0 {
                let headerView : UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: headerHeight))
                headerView.backgroundColor = UIColor.darkGray
                
                let headerLabel = UILabel(frame: CGRect(x: 10.0, y: 0.0, width:headerView.frame.size.width - 20.0, height: headerView.frame.size.height))
                headerLabel.textColor = UIColor.white
                headerLabel.text = "Pending"
                headerView.addSubview(headerLabel)
                
                let headBttn:UIButton = UIButton(frame: CGRect(x:0.0, y:0.0, width:headerView.frame.size.width, height: headerView.frame.size.height))
                headBttn.addTarget(self, action: #selector(btnPendingPressed(sender:)), for: UIControl.Event.touchUpInside)
                headerView.addSubview(headBttn)
                
                return headerView
            }
        }
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if self.todoListCompleted.count > 0 {
                let cell : ToDoCompletedTVC = tblToDo.dequeueReusableCell(withIdentifier: "ToDoCompletedTVC") as! ToDoCompletedTVC
                
                
                cell.lblTitle.text = todoListCompleted[indexPath.row].name
                cell.lblDate.text = todoListCompleted[indexPath.row].reminderDate
                return cell
            }
        }
        else if indexPath.section == 1 {
            if self.todoListPending.count > 0 {
                let cell : ToDoPendingTVC = tblToDo.dequeueReusableCell(withIdentifier: "ToDoPendingTVC") as! ToDoPendingTVC
                
                
                cell.lblTitle.text = todoListPending[indexPath.row].name
                cell.lblDate.text = todoListPending[indexPath.row].reminderDate
                return cell
            }
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return self.todoListCompleted.count > 0 ? 66.0 : 0.0
        }
        else if indexPath.section == 1 {
            return self.todoListPending.count > 0 ? 66.0 : 0.0
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if indexPath.section == 0 {
            let todoVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailToDoVC") as! DetailToDoVC
            todoVC.todoC = todoListCompleted[indexPath.row]
            self.navigationController?.pushViewController(todoVC, animated: true)
        }
        else if indexPath.section == 1 {
            let todoVC = self.storyboard!.instantiateViewController(withIdentifier: "AddToDoVC") as! AddToDoVC
            todoVC.todoP = todoListPending[indexPath.row]
            self.navigationController?.pushViewController(todoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if indexPath.section == 0 {
            
            let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
                
                let todo = self.todoListCompleted[indexPath.row]
                self.remove(todo: todo)
            }
            deleteAction.backgroundColor = .red
            return [deleteAction]
        }
        else if indexPath.section == 1 {
            
            let completeAction = UITableViewRowAction(style: .normal, title: "Compelete") { (rowAction, indexPath) in
                
                let todo = self.todoListPending[indexPath.row]
                self.makeCompleted(todo: todo)
            }
            completeAction.backgroundColor = .blue
            
            let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
                
                let todo = self.todoListPending[indexPath.row]
                self.remove(todo: todo)
            }
            deleteAction.backgroundColor = .red
            
            return [completeAction,deleteAction]
        }
        return nil
    }
    
    //MARK:- Firebase Methods
    func loadToDoData() {
        
        let ref = Database.database().reference()
        ref.child("todoList").observe(.value, with: { (snapshot) in
            
            self.todoListPending.removeAll()
            self.todoListCompleted.removeAll()
            if snapshot.exists() {
                
                for child in snapshot.children {
                    
                    if let firChild = child as? DataSnapshot {
                        
                        if let todoElement = firChild.value as? [String:AnyObject] {
                            
                            let strComplete = todoElement["isCompleted"] as? String
                            
                            let todo = ToDo()
                            todo.key = firChild.key
                            todo.name = todoElement["name"] as? String
                            todo.message = todoElement["message"] as? String
                            todo.reminderDate = todoElement["date"] as? String
                            
                            if strComplete == "1"{
                                todo.isComplete = "1"
                                self.todoListCompleted.append(todo)
                            }
                            else {
                                todo.isComplete = "0"
                                self.todoListPending.append(todo)
                            }
                        }
                    }
                }
            }
            if self.todoListPending.count > 0 || self.todoListCompleted.count > 0 {
                
                self.lblNoData.isHidden = true
            }
            else {
                
                self.lblNoData.isHidden = false
            }
            self.tblToDo.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func makeCompleted(todo: ToDo) {
        
        let ref = Database.database().reference()
        let key = todo.key
        ref.child("todoList").child(key!).child("isCompleted").setValue("1", withCompletionBlock: { (error, ref) in
            
            if (error != nil) {
                print(error!)
                Utility.showAlertViewController(title: "Firebase Errore", message: error?.localizedDescription, onViewController: self)
            }
        })
    }
    
    func remove(todo:ToDo) {
        
        let ref = Database.database().reference()
        ref.child("todoList").child(todo.key!).removeValue(completionBlock: { (error, reference) in
            if (error != nil) {
                print(error!)
                Utility.showAlertViewController(title: "Firebase Errore", message: error?.localizedDescription, onViewController: self)
            }
        })
    }
}


