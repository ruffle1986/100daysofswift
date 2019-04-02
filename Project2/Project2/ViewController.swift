//
//  ViewController.swift
//  Project2
//
//  Created by Tamas Fodor on 2019. 03. 12..
//  Copyright © 2019. tfodor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  private let maxNumberOfQuestions = 10
  
  private var shouldOpenFinalPopup = false
  var countries = [String]()
  var score = 0
  var correctAnswer = 0
  var questionsAnswered = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    countries += [
      "estonia", "france", "germany", "ireland",
      "italy", "monaco", "nigeria",
      "poland", "russia", "spain", "uk", "us"
    ]
    
    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    
    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    askQuestion()
  }
  
  private func setTitle() {
    navigationItem.title = "Flag of \(getCountryName())?"
  }
  
  private func getCountryName() -> String {
    let countryToGuess = countries[correctAnswer];
    if (countryToGuess == "uk" || countryToGuess == "us") {
      return countryToGuess.uppercased()
    }
    return countries[correctAnswer].capitalized
  }
  
  private func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    
    setTitle()
  }
  
  private func showPopup(with message: String, title: String, buttonLabel: String, handler: @escaping (UIAlertAction) -> Void) {
    let ac = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    
    ac.addAction(UIAlertAction(
      title: buttonLabel,
      style: .default,
      handler: handler
    ))
    
    present(ac, animated: true)
  }
  
  private func showPopup(with message: String, title: String, buttonLabel: String) {
    let ac = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    
    ac.addAction(UIAlertAction(
      title: buttonLabel,
      style: .default
    ))
    
    present(ac, animated: true)
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    if sender.tag == correctAnswer {
      score += 1
      
      if (questionsAnswered < maxNumberOfQuestions) {
        askQuestion()
      }
      
    } else {
      score -= 1
      let message = "You're wrong! It's the flag of \(countries[sender.tag].capitalized)"
      showPopup(with: message, title: "Oops!", buttonLabel: "Continue") { action in
        self.askQuestion()
        if (self.shouldOpenFinalPopup) {
          self.showFinalPopup()
          self.shouldOpenFinalPopup = false
        }
      }
    }
    
    questionsAnswered += 1
    
    if questionsAnswered == maxNumberOfQuestions {
      if presentedViewController == nil {
        showFinalPopup()
      } else {
        shouldOpenFinalPopup = true
      }
    }
  }
  
  private func showFinalPopup() {
    showPopup(with: "Your score is: \(score)/\(maxNumberOfQuestions)", title: "Game over", buttonLabel: "Play again") { action in
      self.score = 0
      self.questionsAnswered = 0
      self.askQuestion()
    }
  }
  
  @IBAction func showScoreClicked(_ sender: UIBarButtonItem) {
    showPopup(with: "\(score)/\(maxNumberOfQuestions)", title: "Your score is", buttonLabel: "Close")
  }
  
}
