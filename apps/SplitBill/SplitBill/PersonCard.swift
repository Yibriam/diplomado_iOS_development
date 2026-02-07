//
//  PersonCard.swift
//  SplitBill
//
//  Created by Yibriam on 06/02/26.
//

import SwiftUI

struct PersonCard: View {
    let personNumber: Int
    let total: Double
    let bill: Double
    let tip: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Person \(personNumber)")
                .font(.headline)
            
            Text("Total: $\(total, specifier: "%.2f")")
                .font(.subheadline)
            
            HStack {
                Text("Bill: $\(bill, specifier: "%.2f")")
                Spacer()
                Text("Tip: $\(tip, specifier: "%.2f")")
            }
            .font(.caption)
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    PersonCard(personNumber: 1, total: 200, bill: 200, tip: 10)
}
