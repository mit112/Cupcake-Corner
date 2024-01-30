//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Mit Sheth on 1/28/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                 image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 233 )
            
            Text("Your order total is \(order.cost, format: .currency(code: "USD"))")
                .font(.title)
            
            Button("Place Order") {
                Task {
                    await placeOrder()
                }
            }
                .padding()
            
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Checout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order placed", isPresented: $showingConfirmation) {
//            Button("Ok"){}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpMethod = "POST"
        } catch {
            fatalError("No internet")
        }
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            //
            let decoder = JSONDecoder()
            let decodedOrder = try decoder.decode(Order.self, from: data)
            
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Failed to check out \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    CheckoutView(order: Order())
}
