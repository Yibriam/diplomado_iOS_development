//
//  GameScreen.swift
//  rockPaperScissors
//
//  Created by Yibriam on 14/11/25.
//

import UIKit

class GameScreenView: UIView {
    
    lazy var rockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✊", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemGray
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        return button
    }()
    
    lazy var paperButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✋", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemGray
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        return button
    }()
    
    lazy var scissorsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✌️", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemGray
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        return button
    }()
    
    lazy var playersNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Player"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Result will appear here"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "Points: 0"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextTurnButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next Turn", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        button.configuration = config
        button.isHidden = true // only visible after a round
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Game", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray
        config.baseForegroundColor = .white
        button.configuration = config
        return button
    }()
    
    lazy var historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View History", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemOrange
        config.baseForegroundColor = .white
        button.configuration = config
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        
        addSubview(playersNameLabel)
        addSubview(resultLabel)
        addSubview(pointsLabel)
        addSubview(rockButton)
        addSubview(paperButton)
        addSubview(scissorsButton)
        addSubview(nextTurnButton)
        addSubview(resetButton)
        addSubview(historyButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playersNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            playersNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: playersNameLabel.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            pointsLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            pointsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            rockButton.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 40),
            rockButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            paperButton.topAnchor.constraint(equalTo: rockButton.bottomAnchor, constant: 20),
            paperButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            scissorsButton.topAnchor.constraint(equalTo: paperButton.bottomAnchor, constant: 20),
            scissorsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nextTurnButton.topAnchor.constraint(equalTo: scissorsButton.bottomAnchor, constant: 30),
            nextTurnButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            resetButton.topAnchor.constraint(equalTo: nextTurnButton.bottomAnchor, constant: 20),
            resetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            historyButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20),
            historyButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
}

