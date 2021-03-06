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
    var gender = MFController.GlobalVariable.gender
    var gender2 = MFController.GlobalVariable.gender2
        
    init() {
        list.append(Question(questionText: "How big is \(dogName2)?", choiceA: "big", choiceB: "medium", choiceC: "small", choiceD: "tiny", points: 1))
        
        list.append(Question(questionText: "How old is \(dogName2)?", choiceA: "10+", choiceB: "3-9", choiceC: "1-3", choiceD: "0-1", points: 2))
        
        list.append(Question(questionText: "What type of hair does \(dogName2) have?", choiceA: "curly", choiceB: "short", choiceC: "long", choiceD: "fluffy", points: 3))
    
        list.append(Question(questionText: "How is \(dogName2) behaved?", choiceA: "goes with the rules", choiceB: "goes against the rules", choiceC: "makes the rules", choiceD: "is oblivious to the rules", points: 4))
        
        list.append(Question(questionText: "What is \(dogName2)'s favorite thing to chase?", choiceA: "squirrel", choiceB: "nothing", choiceC: "ball", choiceD: "frisbee", points: 5))
        
        list.append(Question(questionText: "Where is \(dogName2)'s favorite spot to get pet?", choiceA: "tummy", choiceB: "back", choiceC: "head", choiceD: "ears", points: 6))

        list.append(Question(questionText: "Who is \(dogName2)'s best friend?", choiceA: "you", choiceB: "\(gender) favorite toy", choiceC: "\(gender2) a loner", choiceD: "other dogs", points: 7))
        
        list.append(Question(questionText: "What is \(dogName2)'s nemesis?", choiceA: "the mailman", choiceB: "squirrels", choiceC: "baths", choiceD: "cats", points: 8))
        
        list.append(Question(questionText: "What Hogwart's house would \(dogName2) be in?", choiceA: "Gryffindor (loyal)", choiceB: "Slytherin (sneaky)", choiceC: "Hufflepuff (friendly)", choiceD: "Ravenclaw (smart)", points: 9))
        
    }
}
