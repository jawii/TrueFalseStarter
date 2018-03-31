//
//  QuestionProvider.swift
//  TrueFalseStarter
//
//  Created by Jaakko Kenttä on 31/03/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation


struct Question {
    let question: String
    let answerChoisesAmount: Int
    let correctAnswer: String
    let wrongAnswer1: String
    let wrongAnswer2: String
    let wrongAnswer3: String!
    
    init(question: String, correctAnswer: String, wrongAnswer1: String, wrongAnswer2: String, wrongAnswer3: String = "no-fourth"){
        self.question = question
        self.correctAnswer = correctAnswer
        self.wrongAnswer1 = wrongAnswer1
        self.wrongAnswer2 = wrongAnswer2
        self.wrongAnswer3 = wrongAnswer3
        
        if(wrongAnswer3 == "no-fourth"){
            self.answerChoisesAmount = 3
        }
        else{
            self.answerChoisesAmount = 4
        }
    }
}
