//
//  GameScreenViewController.swift
//  rockPaperScissors
//
//  Created by Yibriam on 14/11/25.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    var playerName: String = "Player"
    
    // Mode flag
    var isPointsMode: Bool = false
    
    // Rounds mode
    var targetWins: Int = 1
    private var currentWins: Int = 0
    
    // Points mode
    var winValue: Int = 0
    var loseValue: Int = 0
    var requiredScore: Int = 0
    private var currentScore: Int = 0
    
    private var history: [String] = []
    private var totalWins: Int = 0
    private var totalLosses: Int = 0
    
    var gameView: GameScreenView {
        return view as! GameScreenView
    }
    
    override func loadView() {
        view = GameScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView.playersNameLabel.text = playerName
        updatePointsLabel()
        
        // Always add choice buttons
        gameView.rockButton.addTarget(self, action: #selector(choiceTapped(_:)), for: .touchUpInside)
        gameView.paperButton.addTarget(self, action: #selector(choiceTapped(_:)), for: .touchUpInside)
        gameView.scissorsButton.addTarget(self, action: #selector(choiceTapped(_:)), for: .touchUpInside)
        
        // Only add next turn/reset if POINTS mode
        if isPointsMode {
            gameView.nextTurnButton.addTarget(self, action: #selector(nextTurnTapped), for: .touchUpInside)
            gameView.resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        } else {
            // Hide them in rounds mode
            gameView.nextTurnButton.isHidden = true
            gameView.resetButton.isHidden = true
        }
        
        gameView.historyButton.addTarget(self, action: #selector(showHistory), for: .touchUpInside)
        
    }
    
    
    enum Choice: String, CaseIterable {
        case rock = "✊"
        case paper = "✋"
        case scissors = "✌️"
    }
    
    @objc private func choiceTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal),
              let playerChoice = Choice.allCases.first(where: { $0.rawValue == title }) else { return }
        
        let opponentChoice = Choice.allCases.randomElement()!
        
        let result: String
        let backgroundColor: UIColor
        
        switch (playerChoice, opponentChoice) {
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            totalWins += 1
            result = "\(playerName) Wins! Opponent chose \(opponentChoice.rawValue)"
            backgroundColor = .systemGreen
            if isPointsMode {
                currentScore += winValue
            } else {
                currentWins += 1
            }
        case (.rock, .paper), (.scissors, .rock), (.paper, .scissors):
            totalLosses += 1
            result = "\(playerName) Loses! Opponent chose \(opponentChoice.rawValue)"
            backgroundColor = .systemRed
            if isPointsMode {
                currentScore = max(0, currentScore - loseValue)
            }
        default:
            result = "It's a Tie! Opponent also chose \(opponentChoice.rawValue)"
            backgroundColor = .brown
        }
        
        gameView.resultLabel.text = result
        gameView.backgroundColor = backgroundColor
        updatePointsLabel()
        
        let entry = "Round \(history.count + 1): \(result) | Wins: \(totalWins) | Losses: \(totalLosses)"
        history.append(entry)
        
        
        if isPointsMode {
            // Disable buttons until next turn
            toggleButtons(false)
            gameView.nextTurnButton.isHidden = false
        }
        
        if isPointsMode {
            if currentScore >= requiredScore {
                showVictoryAlert(message: "\(playerName) reached \(requiredScore) points! 🎉")
            }
        } else {
            if currentWins >= targetWins {
                showVictoryAlert(message: "\(playerName) reached \(targetWins) wins! 🎉")
            }
        }
    }
    
    private func updatePointsLabel() {
        if isPointsMode {
            gameView.pointsLabel.text = "Points: \(currentScore)/\(requiredScore)"
        } else {
            gameView.pointsLabel.text = "Wins: \(currentWins)/\(targetWins)"
        }
    }
    
    private func toggleButtons(_ enabled: Bool) {
        gameView.rockButton.isEnabled = enabled
        gameView.paperButton.isEnabled = enabled
        gameView.scissorsButton.isEnabled = enabled
    }
    
    @objc private func nextTurnTapped() {
        toggleButtons(true)
        gameView.nextTurnButton.isHidden = true
        gameView.backgroundColor = .systemGray
        gameView.resultLabel.text = "Choose your move!"
    }
    
    @objc private func resetGame() {
        currentWins = 0
        currentScore = 0
        totalWins = 0
        totalLosses = 0
        history.removeAll()
        updatePointsLabel()
        toggleButtons(true)
        gameView.nextTurnButton.isHidden = true
        gameView.backgroundColor = .systemGray
        gameView.resultLabel.text = "Game reset. Choose your move!"
    }

    
    private func showVictoryAlert(message: String) {
        let alert = UIAlertController(title: "Victory!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        toggleButtons(false)
        gameView.nextTurnButton.isHidden = true
    }
    
    @objc private func showHistory() {
        let storyboard = UIStoryboard(name: "HistoryView", bundle: nil)
        if let historyVC = storyboard.instantiateViewController(withIdentifier: "HistoryVC") as? HistoryViewController {
            historyVC.historyEntries = history
            present(historyVC, animated: true)
            
        }
    }
    
    
}
