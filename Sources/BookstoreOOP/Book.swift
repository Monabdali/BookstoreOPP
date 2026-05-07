// Book.swift
// Represents a single book in the bookstore system.
// Demonstrates OOP: class, properties, optional properties, methods.

class Book {

    // MARK: - Properties

    var id: Int           // Required
    var title: String     // Required
    var author: String    // Required
    var price: Double?    // Optional — a book may not have a listed price
    var quantity: Int?    // Optional — a book may not be tracked in inventory

    // MARK: - Initializer

    init(id: Int, title: String, author: String, price: Double? = nil, quantity: Int? = nil) {
        self.id       = id
        self.title    = title
        self.author   = author
        self.price    = price
        self.quantity = quantity
    }

    // MARK: - Methods

    /// Returns a formatted string with all book information.
    func getInfo() -> String {
        let priceText    = price.map    { String(format: "%.1f SAR", $0) } ?? "N/A"
        let quantityText = quantity.map { "\($0) copies"                 } ?? "N/A"

        return """
        ┌─────────────────────────────────────┐
        │  ID       : \(id)
        │  Title    : \(title)
        │  Author   : \(author)
        │  Price    : \(priceText)
        │  Quantity : \(quantityText)
        └─────────────────────────────────────┘
        """
    }

    /// Attempts to sell a given quantity of this book.
    /// - Parameter qty: Number of copies to sell.
    /// - Returns: A `SellResult` indicating success or the reason for failure.
    func sell(quantity qty: Int) -> SellResult {
        guard let stock = quantity else {
            return .failure("Quantity is not tracked for '\(title)'.")
        }
        guard stock >= qty else {
            return .failure("Not enough stock for '\(title)'. Available: \(stock), requested: \(qty).")
        }
        quantity! -= qty
        return .success
    }
}

// MARK: - SellResult

enum SellResult {
    case success
    case failure(String)
}
