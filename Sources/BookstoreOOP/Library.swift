// Library.swift
// Manages a collection of Book objects.
// Demonstrates OOP: encapsulation, methods that operate on a collection.

class Library {

    // MARK: - Properties

    private var books: [Book] = []

    // MARK: - CRUD Operations

    /// Adds a new book. Returns false if a book with the same ID already exists.
    func addBook(_ book: Book) -> Bool {
        guard findByID(book.id) == nil else {
            print("❌ A book with ID \(book.id) already exists.")
            return false
        }
        books.append(book)
        print("✅ '\(book.title)' added successfully.")
        return true
    }

    /// Updates an existing book by ID. Returns false if not found.
    @discardableResult
    func updateBook(id: Int,
                    title: String? = nil,
                    author: String? = nil,
                    price: Double?? = nil,
                    quantity: Int?? = nil) -> Bool {
        guard let book = findByID(id) else {
            print("❌ No book found with ID \(id).")
            return false
        }
        if let t = title    { book.title    = t }
        if let a = author   { book.author   = a }
        // Double-optional lets the caller explicitly set a value to nil
        if let p = price    { book.price    = p }
        if let q = quantity { book.quantity = q }
        print("✅ Book ID \(id) updated.")
        return true
    }

    /// Deletes a book by ID. Returns false if not found.
    @discardableResult
    func deleteBook(id: Int) -> Bool {
        guard let index = books.firstIndex(where: { $0.id == id }) else {
            print("❌ No book found with ID \(id).")
            return false
        }
        let removed = books.remove(at: index)
        print("🗑️  '\(removed.title)' deleted.")
        return true
    }

    /// Displays all books in the library.
    func displayAll() {
        if books.isEmpty {
            print("📚 The library is empty.")
            return
        }
        print("\n📚 All Books (\(books.count) total):")
        books.forEach { print($0.getInfo()) }
    }

    // MARK: - Search Operations

    /// Find a single book by its ID.
    func findByID(_ id: Int) -> Book? {
        books.first { $0.id == id }
    }

    /// Find books whose title contains the given string (case-insensitive).
    func findByTitle(_ title: String) -> [Book] {
        books.filter { $0.title.lowercased().contains(title.lowercased()) }
    }

    /// Find books by author name (case-insensitive partial match).
    func findByAuthor(_ author: String) -> [Book] {
        books.filter { $0.author.lowercased().contains(author.lowercased()) }
    }

    /// Prints search results, or a "not found" message.
    func searchAndDisplay(label: String, results: [Book]) {
        if results.isEmpty {
            print("🔍 No books found for: \"\(label)\"")
        } else {
            print("🔍 Search results for \"\(label)\" (\(results.count) found):")
            results.forEach { print($0.getInfo()) }
        }
    }

    // MARK: - Inventory Summary

    /// Total copies across all books that have a quantity set.
    func totalStock() -> Int {
        books.compactMap { $0.quantity }.reduce(0, +)
    }

    // MARK: - Sales

    /// Processes a sale for multiple items and prints a formatted invoice.
    /// - Parameter items: Array of (bookID, quantity) tuples.
    func processSale(items: [(bookID: Int, quantity: Int)]) {
        print("\n🧾 Processing sale...")

        struct InvoiceLine {
            let title: String
            let qty: Int
            let unitPrice: Double
            var total: Double { Double(qty) * unitPrice }
        }

        var lines: [InvoiceLine] = []
        var errors: [String]     = []

        for item in items {
            guard let book = findByID(item.bookID) else {
                errors.append("Book ID \(item.bookID) not found.")
                continue
            }

            switch book.sell(quantity: item.quantity) {
            case .success:
                let unit = book.price ?? 0.0
                lines.append(InvoiceLine(title: book.title, qty: item.quantity, unitPrice: unit))

            case .failure(let reason):
                errors.append(reason)
            }
        }

        if !errors.isEmpty {
            print("⚠️  The following issues prevented the sale:")
            errors.forEach { print("   • \($0)") }
            if lines.isEmpty {
                print("❌ Sale cancelled — no items processed.")
                return
            }
            print("   (Proceeding with available items only)")
        }

        printInvoice(lines: lines)
    }

    // MARK: - Private helpers

    private func printInvoice(lines: [InvoiceLine]) {
        let separator = String(repeating: "─", count: 50)
        let now       = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        print("\n" + separator)
        print("          📖  BOOKSTORE INVOICE")
        print("          \(formatter.string(from: now))")
        print(separator)

        for line in lines {
            let priceStr = line.unitPrice > 0
                ? String(format: "%.1f × %d = %.1f SAR", line.unitPrice, line.qty, line.total)
                : "Price N/A"
            print(String(format: "  %-28s %s", Array(line.title.utf8), Array(priceStr.utf8)))
        }

        let grandTotal = lines.reduce(0.0) { $0 + $1.total }
        print(separator)
        print(String(format: "  TOTAL                           %.1f SAR", grandTotal))
        print(separator + "\n")
    }
}


