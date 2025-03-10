-- Checking out the basic CRUD operations

use  librarysystem;

-- 1. Books Table (CRUD)
-- Create (Insert a new book)
INSERT INTO Books (BookID, Title, Author, Genre, ISBN, CategoryID, PublisherID) 
VALUES (41, 'The Brothers Karamazov', 'Fyodor Dostoevsky', 'Philosophy', '9780140449242', 6, 3);
 
 -- Read (Retrieve all books)
 SELECT * FROM Books;

-- Update (Change book details)
UPDATE Books 
SET Genre = 'Classic Literature' 
WHERE BookID = 41;

-- Delete (Remove a book)
DELETE FROM Books WHERE BookID = 41;

 SELECT * FROM Books;
 