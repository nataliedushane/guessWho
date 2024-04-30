//
//  WinViewController.swift
//  guessWho
//
//  Created by MYKAELA WALLEN on 4/26/24.
//

import UIKit

class WinViewController: UIViewController {

 
    
    @IBOutlet weak var winsOutlet: UILabel!
    
    @IBOutlet weak var lossesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        winsOutlet.text = "\(AppData.wins)"
        lossesLabel.text = "\(AppData.losses)"
        // Do any additional setup after loading the view.
    }
    
    
}
