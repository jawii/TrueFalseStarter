//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    //create quiz manager
    //can't assign buttons here so assign them in viewDidLoad - method
    var answerButtons: [UIButton] = []
    var quizManager :QuizManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerButtons = [answerOneButton, answerTwoButton, answerThreeButton, answerFourButton]
        quizManager = QuizManager(questionsPerRound: 4, answerButtons: answerButtons, questionField: questionField, playAgainButton: playAgainButton, timerBar: progressBar, answerTime: 15)
        
        quizManager.startGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        quizManager.checkAnswer(button: sender)
    }
    
    @IBAction func playAgain() {
        quizManager.startGame()
    }
    
    // MARK: Helper Methods
    
    
}

