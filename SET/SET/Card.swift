//
//  Card.swift
//  SET
//
//  Created by Shlyushka on 17.10.2018.
//  Copyright © 2018 shlyushka. All rights reserved.
//

import Foundation
import UIKit

struct Card: Hashable{
    
    let color: CardColor
    let shade: CardShading
    let shape: CardShape
    let number: CardNumber
    
    var hashValue: Int {
        return (color.rawValue+shade.rawValue+shape.rawValue+number.rawValue).hashValue
    }

    
    static var identifierFactory: Int = 0
    
    static func createIdentifier() -> Int{
        identifierFactory += 1

        return identifierFactory
        }
    
    var titleOfCard: NSAttributedString {
        var attributes = [NSAttributedString.Key: Any]()
        var string: String = ""
       
            switch self {
            case _ where self.shape.rawValue == 0:
                string = String(repeating: "▲", count: self.number.rawValue + 1)
                break
            case _ where self.shape.rawValue == 1:
                string = String(repeating: "●", count: self.number.rawValue + 1)
                break
            case _ where self.shape.rawValue == 2:
                string = String(repeating: "■", count: self.number.rawValue + 1)
                break
            default:
                break;
            }
        
        if self.color.rawValue == 0{
            attributes[NSAttributedString.Key.foregroundColor] = UIColor.init(cgColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        }else if self.color.rawValue == 1{
            attributes[NSAttributedString.Key.foregroundColor] = UIColor.init(cgColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        }else if self.color.rawValue == 2{
            attributes[NSAttributedString.Key.foregroundColor] = UIColor.init(cgColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        }
        
        if self.shade.rawValue == 0{
            attributes[NSAttributedString.Key.strokeWidth] = -1
        }else if self.shade.rawValue == 1{
            attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.patternDash.rawValue | NSUnderlineStyle.single.rawValue
            
        }else if self.shade.rawValue == 2{
            attributes[NSAttributedString.Key.strokeWidth] = 10
        }

        return NSAttributedString(string: string, attributes: attributes)
    }
    
    
  //  var identifier: Int?
    
    var isMatched = false
    var isChosen = false
    
    public static var NUMBER_OF_COMBINATION: Int = 3
    
    public static func == (lhs: Card, rhs: Card) -> Bool {
        if lhs.color == rhs.color && lhs.shade == rhs.shade && lhs.shape == rhs.shape && lhs.number == rhs.number{
            return true
        }
        return false
    }
    
    enum CardColor: Int{
        case green = 0
        case purple = 1
        case red = 2
        
        var all: [CardColor] {return [CardColor.green, .purple, .red]}
    }
    
    enum CardShape: Int{
        case circle = 0
        case rectangle = 1
        case triangle = 2
        
        var all: [CardShape] {return [CardShape.circle, .rectangle, .triangle]}
    }
    
    enum CardShading: Int{
        case solid = 0
        case striped = 1
        case empty = 2
        
        var all: [CardShading] {return [CardShading.solid, .striped, .empty]}

    }
    
    enum CardNumber: Int{
        case one = 0
        case two = 1
        case three = 2
        
        var all: [CardNumber] {return [CardNumber.one, .two, .three]}

    }
    
    init(color: CardColor, shape: CardShape, shade: CardShading, number: CardNumber) {
        //self.identifier = Card.createIdentifier()
        self.color = color
        self.shape = shape
        self.shade = shade
        self.number = number
    }
    
}
