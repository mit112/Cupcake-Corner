//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Mit Sheth on 1/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cupcake" , selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0] )
                        }
                    }
                    
                    Stepper("Number of cupcakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestsEnabled.animation())
                    
                    if order.specialRequestsEnabled == true {
                        Toggle("Extra Frosting", isOn: $order.extraFrosting.animation())
                        Toggle("Add Sprinkles", isOn: $order.addSprinkles.animation())
                    }
                }
                Section {
                    NavigationLink("Add your address", destination: AddressView(order: order))
                }
            }
            .navigationTitle("Cupcake Corner")
            
        }
    }
}

#Preview {
    ContentView()
}
