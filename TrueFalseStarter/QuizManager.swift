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
    var timerBar: UIProgressView
    
    var timer :Timer = Timer()
    let answerTime: Int
    var seconds: Double
    
    //sound
    var gameSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 1
    var correctSound: SystemSoundID = 2

    
    init(questionsPerRound: Int, answerButtons: [UIButton], questionField: UILabel, playAgainButton: UIButton, timerBar: UIProgressView, answerTime: Int) {
        self.questionsPerRound = questionsPerRound
        self.answerButtons = answerButtons
        self.questionField = questionField
        self.playAgainButton = playAgainButton
        self.timerBar = timerBar
        
        playAgainButton.isHidden = true
        
        //create new Quiz and take the questions
        let quiz = Quiz()
        self.questions = quiz.questions
        self.buttonsInitialColor = answerButtons[0].backgroundColor
        
        self.answerTime = answerTime
        self.seconds = Double(answerTime)
    }
    
    ///Start game
    func startGame() {
        questionsAsked = 0
        correctQuestions = 0
        timerBar.isHidden = false
        
        for btn in answerButtons {
            let color = buttonsInitialColor
            btn.backgroundColor = color
        }
        //scramble questions
        scrambleQuizQuestions()
        loadGameSounds()
        playGameStartSound()
        displayQuestion()
        startTimer()
    }
    
    ///Makes the game logic
    func gameLogic(){
        //if questions asked is equal to questionPerRound -> quit the game and display score
        if(questionsPerRound == questionsAsked){
            displayScore()
        }
        //else display other question
        else {
            //restart timer
            seconds = Double(answerTime)
            timerBar.progress = 0
            timer.invalidate()
            startTimer()
            
            //reset button colors
            for btn in answerButtons {
                let color = buttonsInitialColor
                //btn.setTitleColor(color, for: .normal)
                btn.backgroundColor = color
            }
            
            displayQuestion()
        }
    }
    
    ///Check answer
    func checkAnswer(button: UIButton) {
        answered = true
        if button == correctAnswerButton {
            playCorrectAnswerSound()
            correctQuestions += 1
            //change button color to green
            let color = UIColor.init(red: 0.0/255, green: 255.0/255, blue: 0.0/255, alpha: 1)
            button.backgroundColor = color

        }
        else{
            playWrongAnswerSound()
            //change button color to red
            let color = UIColor.init(red: 255.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1)
            button.backgroundColor = color
            //change correct answer button to light green
            correctAnswerButton.backgroundColor = UIColor.green
        }
        timer.invalidate()
        addDelay(seconds: 2)
    }
    
    ///Displays score
    func displayScore(){
        timerBar.isHidden = true
        
        timer.invalidate()
        //hide all buttons
        hideAnswerButtons()
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        //show playButton
        playAgainButton.isHidden = false
    }
    
    ///Scrambles the Quiz questions
    func scrambleQuizQuestions() {
        //scramble the quiz
        let newQuestions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: questions)
        self.questions = newQuestions as! [Question]
    }
    
    ///Displays Question
    func displayQuestion() {
        timerBar.progress = 0
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
    
    ///Loads the game sounds
    func loadGameSounds() {
        var pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        var soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        
        pathToSoundFile = Bundle.main.path(forResource: "wrongSound", ofType: "wav")
        soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongSound)
        
        pathToSoundFile = Bundle.main.path(forResource: "correctSound", ofType: "wav")
        soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    ///Adds delay and moves to gamelogic
    func addDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.gameLogic()
        }

    }
    
    ///Starts timer with timeInterval 0.0625 = 1/2^4
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.0625, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    ///Updates times
    ///@objc <- dunno what that means but hey, it works :>
    @objc func updateTimer(){
        seconds -= 1/16
        
        let timerProgress = Double(timerBar.progress)
        timerBar.setProgress(Float(timerProgress + 1.0/(Double(answerTime) * 16.0)), animated: true)
        

        if timerBar.progress > 0.75 {
            timerBar.progressTintColor = UIColor.red
        }
        else{
            timerBar.progressTintColor = UIColor.green
        }
        //print(seconds)
        if(seconds <= 0){
            gameLogic()
        }
    }
 
}











