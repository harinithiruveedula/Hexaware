-- Creating a database
CREATE DATABASE hexaware_coding;

-- Using the created database
USE hexaware_coding;

/*
CODING CHALLENGE -5
===========Virtual Art Gallery==============
*/

-----------------------------------CREATING THE TABLES-------------------------------

-- Creating the Artists table
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Biography TEXT,
    Nationality VARCHAR(100)
);

-- Creating the Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- Creating the Artworks table
CREATE TABLE Artworks (
    ArtworkID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ArtistID INT,
    CategoryID INT,
    Year INT,
    Description TEXT,
    ImageURL VARCHAR(255),
    FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID) ON DELETE CASCADE
);

-- Creating the Exhibitions table
CREATE TABLE Exhibitions (
    ExhibitionID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Description TEXT
);

-- Creating a table to associate artworks with exhibitions
CREATE TABLE ExhibitionArtworks (
    ExhibitionID INT,
    ArtworkID INT,
    PRIMARY KEY (ExhibitionID, ArtworkID),
    FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID) ON DELETE CASCADE,
    FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID) ON DELETE CASCADE
);

----------------------------------INSERTING THE VALUES----------------------------------

-- Sample data into the Artists table
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

-- Sample data into the Categories table
INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');

-- Sample data into the Artworks table
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso''s powerful anti-war mural.', 'guernica.jpg');

-- Sample data into the Exhibitions table
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

-- Sample data into the ExhibitionArtworks table
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2);

------------To view all the created tables---------------------------
SELECT * FROM Artists;
SELECT * FROM Categories;
SELECT * FROM Artworks;
SELECT * FROM Exhibitions;
SELECT * FROM ExhibitionArtworks;

----------------------------------CODING CHALLENGE QUERIES----------------------------

-- 1) Retrieve the names of all artists along with the number of artworks they have in the gallery, and list them in descending order of the number of artworks.
SELECT A.Name AS Name_of_the_Artist,
       COUNT(art.ArtworkID) AS No_of_Artworks
FROM Artists A
LEFT JOIN Artworks art ON A.ArtistID = art.ArtistID
GROUP BY A.ArtistID, A.Name
ORDER BY No_of_Artworks DESC;

-- LOGIC USED:
-- -> Using LEFT JOIN to include all artists
-- -> Grouping them by ID and name
-- -> Ordering in descending order by the number of artworks

-- 2) List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, ordered by the year in ascending order.
SELECT art.Title AS Title_of_Artworks,
       A.Nationality,
       art.Year
FROM Artworks art
INNER JOIN Artists A ON A.ArtistID = art.ArtistID
WHERE A.Nationality IN ('Spanish', 'Dutch')
ORDER BY art.Year ASC;

-- LOGIC USED:
-- -> Using INNER JOIN to filter only matching artists
-- -> Using IN operator to filter by nationality
-- -> Using ORDER BY with ASC for ascending order

-- 3) Find the names of all artists who have artworks in the 'Painting' category and the number of artworks they have in this category.
SELECT A.Name AS Name_of_the_Artist,
       C.Name AS Category,
       COUNT(art.ArtworkID) AS No_of_Artworks
FROM Artists A
INNER JOIN Artworks art ON A.ArtistID = art.ArtistID
INNER JOIN Categories C ON art.CategoryID = C.CategoryID
WHERE C.Name = 'Painting'
GROUP BY A.ArtistID, A.Name, C.Name
ORDER BY No_of_Artworks DESC;

-- LOGIC USED:
-- -> Using multiple joins to connect the necessary tables
-- -> Filtering records based on category name
-- -> Grouping by artist and category
-- -> Ordering results in descending order

-- 4) List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their artists and categories.
SELECT art.Title AS Artwork_Title,
       A.Name AS Artist_Name,
       E.Title AS Exhibition_Title,
       C.Name AS Category
FROM Artworks art
INNER JOIN Artists A ON A.ArtistID = art.ArtistID
INNER JOIN Categories C ON art.CategoryID = C.CategoryID
INNER JOIN ExhibitionArtworks EA ON EA.ArtworkID = art.ArtworkID
INNER JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
WHERE E.Title = 'Modern Art Masterpieces';

