import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @State private var tipPercentages = [10, 15, 20, 25, 0]
    
    @FocusState private var amountIsFocused: Bool


    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var currentCurrency: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency (code: currentCurrency))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Text(
                        totalPerPerson,
                        format: .currency(code: currentCurrency)
                    )
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalAmount,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total amount")
                        .foregroundColor(tipPercentage == 0 ? Color.red : Color.black)
                }
                
                Section {
                    Picker("Tip percentage",
                           selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
