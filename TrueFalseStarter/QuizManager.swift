//
//  QuizManager.swift
//  TrueFalseStarter
//
//  Created by Jaakko Kenttä on 31/03/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit
//for shuffling
//import GameplayKit
import GameKit

class QuizManager {
    
    var quiz: Quiz
    let questionsPerRound: Int
    var questionsAsked: Int = 0
    var correctQuestions: Int = 0
    
    //buttons
    let questionFieldText: UILabel!
    let answerButtonOne: UILabel!
    let answerButtonTwo: UILabel!
    let answerButtonThree: UILabel!
    let answerButtonFour: UILabel!
    
    init(questionsPerRound: Int, questionFieldText: UILabel!, answerButtonOne: UILabel!, answerButtonTwo: UILabel!, answerButtonThree: UILabel!, answerButtonFour: UILabel!, quiz: Quiz) {
        
        self.questionsPerRound = questionsPerRound
        self.questionFieldText = questionFieldText
        self.answerButtonOne = answerButtonOne
        self.answerButtonTwo = answerButtonTwo
        self.answerButtonThree = answerButtonThree
        self.answerButtonFour = answerButtonFour
        
        self.quiz = quiz
    }
    
    ///Scramble the Quiz questions
    func scrambleQuizQuestions() {
        //scramble the quiz
        let newQuiz = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: quiz.questions)
        quiz.questions = newQuiz as! [Question]
    }
    
    
    ///Displays Question
    func displayQuestion() {
            
    }
}
