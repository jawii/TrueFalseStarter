//
//  QuizManager.swift
//  TrueFalseStarter
//
//  Created by Jaakko Kenttä on 31/03/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit
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
    var buttonsInitialColor: UIColor!
    
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
        self.buttonsInitialColor = answerButtons[0].backgroundColor
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
        
        //reset button colors
        for btn in answerButtons {
            let color = buttonsInitialColor
            //btn.setTitleColor(color, for: .normal)
            btn.backgroundColor = color
        }
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
            
            //change button color to green
            let color = UIColor.init(red: 0.0/255, green: 255.0/255, blue: 0.0/255, alpha: 1)
            //button.setTitleColor(color, for: .normal)
            button.backgroundColor = color
            //red: 251,green: 0, blue: 85
            //button.isHighlighted = true
        }
        else{
            //change button color to red
            let color = UIColor.init(red: 255.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1)
            button.backgroundColor = color
            
            //change correct answer button to light green
            correctAnswerButton.backgroundColor = UIColor.green
        }
        loadNextRoundWithDelay(seconds: 1)
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
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.gameLogic()
        }
    }
    
    
    
    //Anna on kiva
    
}











