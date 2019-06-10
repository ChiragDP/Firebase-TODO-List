//
//  AddToDoVC.swift
//  ToDo
//
//  Created by Chirag Paneliya on 06/06/19.
//  Copyright © 2019 CugnusSoftTech. All rights reserved.
//

import UIKit
import Firebase
import AudioToolbox

class AddToDoVC: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnDONE: UIBarButtonItem!
    @IBOutlet weak var txtDate: UITextField!
    
    var todoP:ToDo?
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtTitle.delegate = self
        self.txtDate.delegate = self
        self.txtMessage.delegate = self
        
        txtTitle.tintColor = .white
        txtMessage.tintColor = .white
        txtDate.tintColor = .white
        
        txtTitle.layer.cornerRadius = 5.0
        txtDate.layer.cornerRadius = 5.0
        txtMessage.layer.cornerRadius = 5.0
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .dateAndTime
        datePickerView.minimumDate = Date()
        txtDate.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        if self.todoP != nil {
            txtTitle.text = self.todoP?.name
            txtMessage.text = self.todoP?.message
            txtDate.text = self.todoP?.reminderDate
            btnDONE.title = "Update"
            self.title = "UPDATE"
        }
        else {
            btnDONE.title = "Add"
            self.title = "ADD NEW"
        }
    }
    
    //MARK:- UITextField Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if txtTitle.isFirstResponder {
            txtTitle.layer.borderWidth = 0.0
            let maxLength = 25
            let currentString: NSString = txtTitle.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else {
            return false
        }
    }
    
    //MARK:- UITextView Delegate Methods
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if txtMessage.isFirstResponder {
            txtMessage.layer.borderWidth = 0.0
            let maxLength = 350
            let currentString: NSString = txtMessage.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: text) as NSString
            return newString.length <= maxLength
        }
        else{
            return false
        }
    }
    
    //Date picker action
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        txtDate.layer.borderWidth = 0.0
        txtDate.text = dateFormatter.string(from: sender.date)
    }

    //Done button click
    /*
     *Add or update firebase data
     */
    @IBAction func onDoneClicked(_ sender: Any) {
        
        if self.txtMessage.text!.count == 0 || self.txtTitle.text!.count == 0 || self.txtDate.text!.count == 0 {
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            if self.txtTitle.text!.count == 0 {

                self.txtTitle.shake()
            }
            else if self.txtMessage.text!.count == 0 {

                self.txtMessage.shake()
            }
            else if self.txtDate.text!.count == 0 {

                self.txtDate.shake()
            }
        }
        else {
            
            self.addUpdateData()
        }
        
    }
    
    //MARK:- Firebase Methods
    func addUpdateData() {
        
        let ref = Database.database().reference()
        
        var key = ""
        if todoP == nil {
            todoP = ToDo()
            key = ref.child("todoList").childByAutoId().key!
        }
        else {
            key = todoP!.key!
        }
        todoP?.name = self.txtTitle.text
        todoP?.message = self.txtMessage.text
        todoP?.reminderDate = self.txtDate.text
        
        let dictionaryTodo = [ "name"    : todoP!.name! ,
                               "message" : todoP!.message!,
                               "date"    : todoP!.reminderDate!,
                               "isCompleted": "0"]
        
        let childUpdates = ["/todoList/\(key)": dictionaryTodo]
        ref.updateChildValues(childUpdates, withCompletionBlock: { (error, ref) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
}
