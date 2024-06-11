//
//  ContentView.swift
//  Calculator
//
//  Created by Hossein Zare on 6/11/24.
//

import SwiftUI
enum calButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case plusminus = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .equal , .divide:
            return .orange
        case .clear, .plusminus, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case add, subtract, multiplay, divide,  none
}

struct ContentView: View {
    
@State private var value = "0"
@State private var runNumber = 0
@State private var currentOperation: Operation = .none
    
    let buttons: [[calButton]] = [
        [.clear, .plusminus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack {
                    
                    Spacer()
                    Text(value)
                        .font(.system(size: 90))
                        .foregroundStyle(.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                            .font(.system(size: 33))
                            .frame(
            width: self.buttonwidth(item: item),
            height: self.buttonhHeight()
            )
                            .background(item.buttonColor)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                            })
                        }
                    }
                    .padding(.bottom, 5)
                }
            }
        }
    }
    
    func didTap(button: calButton) {
        switch button {
        case .add, .subtract, .multiply,  .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiplay
                self.runNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runvalue = self.runNumber
                let currentvalue = Int(self.value) ?? 0
                switch self .currentOperation {
                case .add: self.value = "\(runvalue + currentvalue)"
                case .subtract: self.value = "\(runvalue - currentvalue)"
                case .multiplay: self.value = "\(runvalue * currentvalue)"
                case .divide: self.value = "\(runvalue / currentvalue)"
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
        case .decimal, .clear, .plusminus, .percent:
            self.value = "0"
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    func buttonwidth(item: calButton) -> CGFloat {
        
        if item == .zero {
    return ((UIScreen.main.bounds.width - (4*12)) / 4 * 2)
        }
        return (UIScreen.main.bounds.width - (4*12)) / 4
    }
    
    func buttonhHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
