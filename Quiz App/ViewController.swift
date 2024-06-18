//
//  ViewController.swift
//  Quiz App
//
//  Created by Tomas Sanni on 6/18/24.
//

import UIKit

class ViewController: UIViewController {
    
    let bubbleBackground = UIImageView(image: .backgroundBubbles)
    let verticalStack = UIStackView()
    
    let scoreLabel = UILabel()
    let questionLabel = UILabel()
    let trueButton = UIButton()
    let falseButton = UIButton()
    let progressBar = UIProgressView(progressViewStyle: .bar)
    
    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1923559308, green: 0.2327082157, blue: 0.3624993563, alpha: 1)
        configureBackground()
        configureVerticalStack()
        configureScoreLabel()
        configureQuestionLabel()
        configureButtons()
        configureProgressBar()
        updateUI()
    }
    
    func configureBackground() {
        view.addSubview(bubbleBackground)
        bubbleBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bubbleBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bubbleBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bubbleBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func configureVerticalStack() {
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.distribution = .equalSpacing
        verticalStack.addArrangedSubview(scoreLabel)
        verticalStack.addArrangedSubview(questionLabel)
        verticalStack.addArrangedSubview(trueButton)
        verticalStack.addArrangedSubview(falseButton)
        verticalStack.addArrangedSubview(progressBar)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            verticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureScoreLabel() {
        scoreLabel.text = "Score: 0"
        scoreLabel.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureQuestionLabel() {
        questionLabel.text = "Question Text"
        questionLabel.font = UIFont.boldSystemFont(ofSize: 30)
        questionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            questionLabel.heightAnchor.constraint(equalToConstant: 620)
        ])
    }
    
    func configureButtons() {
        trueButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        trueButton.setTitle("True", for: .normal)
        trueButton.setBackgroundImage(.rectangle, for: .normal)
        
        falseButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        falseButton.setTitle("False", for: .normal)
        falseButton.setBackgroundImage(.rectangle, for: .normal)
        
        NSLayoutConstraint.activate([
            trueButton.heightAnchor.constraint(equalToConstant: 80),
            falseButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureProgressBar() {
        progressBar.setProgress(0.5, animated: false)
        progressBar.progressTintColor = #colorLiteral(red: 1, green: 0.4585417509, blue: 0.6605013609, alpha: 1)
    }
    
    
    @objc func handleButton(button: UIButton) {
        
        let userAnswer = button.currentTitle! //True, False
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        
        if userGotItRight
        {
            print("Right!")
            button.backgroundColor = UIColor.green
        }
        else
        {
            print("Wrong!")
            button.backgroundColor = UIColor.red
        }
        
       
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
        
    }
    

    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.setProgress(quizBrain.getProgress(), animated: true)
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
    }

}


#Preview {
    ViewController()
}
