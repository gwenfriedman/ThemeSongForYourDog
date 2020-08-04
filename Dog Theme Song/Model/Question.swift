//
//  Question.swift
//  Dog Theme Song
//
//  Created by Friedman, Gwendolyn on 3/15/19.
//  Copyright © 2019 Gwen Friedman. All rights reserved.
//

import Foundation

class Question {
    
    //question is of type string
    var question: String
    var optionA: String
    var optionB: String
    var optionC: String
    var optionD: String
    var val: Int
    
    init(questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, points: Int) {
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
        val = points
    }
}
