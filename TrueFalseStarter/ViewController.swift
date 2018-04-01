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
    
    
    //create quiz manager
    //can't assign buttons here so assign them in viewDidLoad - method
    var answerButtons: [UIButton] = []
    var quizManager :QuizManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerButtons = [answerOneButton, answerTwoButton, answerThreeButton, answerFourButton]
        quizManager = QuizManager(questionsPerRound: 4, answerButtons: answerButtons, questionField: questionField, playAgainButton: playAgainButton)
        
        quizManager.startGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        quizManager.checkAnswer(button: sender)
        loadNextRoundWithDelay(seconds: 2)
    }
    
    @IBAction func playAgain() {
        quizManager.startGame()
    }
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            //self.nextRound()
        }
    }
}

