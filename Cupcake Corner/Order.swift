//
//  Order.swift
//  Cupcake Corner
//
//  Created by Mit Sheth on 1/28/24.
//

import Foundation

@Observable
class Order: Codable  {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestsEnabled = "specialRequestsEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    static let types = ["Chocolate", "Venilla", "Strawberry", "Rainbow"]
    var type = 0
    var quantity = 3
    
    var specialRequestsEnabled = false {
        didSet {
            if (specialRequestsEnabled == false) {
                addSprinkles = false
                extraFrosting = false
            }
        }
    }
     
    var addSprinkles = false
    var extraFrosting = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty) {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += Decimal(type)/2
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity)*0.5
        }
        return cost
    }
}
