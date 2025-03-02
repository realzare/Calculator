//
//  ContentView.swift
//  Calculator
//
//  Created by Hossein Zare on 3/2/25.
//

import SwiftUI

enum CalculatorButton: String, Hashable {
        case one = "1", two = "2", three = "3"
        case four = "4", five = "5", six = "6"
        case seven = "7", eight = "8", nine = "9"
        case zero = "0", decimal = ".", equal = "="
        case add = "+", subtract = "-", multiply = "x", divide = "÷"
        case clear = "AC", plusminus = "+/-", percent = "%"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .equal, .divide:
            return .orange
        case .clear, .plusminus, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    @State private var displayValue = "0"
    @State private var storedNumber: Double = 0
    @State private var pendingOperation: Operation = .none
    @State private var isTypingNumber = false
    
    let buttons: [[CalculatorButton]] = [
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
                    Text(displayValue)
                        .font(.system(size: 90))
                        .foregroundColor(.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.‌‌‌ButtonPress(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 33))
                                    .frame(width: self.buttonWidth(item: item),
                                           height: self.buttonHeight())
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
    
    func ‌‌‌ButtonPress(button: CalculatorButton) {
        switch button {
        case .add, .subtract, .multiply, .divide:
            if isTypingNumber {
                performOperation()
            }
            pendingOperation = mapToOperation(button)
            isTypingNumber = false
            
        case .equal:
            performOperation()
            pendingOperation = .none
            isTypingNumber = false
            
        case .clear:
            displayValue = "0"
            storedNumber = 0
            pendingOperation = .none
            isTypingNumber = false
            
        case .decimal:
            if !displayValue.contains(".") {
                displayValue += "."
                isTypingNumber = true
            }
            
        case .plusminus:
            if let num = Double(displayValue) {
                displayValue = "\(num * -1)"
            }
            
        case .percent:
            if let num = Double(displayValue) {
                displayValue = "\(num / 100)"
            }
            
        default:
            if isTypingNumber {
                displayValue += button.rawValue
            } else {
                displayValue = button.rawValue
                isTypingNumber = true
            }
        }
    }
    
    func mapToOperation(_ button: CalculatorButton) -> Operation {
        switch button {
        case .add: return .add
        case .subtract: return .subtract
        case .multiply: return .multiply
        case .divide: return .divide
        default: return .none
        }
    }
    
    func performOperation() {
        let currentValue = Double(displayValue) ?? 0
        switch pendingOperation {
        case .add:
            storedNumber += (currentValue)
        case .subtract:
            storedNumber -= (currentValue)
        case .multiply:
            storedNumber *= (currentValue)
        case .divide:
            if currentValue != 0 {
                storedNumber /= (currentValue)
            } else {
                displayValue = "Error"
            }
        case .none:
            storedNumber = Double(currentValue)
        }
            displayValue = "\(storedNumber)"
    }

    func buttonWidth(item: CalculatorButton) -> CGFloat {
        if item == .zero {
            return (UIScreen.main.bounds.width - (4 * 12)) / 2
        }
        return (UIScreen.main.bounds.width - (4 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

