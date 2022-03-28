//
//  ViewController.swift
//  TicTacToe
//
//  Created by TechnoMac6 on 24/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
       case Circle
       case Cross
    }
    
    @IBOutlet weak var lblTurn: UILabel!
    @IBOutlet weak var btnA1: UIButton!
    @IBOutlet weak var btnA2: UIButton!
    @IBOutlet weak var btnA3: UIButton!
    @IBOutlet weak var btnB1: UIButton!
    @IBOutlet weak var btnB2: UIButton!
    @IBOutlet weak var btnB3: UIButton!
    @IBOutlet weak var btnC1: UIButton!
    @IBOutlet weak var btnC2: UIButton!
    @IBOutlet weak var btnC3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var Circle = "O"
    var Cross = "X"
    var board = [UIButton]()
    var circleScore = 0
    var crossScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       initBoard()
        
    }
    
    func initBoard(){
        board.append(btnA1)
        board.append(btnA2)
        board.append(btnA3)
        board.append(btnB1)
        board.append(btnB2)
        board.append(btnB3)
        board.append(btnC1)
        board.append(btnC2)
        board.append(btnC3)
    }
    
    func fullBoard() -> Bool {
        for button in board{
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(Cross){
            
            crossScore += 1
           resultAlert(title: "Cross Wins")
        }
        if checkForVictory(Circle){
            
            circleScore += 1
            resultAlert(title: "Circle Wins")
        }
        
        if fullBoard() {
            resultAlert(title: "Draw")
        }
    }
    
    func addToBoard(_ sender: UIButton){
        if (sender.title(for: .normal) == nil) {
            	
            if(currentTurn) == Turn.Circle {
                
                sender.setTitle(Circle, for: .normal)
                currentTurn = Turn.Cross
                lblTurn.text = Cross
                
            } else if (currentTurn) == Turn.Cross {
                
                sender.setTitle(Cross, for: .normal)
                currentTurn = Turn.Circle
                lblTurn.text = Circle
            }
        }
    }
    
    func resetBoard() {
        
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if firstTurn == Turn.Circle {
            
            firstTurn = Turn.Cross
            lblTurn.text = Cross
            
        } else if firstTurn == Turn.Cross{
            
            firstTurn = Turn.Circle
            lblTurn.text = Circle
        }
        
        currentTurn = firstTurn
    }
    
    func resultAlert(title: String) {
        
        let message = "\nCircle: " + String(circleScore) + "\n\n Cross: " + String(crossScore)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()                        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkForVictory(_ s: String) -> Bool{
        
        // Horizontal Victory
        if thisSymbol(btnA1, s) && thisSymbol(btnA2, s) && thisSymbol(btnA3, s){
            return true
        }
        if thisSymbol(btnB1, s) && thisSymbol(btnB2, s) && thisSymbol(btnB3, s){
            return true
        }
        if thisSymbol(btnC1, s) && thisSymbol(btnC2, s) && thisSymbol(btnC3, s){
            return true
        }
        
        // Vertical Victory
        if thisSymbol(btnA1, s) && thisSymbol(btnB1, s) && thisSymbol(btnC1, s){
            return true
        }
        if thisSymbol(btnA2, s) && thisSymbol(btnB2, s) && thisSymbol(btnC2, s){
            return true
        }
        if thisSymbol(btnA3, s) && thisSymbol(btnB3, s) && thisSymbol(btnC3, s){
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(btnA1, s) && thisSymbol(btnB2, s) && thisSymbol(btnC3, s){
            return true
        }
        if thisSymbol(btnA3, s) && thisSymbol(btnB2, s) && thisSymbol(btnC1, s){
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool{
        return button.title(for: .normal) == symbol
    }
}
