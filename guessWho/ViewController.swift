//
//  ViewController.swift
//  guessWho
//
//  Created by NATALIE DUSHANE on 3/5/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertController = UIAlertController(title: "Sign in!", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Name"
            }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
        let firstTextField = alertController.textFields![0] as UITextField
            var blah = firstTextField.text!
            AppData.singleName = "\(blah)"
            AppData.names.append(blah)
            print(blah)
            print(AppData.singleName)
            
            
            })
        
            
            alertController.addAction(saveAction)
            
        self.present(alertController, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func appMovedToBackground(){
        for i in 0 ..< AppData.names.count{
            if (AppData.names[i] == AppData.singleName){
                AppData.names.remove(at: i)
            }
        }
        for i in 0 ..< AppData.names.count{
            print(AppData.names[i])
            
        }
        print("i removed the name!")
    
    }


}

