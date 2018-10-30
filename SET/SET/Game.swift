//
//  Game.swift
//  SET
//
//  Created by Shlyushka on 17.10.2018.
//  Copyright © 2018 shlyushka. All rights reserved.
//

import Foundation

class  Game {
    
    static var NUMBER_OF_CARDS: Int = 81
    
    var arrayOfCards = [Card]()
    var currentlyUsedCards = [Card]()
    var score: Int = 0
    var indexesOfThreeChosenCard: [Int?] = [nil, nil, nil]
    
    var setOfChosenCard = Set<Card?>()
    
    init() {
        for one in 0..<Card.NUMBER_OF_COMBINATION {
            for two in 0..<Card.NUMBER_OF_COMBINATION {
                for three in 0..<Card.NUMBER_OF_COMBINATION {
                    for four in 0..<Card.NUMBER_OF_COMBINATION {
                        let card = Card.init(color: Card.CardColor(rawValue: one)!, shape: Card.CardShape(rawValue: two)!, shade: Card.CardShading(rawValue: three)!, number: Card.CardNumber(rawValue: four)!)
                        arrayOfCards.append(card)
                    }
                }
            }
        }
        self.arrayOfCards.shuffle()
    }
    
    func chooseCard(at index: Int){
        
        if self.setOfChosenCard.count < 3{
            
            if !self.setOfChosenCard.contains(self.currentlyUsedCards[index]){
                self.setOfChosenCard.insert(self.currentlyUsedCards[index])
            }
            
            self.currentlyUsedCards[index].isChosen = true
            
        }else{
            //check if set
            if checkIfSet(){
                //delete cards and initialize new
                score += 3
                
                if arrayOfCards.count > 0{
                    //for index in self.setOfChosenCard{
                     //    self.currentlyUsedCards[index] = self.arrayOfCards.removeFirst()
                   // }
                    
                    for index in self.currentlyUsedCards.indices {
                        for eachCard in self.setOfChosenCard{
                            if self.currentlyUsedCards[index] == eachCard! {
                                self.currentlyUsedCards[index] = self.arrayOfCards.removeFirst() 
                            }
                        }
                    }
                    
//                    for index in self.currentlyUsedCards.indices{
//                    self.currentlyUsedCards[index] = self.arrayOfCards.removeFirst()
//                    }
                }else{
                    //empty title
                }
                
            }else {
                score -= 3
            }
            
            for index in self.currentlyUsedCards.indices{
                self.currentlyUsedCards[index].isChosen = false
            }
           
            self.setOfChosenCard.removeAll()
        
        }
    }
    
    func checkIfSet()->Bool{
        let cardsArray = Array(setOfChosenCard)
        
        if oneCommonFeature(at: cardsArray[0]!, and: cardsArray[1]!, and: cardsArray[2]!, for: "shape"){//Common shape, else are different
            return true
        }else if oneCommonFeature(at: cardsArray[0]!, and: cardsArray[1]!, and: cardsArray[2]!, for: "shade"){ //Common shade, else are different
            return true
        }else if oneCommonFeature(at: cardsArray[0]!, and: cardsArray[1]!, and: cardsArray[2]!, for: "color"){ //Common color, else are different
            return true
        }else if oneCommonFeature(at: cardsArray[0]!, and: cardsArray[1]!, and: cardsArray[2]!, for: "number"){//Common number, else are different
            return true
        }else if oneDifferentFeature(at: cardsArray[0]!, and: cardsArray[1]!, and: cardsArray[2]!, for: "number"){//Common shape, shade, color -> number is different
            return true
        }else if oneDifferentFeature(at: cardsArray[0]!, and: cardsArray[1]!, and: cardsArray[2]!, for: "color"){ //Common shape, shade, number -> color is different
            return true
        }else if oneDifferentFeature(at: cardsArray[0]!, and: cardsArray[1]!, and: cardsArray[2]!, for: "shade"){ //Common shape, number, color -> shade is different
            return true
        }else if oneDifferentFeature(at: cardsArray[0]!, and: cardsArray[1]!, and: cardsArray[2]!, for: "shape"){//Common number, shade, color -> shape is different
            return true
        }else if allDifferentFeatures(at: cardsArray[0]!, and: cardsArray[0]!, and: cardsArray[0]!){//Everything is different
            return true
        }else{
            return false
        }
    }

    func allDifferentFeatures(at cardOne: Card, and cardTwo: Card, and cardThree: Card) -> Bool{
        if cardOne.color != cardTwo.color && cardTwo.color != cardThree.color && cardThree.color != cardOne.color &&
            cardOne.shape != cardTwo.shape && cardTwo.shape != cardThree.shape && cardThree.shape != cardOne.shape &&
            cardOne.shade != cardTwo.shade && cardTwo.shade != cardThree.shade && cardThree.shade != cardOne.shade &&
            cardOne.number != cardTwo.number && cardTwo.number != cardThree.number && cardThree.number != cardOne.number {
            return true
        }else{
            return false
        }
    }
    
