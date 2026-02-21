//
//  FlashCard.swift
//  StudyBody
//
//  Created by Yibriam on 07/02/26.
//

import Foundation

struct FlashCard {
    let id: UUID
    var question: String
    var answer: String
    
    init(id: UUID, question: String, answer: String) {
        self.id = UUID()
        self.question = question
        self.answer = answer
    }
}

extension FlashCard {
    static let sampleCards: [FlashCard] = [
        FlashCard(
            question: "¿Qué es @State en SwiftUI?",
            answer: "Un property wrapper que permite a una vista tener estado mutable local. Cuando cambia, la vista se re-renderiza."
        ),
        FlashCard(
            question: "¿Cuál es la diferencia entre @State y @Binding?",
            answer: "@State es dueño del dato y lo almacena. @Binding es una referencia a un dato que vive en otro lugar."
        ),
        FlashCard(
            question: "¿Qué hace el modificador .environment()?",
            answer: "Pasa valores hacia abajo en la jerarquía de vistas. Todas las vistas hijas pueden acceder al valor."
        ),
        FlashCard(
            question: "¿Qué protocolo debe conformar una vista en SwiftUI?",
            answer: "El protocolo View, que requiere una propiedad body de tipo some View."
        ),
        FlashCard(
            question: "¿Cómo funciona el layout en SwiftUI?",
            answer: "El padre propone un tamaño, la vista hija decide su propio tamaño, y el padre posiciona a la vista hija."
        )
    ]
}
