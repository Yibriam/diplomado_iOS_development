//
//  Examples.swift
//  swiftui-introduction-diplomado
//
//  Created by Alejandro Mendoza on 31/01/26.
//

import SwiftUI

extension View {
    func debugType() -> Self {
        let type = Mirror(reflecting: self).subjectType
        print(type)
        return self
    }
}


//struct Example: View {
//    var body: some View {
//        Text("I'm a text")
//            .foregroundStyle(.white)
//            .padding()
//            .background {
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(Color.blue)
//            }
//            .debugType()
//    }
//}

//#Preview {
//    Example()
//}


//struct UnderlineView<Content: View>: View {
//    var content: Content
//    var body: some View {
//        content
//            .overlay(alignment: .bottom) {
//                Rectangle()
//                    .frame(height: 1)
//            }
//    }
//}
//
//struct UnderlineViewModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .overlay(alignment: .bottom) {
//                Rectangle()
//                    .frame(height: 1)
//            }
//    }
//}
//
//struct Example: View {
//    var body: some View {
//        VStack {
//            UnderlineView(content: Text("Hello, world!"))
//            Text("Hello, world")
//                .modifier(UnderlineViewModifier())
//            Text("Hello, world")
//                .underline()
//        }
//    }
//}
//
//extension View {
//    func underline() -> some View {
//        modifier(UnderlineViewModifier())
//    }
//}
//
//
//#Preview {
//    Example()
//}


//struct Example: View {
//    let counter = 0
//    let optionalCounter: Int? = .none
//    
//    var body: some View {
//        // ViewBuilder
//        VStack {
//            switch counter > 0 {
//            case true:
//                Circle()
//            case false:
//                Rectangle()
//            }
//            
//            if let counter = optionalCounter {
//                Text("\(counter)")
//            }
//            
//            Button(action: {}) {
//                Text("Hi")
//            }
//        }
//        .debugType()
//    }
//}
//
//#Preview {
//    Example()
//}

// MARK: - Layout


//struct Example: View {
//    var body: some View {
//        Text("Favorite")
//            .background {
//                GeometryReader { geometry in
//                    Color.clear
//                        .onAppear {
//                            print(geometry.size)
//                        }
//                }
//            }
//            .frame(width: 30)
//            .frame(width: 200, height: 200)
//            .border(Color.black)
//    }
//}

//struct Example: View {
//    var body: some View {
//        HStack(spacing: 10) {
//            RoundedRectangle(cornerRadius: 8)
//                .foregroundStyle(Color.blue)
//            Text("A simple test")
//                .layoutPriority(3)
//            RoundedRectangle(cornerRadius: 8)
//                .foregroundStyle(Color.green)
//        }
//        .frame(width: 200, height: 200)
//    }
//}
//
//#Preview {
//    Example()
//}

// ObservableObject

//@Observable
//class MyModel {
////    @Published var counter: Int = 0
//    var counter: Int = 0
//}

//struct Examples: View {
////    @State private var counter: Int = 0
////    @State var model = MyModel()
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//
//            }) {
//                Text("\(model.counter)")
//                    .font(.largeTitle)
//            }
//            
//            if model.counter.isMultiple(of: 2) {
//                Text("Even")
//            }
//        }
//    }
//}

// Binding
struct CounterView: View {
    @State private var tapCount = 1
    
    @State private var toggleBoolean: Bool = true
    @State private var textFieldString: String = ""
    
    var body: some View {
        VStack {
            Text(textFieldString)
            Text("toggle value \(toggleBoolean ? "on" : "off")")
            
            if tapCount > 0 {
                Text("tapped \(tapCount) times")
            }
            
            Toggle(isOn: $toggleBoolean) {
                Text("test toggle")
            }
            
            TextField("test", text: $textFieldString)
            
//            TapMeView(setTapCount: { tapCount += 1 },
//                      getTapCount: { tapCount })
            
            TapMeView(counter: $tapCount)
            TapMeView2(counter: $tapCount)
        }
    }
}

struct TapMeView: View {
//    //settet
//    let setTapCount: () -> Void
//    //getter
//    let getTapCount: () -> Int
    
    @Binding var counter: Int
    
    var body: some View {
        Button("tap me - currently at: \(counter)") {
            counter = counter + 1
        }
    }
}

struct TapMeView2: View {
    @Binding var counter: Int
    
    var body: some View {
        Button("tap mem 2 - currently at: \(counter)") {
            counter = counter + 2
        }
    }
}

#Preview {
    CounterView()
}