-- LOGIC USED:
-- -> Using multiple INNER JOINs to fetch relevant data
-- -> Filtering by exhibition title using WHERE clause

-- 5) Find the artists who have more than two artworks in the gallery.
SELECT A.Name,
       COUNT(art.ArtworkID) AS No_of_Artworks
FROM Artists A
INNER JOIN Artworks art ON A.ArtistID = art.ArtistID
GROUP BY A.ArtistID, A.Name
HAVING COUNT(art.ArtworkID) > 2
ORDER BY No_of_Artworks DESC;

-- LOGIC USED:
-- -> Using INNER JOIN to count artworks per artist
-- -> Applying HAVING clause to filter artists with more than 2 artworks
-- -> Ordering results in descending order
-- 6) Find the titles of artworks that were exhibited in both ‘Modern Art Masterpieces’ and ‘Renaissance Art’ exhibitions.
SELECT A.Title AS Artwork_Title
FROM ExhibitionArtworks EA1
JOIN Exhibitions E1 ON EA1.ExhibitionID = E1.ExhibitionID
JOIN Artworks A ON EA1.ArtworkID = A.ArtworkID
JOIN ExhibitionArtworks EA2 ON A.ArtworkID = EA2.ArtworkID
JOIN Exhibitions E2 ON EA2.ExhibitionID = E2.ExhibitionID
WHERE E1.Title = 'Modern Art Masterpieces' 
AND E2.Title = 'Renaissance Art';

-- LOGIC USED:
-- -> Joining the ExhibitionArtworks table twice to get artworks present in both exhibitions
-- -> Filtering for artworks in 'Modern Art Masterpieces' and 'Renaissance Art'
-- -> Ensuring only artworks common to both exhibitions are returned

-- 7) Find the total number of artworks in each category.
SELECT C.Name AS Category_Name, COUNT(A.ArtworkID) AS No_of_Artworks
FROM Categories C
LEFT JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name
ORDER BY No_of_Artworks DESC;

-- LOGIC USED:
-- -> Using LEFT JOIN to include all categories
-- -> Counting artworks in each category
-- -> Grouping by category name
-- -> Ordering by number of artworks in descending order

-- 8) List artists who have more than 3 artworks in the gallery.
SELECT Ar.Name AS Artist_Name, COUNT(A.ArtworkID) AS No_of_Artworks
FROM Artists Ar
JOIN Artworks A ON Ar.ArtistID = A.ArtistID
GROUP BY Ar.ArtistID, Ar.Name
HAVING COUNT(A.ArtworkID) > 3;

-- LOGIC USED:
-- -> Counting artworks for each artist
-- -> Filtering only artists with more than 3 artworks using HAVING
-- -> Grouping by artist name

-- 9) Find the artworks created by artists from a specific nationality (e.g., Spanish).
SELECT A.Title AS Artwork_Title, Ar.Name AS Artist_Name, Ar.Nationality
FROM Artists Ar
JOIN Artworks A ON Ar.ArtistID = A.ArtistID
WHERE Ar.Nationality = 'Spanish';

-- LOGIC USED:
-- -> Using INNER JOIN to connect artists with artworks
-- -> Filtering for artists with nationality 'Spanish'

-- 10) List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.
SELECT DISTINCT E.Title AS Exhibition_Title
FROM Exhibitions E
JOIN ExhibitionArtworks EA ON E.ExhibitionID = EA.ExhibitionID
JOIN Artworks A ON EA.ArtworkID = A.ArtworkID
JOIN Artists Ar ON A.ArtistID = Ar.ArtistID
WHERE Ar.Name IN ('Vincent van Gogh', 'Leonardo da Vinci')
GROUP BY E.ExhibitionID, E.Title
HAVING COUNT(DISTINCT Ar.Name) = 2;

-- LOGIC USED:
-- -> Filtering exhibitions containing artworks by both artists
-- -> Using HAVING to ensure both artists are present in the exhibition

-- 11) Find all the artworks that have not been included in any exhibition.
SELECT A.Title AS Artwork_Title
FROM Artworks A
LEFT JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

