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
    
    var questions: [Question]
    let questionsPerRound: Int
    var questionsAsked: Int = 0
    var correctQuestions: Int = 0
    
    //buttons
    let questionFieldText: UILabel
    let answerButtonOne: UIButton
    let answerButtonTwo: UIButton
    let answerButtonThree: UIButton
    let answerButtonFour: UIButton
    

    
    init(questionsPerRound: Int, questionFieldText: UILabel, answerButtonOne: UIButton, answerButtonTwo: UIButton, answerButtonThree: UIButton, answerButtonFour: UIButton!) {
        self.questionsPerRound = questionsPerRound
        
        self.questionFieldText = questionFieldText
        self.answerButtonOne = answerButtonOne
        self.answerButtonTwo = answerButtonTwo
        self.answerButtonThree = answerButtonThree
        self.answerButtonFour = answerButtonFour
        
        //create new Quiz and take the questions
        let quiz = Quiz()
        self.questions = quiz.questions
    }
    
    ///Scramble the Quiz questions
    func scrambleQuizQuestions() {
        //scramble the quiz
        let newQuestions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: questions)
        self.questions = newQuestions as! [Question]
    }
    
    
    ///Displays Question
    func displayQuestion(toLabel: UILabel, answers: [UIButton], question: Question) {
        
    }
}
