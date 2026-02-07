//
//  ContentView.swift
//  SplitBill
//
//  Created by Yibriam on 06/02/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var textFieldData = ""
    @State private var selectedTip = 10
    @State private var people = 1
    
    let tips = [0, 10, 15, 20]
    
    var billAmount: Double {
        Double(textFieldData) ?? 0.0
    }
    
    var tipAmount: Double {
        billAmount * Double(selectedTip) / 100
    }
    
    var totalWithTip: Double {
        billAmount + tipAmount
    }
    
    var perPersonTotal: Double {
        people > 0 ? totalWithTip / Double(people) : 0.0
    }
    
    var perPersonBill: Double {
        people > 0 ? billAmount / Double(people) : 0.0
    }
    
    var perPersonTip: Double {
        people > 0 ? tipAmount / Double(people) : 0.0
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    TextField("Enter bill total", text: $textFieldData)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    Picker("Tip Percentage", selection: $selectedTip) {
                        ForEach(tips, id: \.self) { tip in
                            Text("\(tip)%")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    Stepper("Number of People: \(people)", value: $people, in: 1...10)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        ForEach(0..<people, id: \.self) { index in
                            PersonCard(
                                personNumber: index + 1,
                                total: perPersonTotal,
                                bill: perPersonBill,
                                tip: perPersonTip
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Split Bill")
            }
        }
    }
}

#Preview {
    ContentView()
}
