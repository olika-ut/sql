---
title: Library Database

---

# Library Database

## Practical Application of Database Design Principles
#### HW2 Olga Khodyreva (Narva group)

Brief explanation of the expected output for each query.
Objective: Design, implement, and query a straightforward database system.

## Deliverables

| File | Description |
|------|-------------|
| `library_er_diagram.pdf` | entity-relationship (ER) diagram to represent the library system |
| `library.sql` | full SQL script — schema creation, sample data, and queries |

---

## Database Schema

The database consists of 6 tables:

- **authors** — stores author information
- **books** — stores book details including available copies
- **book_authors** — junction table resolving the many-to-many relationship between books and authors
- **patrons** — stores library member information
- **loans** — stores each loan transaction with dates and status
- **loan_items** — junction table linking loans to books (one loan can include multiple books)

> **Note:** All sample data is included directly in `library.sql` as `INSERT` statements. 
> In a larger project, data could alternatively be stored in separate CSV files (one per table) and imported into the database.
> 


---

## SQL Queries

### Query 1: List all books by a specific author

```sql
SELECT b.title, b.publication_year, b.genre
FROM books b
JOIN book_authors ba ON b.id = ba.book_id
JOIN authors a ON ba.author_id = a.id
WHERE a.first_name = 'George' AND a.last_name = 'Orwell';
```

**Explanation:**
This query joins `books` → `book_authors` → `authors` to resolve the many-to-many relationship between books and authors. It filters by the author's first and last name and returns all books they wrote.

**Expected Output:**

| title | publication_year | genre |
|-------|-----------------|-------|
| 1984 | 1949 | Dystopian |
| Animal Farm | 1945 | Political Satire |

> To search for a different author, replace the name values in the `WHERE` clause.

---

### Query 2: Identify all patrons with overdue loans

```sql
SELECT p.first_name, p.last_name, p.email, l.id AS loan_id, l.due_date
FROM patrons p
JOIN loans l ON p.id = l.patron_id
WHERE l.due_date < DATE('now')
  AND l.return_date IS NULL;
```

**Explanation:**
This query finds all patrons who have not returned a book (`return_date IS NULL`) and whose due date has already passed. `DATE('now')` automatically uses today's date every time the query runs, so it never needs to be manually updated.

**Expected Output** (based on sample data, today = 2026-03-26):

| first_name | last_name | email | loan_id | due_date |
|------------|-----------|-------|---------|----------|
| Daniel | Brown | daniel.brown@example.com | 4 | 2026-03-01 |
| Eva | Wilson | eva.wilson@example.com | 5 | 2026-03-04 |
| Liam | Miller | liam.miller@example.com | 6 | 2026-03-15 |
| Olivia | Taylor | olivia.taylor@example.com | 7 | 2026-03-24 |

---

### Query 3: Find books that have never been borrowed

```sql
SELECT b.title, b.isbn
FROM books b
LEFT JOIN loan_items li ON b.id = li.book_id
WHERE li.book_id IS NULL;
```

**Explanation:**
This query uses a `LEFT JOIN` between `books` and `loan_items`, which keeps all books regardless of whether they have ever been loaned. The `WHERE li.book_id IS NULL` condition then filters down to only books that have no matching record in `loan_items` — meaning they have never been borrowed.

**Expected Output** (shows title and ISBN of every book)

| title | isbn |
|-------|------|
| The Catcher in the Rye | 9780316769488 |
| Brave New World | 9780060850524 |
| The Lord of the Rings | 9780618640157 |
| Animal Farm | 9780451526342 |
| Moby-Dick | 9781503280786 |
| War and Peace | 9780199232765 |
| Crime and Punishment | 9780140449136 |
| The Book Thief | 9780375842207 |
| The Chronicles of Narnia | 9780066238500 |
| The Da Vinci Code | 9780307474278 |