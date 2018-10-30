//
//  ViewController.swift
//  SET
//
//  Created by Shlyushka on 16.10.2018.
//  Copyright © 2018 shlyushka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   lazy var game = Game()
   var currentScore = 0
    
    
    private func setScore(){
        
        
        if game.score > currentScore{
            scoreLabel.text = "Score:  \(game.score)"
            
            dynamicScoreLabel.textColor = UIColor.green
            dynamicScoreLabel.text = "(+3)"
        }else if game.score < currentScore{
            scoreLabel.text = "Score:  \(game.score)"
            
            dynamicScoreLabel.textColor = UIColor.red
            dynamicScoreLabel.text = "(-3)"
        }
       
        currentScore = game.score
    }
    
    override func viewDidLoad() {
        
        for button in buttonCollection {
            let index = buttonCollection.index(of: button)
            game.currentlyUsedCards.append(game.arrayOfCards.remove(at: index!))
            setTitleOfCard(for: index!)
            
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var dynamicScoreLabel: UILabel!
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
    
        let index = buttonCollection.index(of: sender)
        
        game.chooseCard(at: index!)
       
        
        update()

    }
    
    
    
    
    
   
    func selectCard(button: UIButton){
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8.0
    }
    
    func deselectCard(button: UIButton){
        button.layer.borderWidth = 0.0
        button.layer.borderColor = button.backgroundColor?.cgColor
        button.layer.cornerRadius = 0.0
    }
    
    func update(){
        setScore()
        
        for index in game.currentlyUsedCards.indices{
            
            let button = buttonCollection![index]
            let card = game.currentlyUsedCards[index]
            
            setTitleOfCard(for: index)
            
            if card.isChosen{ selectCard(button: button)
            }else{ deselectCard(button: button)}
    
        }
        
    }
    
    func setTitleOfCard(for index: Int){
    buttonCollection[index].setAttributedTitle(game.currentlyUsedCards[index].titleOfCard, for: .normal)
    }
    
}


