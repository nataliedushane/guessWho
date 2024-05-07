//
//  Player.swift
//  guessWho
//
//  Created by MYKAELA WALLEN on 5/3/24.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class Player{
    
    var ref = Database.database().reference()

    var name : String
    var whosPlaying : String
    var isPlaying : Bool
    var personYouHave : String
    var guess : String
    
    init(name: String, whosPlaying: String, isPlaying: Bool, personYouHave: String, guess: String) {
        self.name = name
        self.whosPlaying = whosPlaying
        self.isPlaying = isPlaying
        self.personYouHave = personYouHave
        self.guess = guess
    }
    
    init(name:String){
        self.name = name
        self.whosPlaying = ""
        self.isPlaying = true
        self.personYouHave = ""
        self.guess = ""
    }
    
    func saveToFirebase(){
        let dict = ["name" : name, "whosPlaying" : whosPlaying, "isPlaying" : isPlaying, "personYouHave" : personYouHave, "guess" : guess] as [String : Any]
        ref.child("players").childByAutoId().setValue(dict)
    }
}
