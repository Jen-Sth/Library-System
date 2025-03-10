-- This query file is created in MySQl and under localhost and user= root.Note: the same host name and user is used in frontend_ui and the password as per the password set in the localinstance

CREATE DATABASE IF NOT EXISTS LibrarySystem;
USE LibrarySystem;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) UNIQUE
);
CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(255),
    Contact VARCHAR(100)
);
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Genre VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE,
    CategoryID INT,
    PublisherID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(255),
    Contact VARCHAR(50),
    MembershipDate DATE
);
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    IssueDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
CREATE TABLE Fines (
    FineID INT PRIMARY KEY,
    LoanID INT,
    FineAmount DECIMAL(10,2),
    PaidStatus BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    ReservationDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
CREATE TABLE Librarians (
    LibrarianID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Password VARCHAR(255)
);

-- The relational schema are created
-- Inserting the values in the relations:

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Fiction'),
(2, 'Science'),
(3, 'History'),
(4, 'Technology'),
(5, 'Mathematics'),
(6, 'Philosophy'),
(7, 'Business'),
(8, 'Biography'),
(9, 'Psychology'),
(10, 'Politics'),
(11, 'Health'),
(12, 'Self-help'),
(13, 'Education'),
(14, 'Sports'),
(15, 'Cooking'),
(16, 'Travel'),
(17, 'Fantasy'),
(18, 'Mystery'),
(19, 'Thriller'),
(20, 'Poetry');

INSERT INTO Publishers (PublisherID, PublisherName, Contact) VALUES
(1, 'Penguin Books', 'info@penguin.com'),
(2, 'HarperCollins', 'contact@harpercollins.com'),
(3, 'Macmillan', 'support@macmillan.com'),
(4, 'Pearson', 'help@pearson.com'),
(5, 'OReilly Media', 'info@oreilly.com'),
(6, 'Hachette', 'service@hachette.com'),
(7, 'Simon & Schuster', 'support@simon.com'),
(8, 'Bloomsbury', 'contact@bloomsbury.com'),
(9, 'Springer', 'help@springer.com'),
(10, 'MIT Press', 'service@mitpress.com'),
(11, 'Oxford University Press', 'support@oup.com'),
(12, 'Cambridge University Press', 'help@cup.com'),
(13, 'Wiley', 'contact@wiley.com'),
(14, 'McGraw Hill', 'info@mcgrawhill.com'),
(15, 'Routledge', 'help@routledge.com'),
(16, 'Vintage Books', 'service@vintage.com'),
(17, 'Scholastic', 'support@scholastic.com'),
(18, 'Random House', 'contact@randomhouse.com'),
(19, 'Doubleday', 'info@doubleday.com'),
(20, 'Tor Books', 'service@tor.com');

INSERT INTO Books (BookID, Title, Author, Genre, ISBN, CategoryID, PublisherID) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', '9780743273565', 1, 1),
(2, 'A Brief History of Time', 'Stephen Hawking', 'Science', '9780553380163', 2, 2),
(3, 'Sapiens', 'Yuval Noah Harari', 'History', '9780062316097', 3, 3),
(4, 'Clean Code', 'Robert C. Martin', 'Technology', '9780132350884', 4, 4),
(5, 'The Art of War', 'Sun Tzu', 'Philosophy', '9781590302255', 6, 5),
(6, 'The Lean Startup', 'Eric Ries', 'Business', '9780307887894', 7, 6),
(7, 'Steve Jobs', 'Walter Isaacson', 'Biography', '9781451648539', 8, 7),
(8, 'Thinking, Fast and Slow', 'Daniel Kahneman', 'Psychology', '9780374533557', 9, 8),
(9, '1984', 'George Orwell', 'Politics', '9780451524935', 10, 9),
(10, 'The Power of Habit', 'Charles Duhigg', 'Self-help', '9780812981605', 12, 10),
(11, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', '9780316769488', 1, 11),
(12, 'The Alchemist', 'Paulo Coelho', 'Fiction', '9780062315007', 1, 12),
(13, 'Atomic Habits', 'James Clear', 'Self-help', '9780735211292', 12, 13),
(14, 'Cosmos', 'Carl Sagan', 'Science', '9780345331359', 2, 14),
(15, 'Introduction to Algorithms', 'Thomas H. Cormen', 'Technology', '9780262033848', 4, 15),
(16, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Business', '9781612680194', 7, 16),
(17, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', '9780547928227', 17, 17),
(18, 'Sherlock Holmes', 'Arthur Conan Doyle', 'Mystery', '9780553212419', 18, 18),
(19, 'Gone Girl', 'Gillian Flynn', 'Thriller', '9780307588371', 19, 19),
(20, 'Milk and Honey', 'Rupi Kaur', 'Poetry', '9781449474256', 20, 20),
(21, 'Dune', 'Frank Herbert', 'Science Fiction', '9780441013593', 17, 1),
(22, 'The Name of the Wind', 'Patrick Rothfuss', 'Fantasy', '9780756404741', 17, 2),
(23, 'The Road', 'Cormac McCarthy', 'Post-Apocalyptic', '9780307387899', 1, 3),
(24, 'Brave New World', 'Aldous Huxley', 'Dystopian', '9780060850524', 10, 4),
(25, 'The Subtle Art of Not Giving a F*ck', 'Mark Manson', 'Self-help', '9780062457714', 12, 5),
(26, 'The Intelligent Investor', 'Benjamin Graham', 'Business', '9780060555665', 7, 6),
(27, 'Crime and Punishment', 'Fyodor Dostoevsky', 'Philosophy', '9780486415871', 6, 7),
(28, 'Meditations', 'Marcus Aurelius', 'Philosophy', '9780140449334', 6, 8),
(29, 'A Short History of Nearly Everything', 'Bill Bryson', 'Science', '9780767908184', 2, 9),
(30, 'The 4-Hour Workweek', 'Timothy Ferriss', 'Business', '9780307465351', 7, 10),
(31, 'Educated', 'Tara Westover', 'Biography', '9780399590504', 8, 11),
(32, 'The Book Thief', 'Markus Zusak', 'Historical Fiction', '9780375842207', 1, 12),
(33, 'The Silent Patient', 'Alex Michaelides', 'Thriller', '9781250301697', 19, 13),
(34, 'Deep Work', 'Cal Newport', 'Self-help', '9781455586692', 12, 14),
(35, 'Principles', 'Ray Dalio', 'Business', '9781501124020', 7, 15),
(36, 'A Man Called Ove', 'Fredrik Backman', 'Fiction', '9781476738024', 1, 16),
(37, 'Atomic Physics', 'Max Born', 'Science', '9780486609395', 2, 17),
(38, 'Inferno', 'Dan Brown', 'Mystery', '9781400079155', 18, 18),
(39, 'The Night Circus', 'Erin Morgenstern', 'Fantasy', '9780385534635', 17, 19),
(40, 'Leaves of Grass', 'Walt Whitman', 'Poetry', '9780486414104', 20, 20);

INSERT INTO Librarians (LibrarianID, Name, Email, Password) VALUES
(1, 'Emma Brown', 'emma@example.com', 'libpass123'),
(2, 'Noah Wilson', 'noah@example.com', 'securepass456'),
(3, 'Sophia Lee', 'sophia@example.com', 'adminlib789'),
(4, 'Liam Martinez', 'liam@example.com', 'passlib321'),
(5, 'Ava Rodriguez', 'ava@example.com', 'libsecure654');

INSERT INTO Members (MemberID, Name, Contact, MembershipDate) VALUES
(1, 'John Doe', 'john.doe@example.com', '2024-01-10'),
(2, 'Jane Smith', 'jane.smith@example.com', '2024-02-15'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '2024-03-20'),
(4, 'Michael Brown', 'michael.brown@example.com', '2024-04-05'),
(5, 'Emily Davis', 'emily.davis@example.com', '2024-05-12'),
(6, 'Robert Wilson', 'robert.wilson@example.com', '2024-06-18'),
(7, 'Sarah Martinez', 'sarah.martinez@example.com', '2024-07-22'),
(8, 'David Taylor', 'david.taylor@example.com', '2024-08-30'),
(9, 'Jessica Anderson', 'jessica.anderson@example.com', '2024-09-15'),
(10, 'Daniel Thomas', 'daniel.thomas@example.com', '2024-10-10'),
(11, 'Sophia White', 'sophia.white@example.com', '2024-11-05'),
(12, 'James Harris', 'james.harris@example.com', '2024-12-20'),
(13, 'Olivia Martin', 'olivia.martin@example.com', '2024-01-25'),
(14, 'Benjamin Clark', 'benjamin.clark@example.com', '2024-02-28'),
(15, 'Isabella Lewis', 'isabella.lewis@example.com', '2024-03-15'),
(16, 'Matthew Young', 'matthew.young@example.com', '2024-04-18'),
(17, 'Ava King', 'ava.king@example.com', '2024-05-21'),
(18, 'William Hall', 'william.hall@example.com', '2024-06-30'),
(19, 'Mia Allen', 'mia.allen@example.com', '2024-07-10'),
(20, 'Ethan Scott', 'ethan.scott@example.com', '2024-08-05');

INSERT INTO Reservations (ReservationID, BookID, MemberID, ReservationDate) VALUES
(1, 7, 4, '2024-07-01'),
(2, 12, 6, '2024-06-25'),
(3, 3, 8, '2024-07-03'),
(4, 19, 10, '2024-07-05'),
(5, 2, 12, '2024-07-07'),
(6, 14, 15, '2024-07-09'),
(7, 5, 18, '2024-07-11'),
(8, 9, 2, '2024-07-13'),
(9, 11, 5, '2024-07-15'),
(10, 16, 7, '2024-07-17'),
(11, 8, 9, '2024-07-19'),
(12, 17, 11, '2024-07-21'),
(13, 1, 14, '2024-07-23'),
(14, 10, 16, '2024-07-25'),
(15, 6, 19, '2024-07-27'),
(16, 4, 1, '2024-07-29'),
(17, 15, 3, '2024-07-31'),
(18, 18, 13, '2024-08-02'),
(19, 20, 17, '2024-08-04'),
(20, 13, 20, '2024-08-06');


INSERT INTO Loans (LoanID, MemberID, BookID, IssueDate, DueDate, ReturnDate) VALUES
(1, 1, 5, '2024-07-01', '2024-07-15', NULL),
(2, 2, 8, '2024-06-25', '2024-07-09', '2024-07-07'),
(3, 3, 12, '2024-06-20', '2024-07-04', '2024-07-01'),
(4, 4, 15, '2024-07-02', '2024-07-16', NULL),
(5, 5, 18, '2024-07-05', '2024-07-19', NULL),
(6, 6, 3, '2024-07-08', '2024-07-22', '2024-07-20'),
(7, 7, 7, '2024-07-10', '2024-07-24', NULL),
(8, 8, 10, '2024-07-12', '2024-07-26', '2024-07-25'),
(9, 9, 1, '2024-07-14', '2024-07-28', NULL),
(10, 10, 14, '2024-07-16', '2024-07-30', NULL),
(11, 11, 6, '2024-07-18', '2024-08-01', NULL),
(12, 12, 9, '2024-07-20', '2024-08-03', NULL),
(13, 13, 17, '2024-07-22', '2024-08-05', '2024-08-04'),
(14, 14, 20, '2024-07-24', '2024-08-07', NULL),
(15, 15, 2, '2024-07-26', '2024-08-09', NULL),
(16, 16, 4, '2024-07-28', '2024-08-11', '2024-08-10'),
(17, 17, 11, '2024-07-30', '2024-08-13', NULL),
(18, 18, 13, '2024-08-01', '2024-08-15', NULL),
(19, 19, 16, '2024-08-03', '2024-08-17', NULL),
(20, 20, 19, '2024-08-05', '2024-08-19', NULL);

INSERT INTO Fines (FineID, LoanID, FineAmount, PaidStatus) VALUES
(1, 2, 5.00, TRUE),
(2, 5, 2.50, FALSE),
(3, 7, 3.75, TRUE),
(4, 9, 1.50, FALSE),
(5, 12, 4.00, TRUE),
(6, 14, 2.25, FALSE),
(7, 16, 3.50, TRUE),
(8, 18, 5.00, FALSE),
(9, 1, 4.75, FALSE),
(10, 3, 2.00, TRUE),
(11, 6, 3.00, FALSE),
(12, 8, 2.50, TRUE),
(13, 10, 4.25, FALSE),
(14, 11, 1.75, TRUE),
(15, 13, 3.25, FALSE),
(16, 15, 2.80, TRUE),
(17, 17, 3.60, FALSE),
(18, 19, 4.90, TRUE),
(19, 4, 3.10, FALSE),
(20, 20, 5.00, TRUE);

select * from books;
