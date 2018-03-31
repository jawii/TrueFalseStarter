//
//  QuizProvider.swift
//  TrueFalseStarter
//
//  Created by Jaakko Kenttä on 31/03/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

class Quiz {
    let questionsPerRound: Int = 4
    var questionsAsked: Int = 0
    var correctQuestions: Int = 0
    
    var questions: Question!
    
    init(questions: Question!){
        self.questions = questions
    }
    
}

