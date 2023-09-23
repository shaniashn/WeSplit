//
//  View1.swift
//  WeSplit
//
//  Created by Sha Nia Siahaan on 31/08/23.
//

import SwiftUI

struct View1: View {
    @FocusState private var amountIsFocused: Bool
    
    @State var checkAmount: Double =  0.0
    @State var numberOfPeople: Int = 2
    @State var tipPercentage: Int = 10
    
   var grandTotalwTip: Double {
        let tipValue = checkAmount * (Double(tipPercentage)/100)
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelected = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipSelected/100)
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var code: String {
        if Locale.current.currency?.identifier != nil {
            return Locale.current.currency!.identifier
        }
        
        return "JPY"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: code))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) { num in
                            Text("\(num) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<100) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: code))
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                        Text(grandTotalwTip,  format: .currency(code: code))
                } header: {
                    Text("Grand total (+tip) ")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct View1_Previews: PreviewProvider {
    static var previews: some View {
        View1()
    }
}
