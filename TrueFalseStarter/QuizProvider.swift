//
//  QuizProvider.swift
//  TrueFalseStarter
//
//  Created by Jaakko Kenttä on 31/03/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct Quiz {
    
    let questions: [Question] =
        [
        Question(question: "Radioactive spider bite him.", correctAnswer: "Spiderman", wrongAnswer1: "Thor", wrongAnswer2: "Hulk", wrongAnswer3: "Pickachu"),
        Question(question: "Bones are covered in adamantium. Also has claws and healing powers.", correctAnswer: "Wolverine", wrongAnswer1: "Daredevil", wrongAnswer2: "Hulk"),
        Question(question: "Body enchanced from an injection of a special serum during WWII.", correctAnswer: "Captain America", wrongAnswer1: "Iron Man", wrongAnswer2: "Hulk", wrongAnswer3: "Spiderman"),
        Question(question: "Eccentric playboy billionaire.", correctAnswer: "Iron Man", wrongAnswer1: "Daredevil", wrongAnswer2: "Deadpool"),
        Question(question: "Extraordinary hand-to-hand combatant. Carries often two swords and has healing powers.", correctAnswer: "Deadpool", wrongAnswer1: "Thor", wrongAnswer2: "Magneto", wrongAnswer3: "Daredevil"),
        Question(question: "Hammer time - man", correctAnswer: "Thor", wrongAnswer1: "Iron Man", wrongAnswer2: "Wolverine"),
        Question(question: "Boxer's son. Lost sight when he was a kid.", correctAnswer: "Daredevil", wrongAnswer1: "Docrot Strange", wrongAnswer2: "Hawkeye", wrongAnswer3: "Black Panther"),
        Question(question: "Real name is T'Challa.", correctAnswer: "Black Panther", wrongAnswer1: "Thor", wrongAnswer2: "Superman"),
        Question(question: "Powerful sorcerer.", correctAnswer: "Doctor Strange",wrongAnswer1: "Thor", wrongAnswer2: "Superman", wrongAnswer3: "Spiderman"),
        Question(question: "Breaks always his trousers when angry.", correctAnswer: "Hulk",wrongAnswer1: "Iron Man", wrongAnswer2: "Thor")
        ]
 }

