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


    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        let alertController = UIAlertController(title: "Sign in!", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Name"
            }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
        let firstTextField = alertController.textFields![0] as UITextField
            var blah = firstTextField.text!
            AppData.key = self.ref.child("names").childByAutoId().key ?? "0"
            
            AppData.singleName = "\(blah)"
            AppData.names.append(blah)
            print(blah)
            print(AppData.singleName)
            self.ref.child("names").childByAutoId().setValue(AppData.names)
            AppData.names = [""]

            self.ref.child("names").observe(.childAdded, with: { (snapshot) in
                // snapshot is a dictionary with a key and a value
                
                // this gets each name from each snapshot
                let n = snapshot.value as! [String]
                // adds the name to an array if the name is not already there
                AppData.names.append(contentsOf:  n)
                    print(n)
                
                })
            
            
           

            
            })
        
            
            alertController.addAction(saveAction)
            
        self.present(alertController, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func appMovedToBackground(){
       /* print("BRUHHHH")
        for i in 0 ..< AppData.names.count{
            if (AppData.names[i] == AppData.singleName){
                //AppData.names.remove(at: i)
                print("HELP")
                ref.child("names").child(AppData.key).removeValue()


            }
        }
        for i in 0 ..< AppData.names.count{
            print(AppData.names[i])
            
        }
        print("i removed the name!")
    */
    }


}

