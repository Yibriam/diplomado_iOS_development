//
//  FlashcardStore.swift
//  StudyBody
//
//  Created by Yibriam on 07/02/26.
//

import SwiftUI

class FlashcardStore {
    var cards: [FlashCard]
    var currentIndex: Int = 0
    
    init(cards: [FlashCard], currentIndez: Int) {
        self.cards = cards
    }
    
    var currentCard: FlashCard? {
        guard currentIndex >= 0 && currentIndex < cards.count else {
            return nil
        }
        
        return cards[currentIndex]
    }
    
    var hasNextCard: Bool {
        currentIndex < cards.count - 1
    }
    
    
    func nextCard() {
        if hasNextCard {
            currentIndex += 1
        }
    }
    
    func addCard(_ card: FlashCard) {
        cards.append(card)
    }
    
    func deleteCard(at index: Int) {
        guard index >= 0, index < cards.count else { return }
        cards.remove(at: index)
        
        if currentIndex >= cards.count {
            currentIndex = max(0, cards.count - 1)
        }
    }
    
}
