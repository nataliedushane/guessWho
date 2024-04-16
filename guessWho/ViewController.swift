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
            var blah = [firstTextField.text! : AppData.names]
            print(blah)
            //self.ref.child("decks").childByAutoId().setValue(blah)
           // self.newDeck = []
           // self.table.reloadData()
            })
        
            
            alertController.addAction(saveAction)
            
        self.present(alertController, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func appMovedToBackground(){
    
    }


}

