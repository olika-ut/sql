PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS loan_items;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS book_authors;
DROP TABLE IF EXISTS patrons;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    birth_date DATE,
    nationality TEXT
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    isbn TEXT UNIQUE NOT NULL,
    publication_year INTEGER,
    genre TEXT,
    total_copies INTEGER NOT NULL,
    available_copies INTEGER NOT NULL
);

CREATE TABLE book_authors (
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

CREATE TABLE patrons (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    address TEXT,
    membership_date DATE
);

CREATE TABLE loans (
    id INTEGER PRIMARY KEY,
    patron_id INTEGER NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status TEXT NOT NULL,
    FOREIGN KEY (patron_id) REFERENCES patrons(id)
);

CREATE TABLE loan_items (
    loan_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    PRIMARY KEY (loan_id, book_id),
    FOREIGN KEY (loan_id) REFERENCES loans(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO authors (id, first_name, last_name, birth_date, nationality) VALUES
(1, 'George', 'Orwell', '1903-06-25', 'British'),
(2, 'Jane', 'Austen', '1775-12-16', 'British'),
(3, 'Mark', 'Twain', '1835-11-30', 'American'),
(4, 'J.K.', 'Rowling', '1965-07-31', 'British'),
(5, 'Harper', 'Lee', '1926-04-28', 'American'),
(6, 'F. Scott', 'Fitzgerald', '1896-09-24', 'American'),
(7, 'J.R.R.', 'Tolkien', '1892-01-03', 'British'),
(8, 'Mary', 'Shelley', '1797-08-30', 'British'),
(9, 'Antoine', 'de Saint-Exupéry', '1900-06-29', 'French'),
(10, 'Paulo', 'Coelho', '1947-08-24', 'Brazilian'),
(11, 'J.D.', 'Salinger', '1919-01-01', 'American'),
(12, 'Aldous', 'Huxley', '1894-07-26', 'British'),
(13, 'Herman', 'Melville', '1819-08-01', 'American'),
(14, 'Leo', 'Tolstoy', '1828-09-09', 'Russian'),
(15, 'Fyodor', 'Dostoevsky', '1821-11-11', 'Russian'),
(16, 'Markus', 'Zusak', '1975-06-23', 'Australian'),
(17, 'C.S.', 'Lewis', '1898-11-29', 'British'),
(18, 'Dan', 'Brown', '1964-06-22', 'American');

INSERT INTO books (id, title, isbn, publication_year, genre, total_copies, available_copies) VALUES
(1, '1984', '9780451524935', 1949, 'Dystopian', 4, 2),
(2, 'Pride and Prejudice', '9780141439518', 1813, 'Romance', 3, 2),
(3, 'Adventures of Huckleberry Finn', '9780486280615', 1884, 'Adventure', 5, 4),
(4, 'Harry Potter and the Philosopher''s Stone', '9780747532699', 1997, 'Fantasy', 6, 4),
(5, 'To Kill a Mockingbird', '9780061120084', 1960, 'Fiction', 4, 3),
(6, 'The Great Gatsby', '9780743273565', 1925, 'Classic', 5, 4),
(7, 'The Hobbit', '9780547928227', 1937, 'Fantasy', 6, 5),
(8, 'Frankenstein', '9780486282114', 1818, 'Gothic Fiction', 3, 2),
(9, 'The Little Prince', '9780156012195', 1943, 'Novella', 4, 3),
(10, 'The Alchemist', '9780061122415', 1988, 'Adventure Fiction', 5, 4),
(11, 'The Catcher in the Rye', '9780316769488', 1951, 'Fiction', 4, 4),
(12, 'Brave New World', '9780060850524', 1932, 'Dystopian', 5, 5),
(13, 'The Lord of the Rings', '9780618640157', 1954, 'Fantasy', 7, 7),
(14, 'Animal Farm', '9780451526342', 1945, 'Political Satire', 4, 4),
(15, 'Moby-Dick', '9781503280786', 1851, 'Adventure', 3, 3),
(16, 'War and Peace', '9780199232765', 1869, 'Historical Fiction', 6, 6),
(17, 'Crime and Punishment', '9780140449136', 1866, 'Philosophical Fiction', 5, 5),
(18, 'The Book Thief', '9780375842207', 2005, 'Historical Fiction', 5, 5),
(19, 'The Chronicles of Narnia', '9780066238500', 1956, 'Fantasy', 6, 6),
(20, 'The Da Vinci Code', '9780307474278', 2003, 'Thriller', 5, 5);

INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 7),
(14, 1),
(15, 13),
(16, 14),
(17, 15),
(18, 16),
(19, 17),
(20, 18);

INSERT INTO patrons (id, first_name, last_name, email, phone, address, membership_date) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-1001', '12 Oak Street', '2022-01-15'),
(2, 'Bob', 'Smith', 'bob.smith@example.com', '555-1002', '34 Pine Avenue', '2019-02-10'),
(3, 'Clara', 'Davis', 'clara.davis@example.com', '555-1003', '56 Maple Road', '2025-03-05'),
(4, 'Daniel', 'Brown', 'daniel.brown@example.com', '555-1004', '78 Birch Lane', '2024-04-12'),
(5, 'Eva', 'Wilson', 'eva.wilson@example.com', '555-1005', '90 Cedar Court', '2024-05-20'),
(6, 'Liam', 'Miller', 'liam.miller@example.com', '555-1006', '11 Elm Street', '2023-06-01'),
(7, 'Olivia', 'Taylor', 'olivia.taylor@example.com', '555-1007', '22 Willow Avenue', '2018-06-15'),
(8, 'Noah', 'Anderson', 'noah.anderson@example.com', '555-1008', '33 Spruce Road', '2016-07-01'),
(9, 'Emma', 'Thomas', 'emma.thomas@example.com', '555-1009', '44 Aspen Lane', '2024-07-10'),
(10, 'William', 'Jackson', 'william.jackson@example.com', '555-1010', '55 Cherry Street', '2025-07-20');

INSERT INTO loans (id, patron_id, loan_date, due_date, return_date, status) VALUES
(1, 1,  '2026-02-01', '2026-02-15', '2026-02-14', 'Returned'),
(2, 2,  '2026-02-05', '2026-02-19', '2026-02-18', 'Returned'),
(3, 3,  '2026-02-10', '2026-02-24', '2026-02-23', 'Returned'),
(4, 4,  '2026-02-15', '2026-03-01', NULL,          'Overdue'),
(5, 5,  '2026-02-18', '2026-03-04', NULL,          'Overdue'),
(6, 6,  '2026-03-01', '2026-03-15', NULL,          'Overdue'),
(7, 7,  '2026-03-10', '2026-03-24', NULL,          'Overdue'),
(8, 8,  '2026-03-15', '2026-04-05', NULL,          'Active'),
(9, 9,  '2026-03-20', '2026-04-10', NULL,          'Active'),
(10, 10, '2026-03-22', '2026-04-12', NULL,          'Active');

INSERT INTO loan_items (loan_id, book_id) VALUES
(1, 1),
(2, 4),
(3, 2),
(4, 5),
(5, 3),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

SELECT * FROM books;

--QUERYING THE DATABASE--

-- Query 1: List of all books authored by a specified individual--

SELECT b.title, b.publication_year, b.genre
FROM books b
JOIN book_authors ba ON b.id = ba.book_id
JOIN authors a ON ba.author_id = a.id
WHERE a.first_name = 'George' AND a.last_name = 'Orwell';

-- Query 2: Identify all patrons who have overdue book loans.--

SELECT p.first_name, p.last_name, p.email, l.id AS loan_id, l.due_date
FROM patrons p
JOIN loans l ON p.id = l.patron_id
WHERE l.due_date < DATE('now')
  AND l.return_date IS NULL;
  
-- Query 3: Enumerate books that have not ever been borrowed.--

SELECT b.title, b.isbn
FROM books b
LEFT JOIN loan_items li ON b.id = li.book_id
WHERE li.book_id IS NULL;




  
