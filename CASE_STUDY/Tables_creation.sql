------creating a database
create database [Virtual_ArtGallery] on primary 
(name=N'Virtual_ArtGallery',filename=N'D:\Virtual_ArtGallery.mdf')
log on
(name=N'Virtual_ArtGallery_log',filename=N'D:\Virtual_ArtGallery.ldf')
collate sql_Latin1_general_cp1_ci_AS;

--using the database created:
use Virtual_ArtGallery;

-- Create Schema
CREATE SCHEMA Gallery;
GO

-- Artist Table
CREATE TABLE gallery.Artists (
    ArtistID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Biography NVARCHAR(MAX),
    BirthDate DATE,
    Nationality NVARCHAR(50),
    Website NVARCHAR(100),
    ContactInfo NVARCHAR(100)
);

-- Artwork Table
CREATE TABLE gallery.Artwork (
    ArtworkID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    CreationDate DATE,
    Medium NVARCHAR(50),
    ImageURL NVARCHAR(255),
    ArtistID INT NOT NULL,
    FOREIGN KEY (ArtistID) REFERENCES gallery.Artists(ArtistID) ON DELETE CASCADE
);

-- User Table
CREATE TABLE gallery.Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    [Password] NVARCHAR(100) NOT NULL, -- Used square brackets to avoid keyword conflict
    Email NVARCHAR(100) UNIQUE NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    ProfilePicture VARBINARY(MAX)
	);
	
-- Gallery Table
CREATE TABLE gallery.Gallery (
    GalleryID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Location geography,
    CuratorID INT NULL,  
    OpeningHours NVARCHAR(100),
    FOREIGN KEY (CuratorID) REFERENCES gallery.Artists(ArtistID) ON DELETE SET NULL
);




-- Junction Table: User_Favorite_Artwork
CREATE TABLE gallery.User_Favorite_Artwork (
    UserID INT NOT NULL,
    ArtworkID INT NOT NULL,
    PRIMARY KEY (UserID, ArtworkID),
    FOREIGN KEY (UserID) REFERENCES gallery.Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ArtworkID) REFERENCES gallery.Artwork(ArtworkID) ON DELETE CASCADE
);

-- Junction Table: Artwork_Gallery
CREATE TABLE gallery.Artwork_Gallery (
    ArtworkID INT NOT NULL,
    GalleryID INT NOT NULL,
    PRIMARY KEY (ArtworkID, GalleryID),
    FOREIGN KEY (ArtworkID) REFERENCES gallery.Artwork(ArtworkID) ON DELETE CASCADE,
    FOREIGN KEY (GalleryID) REFERENCES gallery.Gallery(GalleryID) ON DELETE CASCADE
);

ALTER TABLE gallery.Gallery 
ADD UserID INT NULL, 
    Type NVARCHAR(20) CHECK (Type IN ('Physical', 'Virtual')),
    CreatedAt DATETIME DEFAULT GETDATE();

ALTER TABLE gallery.Gallery 
ADD FOREIGN KEY (UserID) REFERENCES gallery.Users(UserID) ON DELETE SET NULL;


---------------------creating indexing-------------------
--for better search
--Index for Fast User-Based Virtual Gallery Searches
CREATE INDEX IDX_Gallery_User ON gallery.Gallery (GalleryID, CuratorID);

--Index for Fast Artwork Retrieval in Virtual Galleries
CREATE INDEX IDX_Artwork_Gallery ON gallery.Artwork_Gallery (GalleryID, ArtworkID);


-----------------------------------------Views for Quick Data Access--------------------------------------
--Retrieve All Virtual Galleries with User Details

CREATE VIEW gallery.VirtualGalleries AS
SELECT G.GalleryID, G.Name AS GalleryName, G.Description, G.CreatedAt, 
       U.UserID, U.Username, U.Email
FROM gallery.Gallery G
LEFT JOIN gallery.Users U ON G.UserID = U.UserID
WHERE G.Type = 'Virtual';

--
SELECT * FROM gallery.VirtualGalleries;



--Retrieve Artworks in a Virtual Gallery
--This view helps list all artworks in a virtual gallery.
CREATE VIEW gallery.VirtualGallery_Artworks AS
SELECT AG.GalleryID, G.Name AS GalleryName, A.ArtworkID, A.Title, A.Medium, A.ImageURL
FROM gallery.Artwork_Gallery AG
JOIN gallery.Gallery G ON AG.GalleryID = G.GalleryID
JOIN gallery.Artwork A ON AG.ArtworkID = A.ArtworkID
WHERE G.Type = 'Virtual';

--
SELECT * FROM gallery.VirtualGallery_Artworks WHERE GalleryID = 1;

------------------------------------------Stored Procedures----------------------------------------
--This stored procedure allows users to create their personal virtual gallery.
CREATE PROCEDURE gallery.CreateVirtualGallery
    @UserID INT,
    @GalleryName NVARCHAR(100),
    @Description NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO gallery.Gallery (Name, Description, Type, UserID)
    VALUES (@GalleryName, @Description, 'Virtual', @UserID);
END;
--
EXEC gallery.CreateVirtualGallery @UserID = 1, @GalleryName = 'Modern Art', @Description = 'A collection of modern paintings';

--Procedure: Add an Artwork to a Virtual Gallery
--This procedure adds an artwork to a user's virtual gallery.

CREATE PROCEDURE gallery.AddArtworkToGallery
    @GalleryID INT,
    @ArtworkID INT
AS
BEGIN
    INSERT INTO gallery.Artwork_Gallery (GalleryID, ArtworkID)
    VALUES (@GalleryID, @ArtworkID);
END;

--
EXEC gallery.AddArtworkToGallery @GalleryID = 2, @ArtworkID = 5;

--Procedure: Remove an Artwork from a Virtual Gallery
--This allows users to remove artworks from their personal gallery.

CREATE PROCEDURE gallery.RemoveArtworkFromGallery
    @GalleryID INT,
    @ArtworkID INT
AS
BEGIN
    DELETE FROM gallery.Artwork_Gallery
    WHERE GalleryID = @GalleryID AND ArtworkID = @ArtworkID;
END;
--
EXEC gallery.RemoveArtworkFromGallery @GalleryID = 2, @ArtworkID = 5;

----Procedure: Delete a Virtual Gallery (Only Creator Can Delete)
--This ensures only the creator can delete their virtual gallery.

CREATE PROCEDURE gallery.DeleteVirtualGallery
    @GalleryID INT,
    @UserID INT
AS
BEGIN
    DELETE FROM gallery.Gallery 
    WHERE GalleryID = @GalleryID AND UserID = @UserID AND Type = 'Virtual';
END;

--
EXEC gallery.DeleteVirtualGallery @GalleryID = 2, @UserID = 1;

---- Fetch User's Virtual Galleries
--This retrieves all virtual galleries created by a specific user.
CREATE PROCEDURE gallery.GetUserVirtualGalleries
    @UserID INT
AS
BEGIN
    SELECT GalleryID, Name, Description, CreatedAt 
    FROM gallery.Gallery 
    WHERE UserID = @UserID AND Type = 'Virtual';
END;

--
EXEC gallery.GetUserVirtualGalleries @UserID = 1;