    func oneCommonFeature(at cardOne: Card, and cardTwo: Card, and cardThree: Card, for feature: String) -> Bool{
        
        switch feature {
        case "color":
            if cardOne.color != cardTwo.color && cardTwo.color != cardThree.color && cardThree.color != cardOne.color &&
                cardOne.shape == cardTwo.shape && cardTwo.shape == cardThree.shape && cardThree.shape == cardOne.shape &&
                cardOne.shade == cardTwo.shade && cardTwo.shade == cardThree.shade && cardThree.shade == cardOne.shade &&
                cardOne.number == cardTwo.number && cardTwo.number == cardThree.number && cardThree.number == cardOne.number {
                return true
            }else{
                return false
            }
        case "number":
          if  cardOne.number != cardTwo.number && cardTwo.number != cardThree.number && cardThree.number != cardOne.number &&
                cardOne.shape == cardTwo.shape && cardTwo.shape == cardThree.shape && cardThree.shape == cardOne.shape &&
                cardOne.shade == cardTwo.shade && cardTwo.shade == cardThree.shade && cardThree.shade == cardOne.shade &&
            cardOne.color == cardTwo.color && cardTwo.color == cardThree.color && cardThree.color == cardOne.color {
            return true
          }else{
            return false
            }
        case "shape":
            if cardOne.shape != cardTwo.shape && cardTwo.shape != cardThree.shape && cardThree.shape != cardOne.shape &&
                cardOne.color == cardTwo.color && cardTwo.color == cardThree.color && cardThree.color == cardOne.color &&
                cardOne.shade == cardTwo.shade && cardTwo.shade == cardThree.shade && cardThree.shade == cardOne.shade &&
                cardOne.number == cardTwo.number && cardTwo.number == cardThree.number && cardThree.number == cardOne.number {
                return true
            }else{
                return false
            }
        case "shade":
            if cardOne.shade != cardTwo.shade && cardTwo.shade != cardThree.shade && cardThree.shade != cardOne.shade &&
                cardOne.color == cardTwo.color && cardTwo.color == cardThree.color && cardThree.color == cardOne.color &&
                cardOne.shape == cardTwo.shape && cardTwo.shape == cardThree.shape && cardThree.shape == cardOne.shape &&
                cardOne.number == cardTwo.number && cardTwo.number == cardThree.number && cardThree.number == cardOne.number {
                return true
            }else{
                return false
            }
        default:
            return false
        }
    }
    
    func oneDifferentFeature(at cardOne: Card, and cardTwo: Card, and cardThree: Card, for feature: String) -> Bool{
        switch feature {
        case "color":
            if cardOne.color == cardTwo.color && cardTwo.color == cardThree.color && cardThree.color == cardOne.color &&
                cardOne.shape != cardTwo.shape && cardTwo.shape != cardThree.shape && cardThree.shape != cardOne.shape &&
                cardOne.shade != cardTwo.shade && cardTwo.shade != cardThree.shade && cardThree.shade != cardOne.shade &&
                cardOne.number != cardTwo.number && cardTwo.number != cardThree.number && cardThree.number != cardOne.number {
                return true
            }else{
                return false
            }
        case "number":
            if  cardOne.number == cardTwo.number && cardTwo.number == cardThree.number && cardThree.number == cardOne.number &&
                cardOne.shape != cardTwo.shape && cardTwo.shape != cardThree.shape && cardThree.shape != cardOne.shape &&
                cardOne.shade != cardTwo.shade && cardTwo.shade != cardThree.shade && cardThree.shade != cardOne.shade &&
                cardOne.color != cardTwo.color && cardTwo.color != cardThree.color && cardThree.color != cardOne.color {
                return true
            }else{
                return false
            }
        case "shape":
            if cardOne.shape == cardTwo.shape && cardTwo.shape == cardThree.shape && cardThree.shape == cardOne.shape &&
                cardOne.color != cardTwo.color && cardTwo.color != cardThree.color && cardThree.color != cardOne.color &&
                cardOne.shade != cardTwo.shade && cardTwo.shade != cardThree.shade && cardThree.shade != cardOne.shade &&
                cardOne.number != cardTwo.number && cardTwo.number != cardThree.number && cardThree.number != cardOne.number {
                return true
            }else{
                return false
            }
        case "shade":
            if cardOne.shade == cardTwo.shade && cardTwo.shade == cardThree.shade && cardThree.shade == cardOne.shade &&
                cardOne.color != cardTwo.color && cardTwo.color != cardThree.color && cardThree.color != cardOne.color &&
                cardOne.shape != cardTwo.shape && cardTwo.shape != cardThree.shape && cardThree.shape != cardOne.shape &&
                cardOne.number != cardTwo.number && cardTwo.number != cardThree.number && cardThree.number != cardOne.number {
                return true
            }else{
                return false
            }
        default:
        return false
        }
    }

}

