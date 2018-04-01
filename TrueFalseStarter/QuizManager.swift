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
    

    
    init(questionsPerRound: Int) {
        self.questionsPerRound = questionsPerRound
        
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
    func displayQuestion(questionLabel label: UILabel, answerButtons:[UIButton]) {
        
        //shows all buttons at first
        showButtons(buttons: answerButtons)
        
        let question = questions[questionsAsked]
        
        label.text = question.question
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
    
    
    //Show all buttons
    func showButtons(buttons: [UIButton]){
        for btn in buttons {
            btn.isHidden = false
        }
    }
}











