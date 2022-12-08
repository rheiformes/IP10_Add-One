//
//  ViewController.swift
//  IP10_Add-One
//
//  Created by Rai, Rhea on 11/30/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scoreLbl: UILabel!
    
    @IBOutlet var timerLbl: UILabel!
    @IBOutlet var numberLbl: UILabel!
    @IBOutlet var textField: UITextField!
    
    var timerRunning: Bool = false
    var currSeconds: Double = 0.0
    let roundTimeLim: Double = 10.0
    let timeInterval: Double = 0.1
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        
        setNewGame()
        
    }

    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(timerRunner), userInfo: nil, repeats: true)
    }
    
    @objc func timerRunner() {
        self.currSeconds += self.timeInterval
        updateTimerLbl()
        guard(self.currSeconds <= self.roundTimeLim) else {
            stopTimer()
            return
        }
        
        
    }
    
    func stopTimer() {
        self.timer.invalidate()
        self.timerRunning = false
    }
    
    
    func updateTimerLbl() {
        self.timerLbl.text = String(self.roundTimeLim - self.currSeconds) //TODO: need to format this properly
    }
    
    func endGame() {
        //TODO: finish: create an alert for the user about score, allow them to start a new game by clicking it
        self.textField.isEnabled = false
        
    }
    
    func setNewGame() {
        self.scoreLbl.text = "0"
        self.timerLbl.text = String(self.roundTimeLim)
        self.textField.text = ""
        self.textField.isEnabled = true
        self.newRound()
        self.timerRunning = false
        
    }
    
    @IBAction func inputFieldChanged(_ sender: UITextField) {
        //timer
        if(!timerRunning) {
            timerRunning = true
            startTimer()
        }
        
        //get inputs
        guard let inputString = sender.text else { return }
        guard let numString = numberLbl.text else { return }
        guard inputString.count == 4 else { print(inputString.count)
            return }
        
        
        
        //print("escaped")
        //inputs from label
        let inputInt = Int(inputString) ?? nil //user/text field as int
        guard(inputInt != nil) else {return}
        
        let numInt = Int(numString)! //number prompted
        
        
        //find expected Int
        var expectedInt = 0
        var i = 0
        var tempNumber: Int = numInt
        while (i < numString.count) {
            let currDig = Int(tempNumber % 10)
            expectedInt += ((currDig + 1) % 10) * Int(pow(Double(10), Double(i)))
            i+=1
            tempNumber/=10
        }
        
        //print("expected: ", expectedInt)
        
        //check expected = actual input
        guard (inputInt == expectedInt) else {return }
        
        //increase score
        increaseScore(by: 1)
        
        //generate new round
        newRound()
        
    }
    
    func getScore() -> Int {
        return Int(self.scoreLbl.text!) ?? 0
    }
    
    func increaseScore(by: Int) {
        self.scoreLbl.text = String(getScore() + by)
    }
    
    func newRound() {
        print("new round")
        replaceNumRandomly()
        clearTextField()
    }
    
    func clearTextField() {
        self.textField.text = ""
    }
    
    func replaceNumRandomly() {
        replaceNum(newNum: Int.random(in: 1...9999))
    }
    
    func replaceNum(newNum: Int) {
        var newString = String(newNum)
        
        guard newString.count <= 4 else {
            print("invalid new num")
            return
        }
        
        if newString.count < 4 {
            while(newString.count < 4) {
                newString = "0" + newString
            }
        }
        
        self.numberLbl.text = newString
    }
    
}

