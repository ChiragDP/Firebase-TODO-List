//
//  DetailToDoVC.swift
//  ToDo
//
//  Created by Chirag Paneliya on 07/06/19.
//  Copyright © 2019 CugnusSoftTech. All rights reserved.
//

import UIKit

class DetailToDoVC: UIViewController {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    
    var todoC:ToDo?
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTitle.text = self.todoC?.name
        txtMessage.text = self.todoC?.message
        lblDate.text = self.todoC?.reminderDate
    }
    
}
