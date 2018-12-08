import Cocoa

let price = NSNumber(floatLiteral: 23568.99)

let formatter = NumberFormatter()
formatter.numberStyle = .currency
formatter.currencyCode = "EUR"
formatter.currencyGroupingSeparator = "."
formatter.currencyDecimalSeparator = ","

let formattedPrice = formatter.string(from: price)
let locale = Locale.current.identifier

let spellOutFormatter = NumberFormatter()
formatter.numberStyle = .spellOut
let spelledNumber = spellOutFormatter.string(from: price)
