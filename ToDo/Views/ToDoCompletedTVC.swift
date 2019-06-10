//
//  ToDoCompletedTVC.swift
//  ToDo
//
//  Created by Chirag Paneliya on 07/06/19.
//  Copyright © 2019 CugnusSoftTech. All rights reserved.
//

import UIKit

class ToDoCompletedTVC: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    var gradient: CAGradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let colorTop =  UIColor(red: 192.0/255.0, green: 115.0/255.0, blue: 39.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        gradient = CAGradientLayer()
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.viewBackground.frame.size.width, height: self.viewBackground.frame.size.height)
        self.viewBackground.layer.insertSublayer(gradient, at: 0)
        
        self.viewBackground.clipsToBounds = true
        self.viewBackground.layer.cornerRadius = 5.0
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.gradient.frame = self.viewBackground.bounds
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
