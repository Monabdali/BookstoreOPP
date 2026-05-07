Bookstore Management System — Swift OOP

A command-line bookstore application written in **Swift**, built to demonstrate **Object-Oriented Programming (OOP)** principles.
 
يهدف المشروع إلى تطبيق مفاهيم البرمجة الشيئية أو الكائنية باستخدام لغة سويفت

ملاحظة: حتى يعمل البرنامج يجب إتباع البناء المذكور أدناه
---

Project Structure

```
BookstoreOOP/
├── Package.swift                        ← Swift Package Manager config
└── Sources/
    └── BookstoreOOP/
        ├── Book.swift                   ← Book class + SellResult enum
        ├── Library.swift                ← Library class (manages books)
        └── main.swift                   ← Entry point / demo
```

---

OOP Design

### `Book` class

| Property   | Type      | Required? |
|------------|-----------|-----------|
| `id`       | `Int`     | ✅ Required |
| `title`    | `String`  | ✅ Required |
| `author`   | `String`  | ✅ Required |
| `price`    | `Double?` | ⭕ Optional |
| `quantity` | `Int?`    | ⭕ Optional |

**Methods:**
- `getInfo() -> String` — returns formatted book details
- `sell(quantity:) -> SellResult` — validates and processes a sale

### `Library` class

Manages a private collection of `Book` objects with:

- **CRUD:** `addBook`, `updateBook`, `deleteBook`, `displayAll`
- **Search:** `findByID`, `findByTitle`, `findByAuthor`
- **Sales:** `processSale(items:)` — handles multiple books, validates stock, prints an invoice

---

How to Run

### Option 1 — GitHub Codespaces (no Mac needed)
1. Click **Code → Codespaces → Create codespace on main**
2. In the terminal:
   ```bash
   swift run
   ```

### Option 2 — Replit
1. Create a new **Swift** Repl on [replit.com](https://replit.com)
2. Upload or paste the source files
3. Click **Run**

### Option 3 — Windows / Linux (Swift installed locally)
```bash
git clone https://github.com/YOUR_USERNAME/BookstoreOOP.git
cd BookstoreOOP
swift run
```

---

Initial Book Data

| ID | Title | Author | Price | Qty |
|----|-------|--------|-------|-----|
| 1 | Start with Why | Simon Sinek | 80.0 | 13 |
| 2 | But How Do It Know | J. Clark Scott | 59.9 | 22 |
| 3 | Clean Code | Robert Cecil Martin | 50.0 | 5 |
| 4 | Zero to One | Peter Thiel | 45.0 | 12 |
| 5 | You Don't Know JS | Kyle Simpson | 39.9 | 9 |

---

Features Demonstrated

- ✅ Add, update, delete, and display books
- ✅ Optional properties (`price?`, `quantity?`) using Swift `Optional`
- ✅ Search by ID, title, or author
- ✅ Sell one or more books with stock validation
- ✅ Auto-generated invoice with totals
- ✅ Graceful error handling for invalid operations
