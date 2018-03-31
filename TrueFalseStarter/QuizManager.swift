//
//  QuizManager.swift
//  TrueFalseStarter
//
//  Created by Jaakko Kenttä on 31/03/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit


class QuizManager {
    
    let quiz: Quiz!
    
    //buttons
    let questionFieldText: UILabel!
    let answerButtonOne: UILabel!
    let answerButtonTwo: UILabel!
    let answerButtonThree: UILabel!
    let answerButtonFour: UILabel!
    
    init(questionFieldText: UILabel!, answerButtonOne: UILabel!, answerButtonTwo: UILabel!, answerButtonThree: UILabel!, answerButtonFour: UILabel!, quiz: Quiz! ) {
        
        self.questionFieldText = questionFieldText
        self.answerButtonOne = answerButtonOne
        self.answerButtonTwo = answerButtonTwo
        self.answerButtonThree = answerButtonThree
        self.answerButtonFour = answerButtonFour
        self.quiz = quiz
        
    }
    
    ///Displays Question
}
