//
//  Utility.swift
//  ToDo
//
//  Created by Chirag Paneliya on 10/06/19.
//  Copyright © 2019 CugnusSoftTech. All rights reserved.
//

import UIKit

class Utility: NSObject {

    static func showAlertViewController(title:String, message:String, onViewController: UIViewController) {
        
        let alertController : UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction : UIAlertAction = UIAlertAction.init(title: "Ok", style: .cancel) { (action: UIAlertAction) in
            
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            onViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}

extension UIView {
    
    //Shake animation
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.red.cgColor
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

