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
import AudioToolbox

class QuizManager {
    
    var questions: [Question]
    let questionsPerRound: Int
    var questionsAsked: Int = 0
    var correctQuestions: Int = 0
    var answerButtons: [UIButton]
    let questionField: UILabel
    let playAgainButton: UIButton
    var correctAnswerButton : UIButton!
    var answered: Bool = false
    
    //sound
    var gameSound: SystemSoundID = 0

    
    init(questionsPerRound: Int, answerButtons: [UIButton], questionField: UILabel, playAgainButton: UIButton) {
        self.questionsPerRound = questionsPerRound
        self.answerButtons = answerButtons
        self.questionField = questionField
        self.playAgainButton = playAgainButton
        
        playAgainButton.isHidden = true
        
        //create new Quiz and take the questions
        let quiz = Quiz()
        self.questions = quiz.questions
    }
    
    ///Start game
    func startGame() {
        questionsAsked = 0
        correctQuestions = 0
        
        //scramble questions
        scrambleQuizQuestions()
        
        loadGameStartSound()
        playGameStartSound()
        
        displayQuestion()
    }
    
    
    ///Make the game logic
    func gameLogic(){
        //if questions asked is equal to questionPerRound -> quit the game and display score
        if(questionsPerRound == questionsAsked){
            displayScore()
        }
        //else display other question
        else {
            displayQuestion()
        }
    }
    
    ///Check answer
    func checkAnswer(button: UIButton) {
        answered = true
        if button == correctAnswerButton {
            print("Correct Answer")
            correctQuestions += 1
        }
        gameLogic()
    }
    
    ///Displays score
    func displayScore(){
        //hide all buttons
        hideAnswerButtons()
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        //show playButton
        playAgainButton.isHidden = false
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
        showAnswerButtons()
        
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
            
            //get the right answer from array
            if index == 0 {
                correctAnswerButton = btn
            }
            
            if(choices[index] == "no-fourth"){
                btn.isHidden = true
                //btn.removeFromSuperview();
            }
            index += 1
        }
        questionsAsked += 1
    }
    
    
    ///Show all answerButtons
    func showAnswerButtons(){
        for btn in answerButtons {
            btn.isHidden = false
        }
    }
    
    ///Hides all answerButtons
    func hideAnswerButtons () {
        for btn in answerButtons {
            btn.isHidden = true
        }
    }
    
    
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    
    //Anna on kiva
    
}











