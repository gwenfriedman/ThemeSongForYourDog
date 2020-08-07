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
    var gender = NameViewController.GlobalVariable.gender
    var gender2 = NameViewController.GlobalVariable.gender2
        
    init() {
        list.append(Question(questionText: "How big is \(dogName2)?", choiceA: "big", choiceB: "medium", choiceC: "small", choiceD: "tiny", points: 1))
        
        list.append(Question(questionText: "What type of hair does \(dogName2) have?", choiceA: "curly", choiceB: "short", choiceC: "long", choiceD: "fluffy", points: 10))
        
        list.append(Question(questionText: "How old is \(dogName2) in dog years?", choiceA: "0-7", choiceB: "8-21", choiceC: "22-63", choiceD: "64+", points: 100))
        
        list.append(Question(questionText: "How is \(dogName2) behaved?", choiceA: "Goes with the rules", choiceB: "goes against the rules", choiceC: "makes the rules", choiceD: "is oblivious to the rules", points: 1000))
        
        list.append(Question(questionText: "Who is \(dogName2)'s best friend?", choiceA: "you", choiceB: "other dogs", choiceC: "\(gender) favorite toy", choiceD: "\(gender2) a loner", points: 10000))
        
        list.append(Question(questionText: "What is \(dogName2)'s favorite thing to chase?", choiceA: "frisbee", choiceB: "ball", choiceC: "squirrel", choiceD: "nothing", points: 100000))
        
        list.append(Question(questionText: "Where is \(dogName2)'s favorite spot to get pet?", choiceA: "head", choiceB: "tummy", choiceC: "ears", choiceD: "back", points: 1000000))
        
        list.append(Question(questionText: "Where is \(dogName2)'s nemesis?", choiceA: "cat", choiceB: "squirrel", choiceC: "mailman", choiceD: "baths", points: 10000000))
        
        list.append(Question(questionText: "What is \(dogName2)'s energy level?", choiceA: "high", choiceB: "medium", choiceC: "low", choiceD: "always alseep", points: 100000000))
        
        list.append(Question(questionText: "What Hogwart's house would \(dogName2) be in?", choiceA: "Gryffindor", choiceB: "Slytherin", choiceC: "Hufflepuff", choiceD: "Ravenclaw", points: 1000000000))
        
    }
}