-- LOGIC USED:
-- -> Using LEFT JOIN to keep all artworks
-- -> Filtering for artworks without matching ExhibitionArtworks entries

-- 12) List artists who have created artworks in all available categories.
SELECT Ar.Name AS Artist_Name
FROM Artists Ar
JOIN Artworks A ON Ar.ArtistID = A.ArtistID
JOIN Categories C ON A.CategoryID = C.CategoryID
GROUP BY Ar.ArtistID, Ar.Name
HAVING COUNT(DISTINCT C.CategoryID) = (SELECT COUNT(*) FROM Categories);

-- LOGIC USED:
-- -> Counting distinct categories for each artist
-- -> Using HAVING to ensure an artist has artworks in all categories

-- 13) List the total number of artworks in each category.
SELECT C.Name AS Category_Name, COUNT(A.ArtworkID) AS No_of_Artworks
FROM Categories C
LEFT JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name
ORDER BY No_of_Artworks DESC;

-- LOGIC USED:
-- -> Same as query 7

-- 14) Find the artists who have more than 2 artworks in the gallery.
SELECT Ar.Name AS Artist_Name, COUNT(A.ArtworkID) AS No_of_Artworks
FROM Artists Ar
JOIN Artworks A ON Ar.ArtistID = A.ArtistID
GROUP BY Ar.ArtistID, Ar.Name
HAVING COUNT(A.ArtworkID) > 2;

-- LOGIC USED:
-- -> Same as query 8 but with threshold of 2 instead of 3

-- 15) List the categories with the average year of artworks they contain, only for categories with more than 1 artwork.
SELECT C.Name AS Category_Name, AVG(A.Year) AS Avg_Year
FROM Categories C
JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name
HAVING COUNT(A.ArtworkID) > 1;

-- LOGIC USED:
-- -> Calculating average year for each category
-- -> Using HAVING to filter only categories with more than one artwork

-- 16) Find the artworks that were exhibited in the ‘Modern Art Masterpieces’ exhibition.
SELECT A.Title AS Artwork_Title, E.Title AS Exhibition_Title
FROM Artworks A
JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
WHERE E.Title = 'Modern Art Masterpieces';

-- LOGIC USED:
-- -> Joining ExhibitionArtworks to get artworks for the exhibition
-- -> Filtering by exhibition title

-- 17) Find the categories where the average year of artworks is greater than the average year of all artworks.
SELECT C.Name AS Category_Name, AVG(A.Year) AS Avg_Year
FROM Categories C
JOIN Artworks A ON C.CategoryID = A.CategoryID
GROUP BY C.CategoryID, C.Name
HAVING AVG(A.Year) > (SELECT AVG(Year) FROM Artworks);

-- LOGIC USED:
-- -> Calculating category-wise average year
-- -> Comparing with the overall average year

-- 18) List the artworks that were not exhibited in any exhibition.
SELECT A.Title AS Artwork_Title
FROM Artworks A
LEFT JOIN ExhibitionArtworks EA ON A.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

-- LOGIC USED:
-- -> Same as query 11

-- 19) Show artists who have created work in the same category as "Mona Lisa."
SELECT DISTINCT Ar.Name AS Artist_Name
FROM Artists Ar
JOIN Artworks A1 ON Ar.ArtistID = A1.ArtistID
JOIN Categories C1 ON A1.CategoryID = C1.CategoryID
WHERE C1.CategoryID = (SELECT CategoryID FROM Artworks WHERE Title = 'Mona Lisa');

-- LOGIC USED:
-- -> Getting category of 'Mona Lisa'
-- -> Finding artists who have artworks in that category

-- 20) List the names of artists and the number of artworks they have in the gallery.
SELECT Ar.Name AS Artist_Name, COUNT(A.ArtworkID) AS No_of_Artworks
FROM Artists Ar
LEFT JOIN Artworks A ON Ar.ArtistID = A.ArtistID
GROUP BY Ar.ArtistID, Ar.Name
ORDER BY No_of_Artworks DESC;

-- LOGIC USED:
-- -> Counting artworks for each artist
-- -> Using LEFT JOIN to include all artists
-- -> Ordering by artwork count