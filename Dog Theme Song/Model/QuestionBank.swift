//
//  QuestionBank.swift
//  Dog Theme Song
//
//  Created by Friedman, Gwendolyn on 3/15/19.
//  Copyright © 2019 Gwen Friedman. All rights reserved.
//

import Foundation

class QuestionBank {
    
    var list = [Question]()
    
    var dogName2 = NameViewController.GlobalVariable.dogName
        
    init() {
        list.append(Question(questionText: "How big is \(dogName2)?", choiceA: "big", choiceB: "medium", choiceC: "small", choiceD: "tiny", points: 1))
        
        list.append(Question(questionText: "What size is \(dogName2)?", choiceA: "huge", choiceB: "big", choiceC: "medium", choiceD: "small", points: 10))
        
        list.append(Question(questionText: "\(dogName2) is...", choiceA: "a good boy", choiceB: "a good girl", choiceC: "a naughty boy",
                             choiceD: "a naughty girl", points: 100))
        
    }
}
