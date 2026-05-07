let library = Library()

print("═══════════════════════════════════════════")
print("      📚  BOOKSTORE MANAGEMENT SYSTEM")
print("═══════════════════════════════════════════\n")

print("── Adding initial books ──")
library.addBook(Book(id: 1, title: "Start with Why",       author: "Simon Sinek",        price: 80.0, quantity: 13))
library.addBook(Book(id: 2, title: "But How Do It Know",   author: "J. Clark Scott",     price: 59.9, quantity: 22))
library.addBook(Book(id: 3, title: "Clean Code",           author: "Robert Cecil Martin",price: 50.0, quantity: 5))
library.addBook(Book(id: 4, title: "Zero to One",          author: "Peter Thiel",        price: 45.0, quantity: 12))
library.addBook(Book(id: 5, title: "You Don't Know JS",    author: "Kyle Simpson",       price: 39.9, quantity: 9))

// ──────────────────────────────────────────────
// 2. Display all books
// ──────────────────────────────────────────────

library.displayAll()
print("Total stock across all books: \(library.totalStock()) copies\n")

// ──────────────────────────────────────────────
// 3. Add a new book (with optional fields)
// ──────────────────────────────────────────────

print("── Adding a book without price or quantity (optional fields) ──")
library.addBook(Book(id: 6, title: "The Pragmatic Programmer", author: "David Thomas"))

// Attempt to add a duplicate
print("\n── Attempting to add duplicate ID ──")
library.addBook(Book(id: 1, title: "Duplicate", author: "Someone"))

// ──────────────────────────────────────────────
// 4. Update a book
// ──────────────────────────────────────────────

print("\n── Updating book ID 6 with price and quantity ──")
library.updateBook(id: 6, price: 65.0, quantity: 8)
if let book = library.findByID(6) { print(book.getInfo()) }

// ──────────────────────────────────────────────
// 5. Search operations
// ──────────────────────────────────────────────

print("\n── Search by ID (3) ──")
if let found = library.findByID(3) {
    print(found.getInfo())
} else {
    print("Not found.")
}

print("\n── Search by title: \"know\" ──")
library.searchAndDisplay(label: "know", results: library.findByTitle("know"))

print("\n── Search by author: \"martin\" ──")
library.searchAndDisplay(label: "martin", results: library.findByAuthor("martin"))

print("\n── Search with no match: \"Dune\" ──")
library.searchAndDisplay(label: "Dune", results: library.findByTitle("Dune"))

// ──────────────────────────────────────────────
// 6. Process a valid sale (multiple books)
// ──────────────────────────────────────────────

print("── Sale: 2× Clean Code, 3× Zero to One ──")
library.processSale(items: [
    (bookID: 3, quantity: 2),
    (bookID: 4, quantity: 3)
])

print("Updated stock — book 3: \(library.findByID(3)?.quantity ?? 0), book 4: \(library.findByID(4)?.quantity ?? 0)")

// ──────────────────────────────────────────────
// 7. Attempt a sale that exceeds stock
// ──────────────────────────────────────────────

print("\n── Attempting to sell 100 copies of Clean Code (only 3 left) ──")
library.processSale(items: [(bookID: 3, quantity: 100)])

// ──────────────────────────────────────────────
// 8. Delete a book
// ──────────────────────────────────────────────

print("── Deleting book ID 2 ──")
library.deleteBook(id: 2)
library.deleteBook(id: 99) // Non-existent

// ──────────────────────────────────────────────
// 9. Final state
// ──────────────────────────────────────────────

library.displayAll()
print("Final total stock: \(library.totalStock()) copies")
print("\n═══════════════════════════════════════════\n")
