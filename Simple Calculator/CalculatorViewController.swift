//
//  ViewController.swift
//  Simple Calculator
//
//  Created by Andrei Momot on 11/22/16.
//  Copyright © 2016 Dr_Mom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    var currentInput: Double {
        get {
            return Double(resultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                resultLabel.text = "\(valueArray[0])"
            } else {
            resultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        sender.backgroundColor = UIColor.white
        let number = sender.currentTitle!
        if stillTyping {
            if (resultLabel.text?.characters.count)! < 20 {
                resultLabel.text = resultLabel.text! + number
            }
        } else {
            resultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    

    @IBAction func equalSignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            if secondOperand == 0 {
                firstOperand = 0
                secondOperand = 0
                currentInput = 0
                resultLabel.text = "Error"
                stillTyping = false
                dotIsPlaced = false
                operationSign = ""
            }else {
            operateWithTwoOperands{$0 / $1}
            }
        default: break
       
        }
    }

    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        resultLabel.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSign = ""
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            resultLabel.text = resultLabel.text! + "."
        }else if !stillTyping && !dotIsPlaced {
            resultLabel.text = "0."
        }
    }
}

