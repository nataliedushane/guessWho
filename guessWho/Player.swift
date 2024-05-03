//
//  Player.swift
//  guessWho
//
//  Created by MYKAELA WALLEN on 5/3/24.
//

import Foundation

class Player{
    
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
    
}
