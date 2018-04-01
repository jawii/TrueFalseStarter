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
    var answerButtons: [UIButton]
    let questionField: UILabel
    let playAgainButton: UIButton

    
    init(questionsPerRound: Int, answerButtons: [UIButton], questionField: UILabel, playAgainButton: UIButton) {
        self.questionsPerRound = questionsPerRound
        self.answerButtons = answerButtons
        self.questionField = questionField
        self.playAgainButton = playAgainButton
        
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
    func displayQuestion() {
        
        //shows all buttons at first
        showButtons()
        
        //hide playAgainButton
        playAgainButton.isHidden = true
        
        let question = questions[questionsAsked]
        
        questionField.text = question.question
        //scramble button array
        let btnArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: answerButtons) as! [UIButton]
        
        var choices = [question.correctAnswer, question.wrongAnswer1, question.wrongAnswer2, question.wrongAnswer3]
        
        var index = 0
        for btn in btnArray {
            btn.setTitle(choices[index], for: .normal)
        
            if(choices[index] == "no-fourth"){
                btn.isHidden = true
                //btn.removeFromSuperview();
            }
            index += 1
        }
        questionsAsked += 1
    }
    
    
    ///Show all buttons
    func showButtons(){
        for btn in answerButtons {
            btn.isHidden = false
        }
    }
    
    
}











