//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
	
    let questionBank = QuestionBank()
	var questionDisplayed = Question(text: "", correctAnswer: false)
	var pickedAnswer: Bool = false
	var progress: Int = 0
	var index : Int = Int.random(in: 0 ... 12)
	var indexArray = [Int]()
	var score : Int = 0
	
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		questionDisplayed = questionBank.list[index]
		questionLabel.text = questionDisplayed.question
		updateUI()
        
    }


    @IBAction func answerPressed(_ sender: UIButton)
	{
		if sender.tag == 1
		{
			pickedAnswer = true
			
		}
		else
		{
			pickedAnswer = false
		}
		checkAnswer()
		nextQuestion()
		if progress == 13
		{
			print("End of Quiz")
			let alert = UIAlertController(title: "Well Done", message: "Do you Want to restart", preferredStyle: .alert)
			let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
				self.startOver()
			}
			alert.addAction(restartAction)
			present(alert, animated: true, completion: nil)
			
		}
		
    }
    
    
    func updateUI() {
		scoreLabel.text = "Score: \(score)"
		progressLabel.text = "\(progress + 1) / 13"
		progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(progress + 1)
		
      
    }
    

    func nextQuestion() {
		indexArray.append(index)
		var flag : Bool = false
		progress += 1
		var check : Int = Int.random(in: 0 ... 12)
		while flag == false && (progress < 13)
		{
			flag = true
			for i in indexArray
			{
				if i == check
				{
					flag = false
				}
			}
			if flag == false
			{
				check = Int.random(in: 0 ... 12)
			}
		}
		indexArray.append(check)
		questionDisplayed = questionBank.list[check]
		questionLabel.text = questionDisplayed.question

    }
    
    
    func checkAnswer()
	{
		
		if questionDisplayed.answer == pickedAnswer
		{
			print("YAAAY")
			ProgressHUD.showSuccess("Correct")
			score += 1
		}
		else
		{
			ProgressHUD.showError("Meh...")
			print("NAAH")
		}
		updateUI()
    }
    
    
    func startOver() {
		nextQuestion()
		progress = 0
		score = 0
		indexArray.removeAll()
		updateUI()
		
    }
    

    
}
