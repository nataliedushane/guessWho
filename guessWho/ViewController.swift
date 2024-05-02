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
    
    var ref: DatabaseReference!
    var defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        AppData.wins = defaults.integer(forKey: "theWins")
        AppData.losses = defaults.integer(forKey: "theLosses")
        
        if(defaults.string(forKey: "theName") == nil){
            AppData.singleName = defaults.string(forKey: "theName")!
            print("\(AppData.singleName)")
        }
        else{
            
            
            let alertController = UIAlertController(title: "Sign in!", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Name"
            }
            let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
                var blah = firstTextField.text!
                AppData.key = self.ref.child("names").childByAutoId().key ?? "0"
                
                AppData.singleName = "\(blah)"
                
                
                self.defaults.set(AppData.singleName, forKey: "theName")
                
                AppData.names.append(blah)
                print(blah)
                print(AppData.singleName)
                self.ref.child("names").childByAutoId().setValue(AppData.singleName)
                AppData.names = [""]
                
                                
                
                
                
                
            })
            
            
            
            
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        self.ref.child("names").observe(.childAdded, with: { (snapshot) in
            // snapshot is a dictionary with a key and a value
            
            // this gets each name from each snapshot
            let n = snapshot.value as! String
            // adds the name to an array if the name is not already there
            AppData.names.append(n)
            print(n)
            
        })

        
        ref.child("names").observe(.childRemoved, with: { (snapshot) in
            // snapshot is a dictionary with a key and a value
            
            let n = snapshot.value as! [String]
            // adds the name to an array if the name is not already there
            AppData.names.append(contentsOf:  n)
                print(n)
            
        
         
            
           // self.tableViewOutlet.reloadData()
           
        })
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func appMovedToBackground(){
        print("BRUHHHH")
        print("hello")
        ref = Database.database().reference()

        self.ref.child("names").child(AppData.key).removeValue()

        print("i removed the name!")
    
    }

    func deleteFromFirebase() {
        ref.child("names").child(AppData.key).removeValue()
    }

}

