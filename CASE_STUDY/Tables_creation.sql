------creating a database
create database Virtual_ArtGallery;

--using the database created:
use Virtual_ArtGallery;

-- Artist Table
CREATE TABLE Artist (
    ArtistID INT IDENTITY(1,1),
    Name NVARCHAR(100),
    Biography NVARCHAR(MAX),
    BirthDate DATE,
    Nationality NVARCHAR(50),
    Website NVARCHAR(100),
    ContactInfo NVARCHAR(100),
	PRIMARY KEY(ArtistID)
);
--Artwork Table
CREATE TABLE Artwork (
    ArtworkID INT IDENTITY(1,1),
    Title NVARCHAR(100),
    Description NVARCHAR(MAX),
    CreationDate DATE,
    Medium NVARCHAR(50),
    ImageURL NVARCHAR(255),
    ArtistID INT,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID),
	PRIMARY KEY(ArtworkID)
);
--user table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1),
    Username NVARCHAR(50) UNIQUE,
    [Password] NVARCHAR(100),        --to avoid errors we use [] beacuse passoword is a keyword
    Email NVARCHAR(100),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    ProfilePicture NVARCHAR(255),
	PRIMARY KEY(UserID)
);
-- Gallery Table
CREATE TABLE Gallery (
    GalleryID INT IDENTITY(1,1),
    Name NVARCHAR(100),
    Description NVARCHAR(MAX),
    Location NVARCHAR(100),
    CuratorID INT,
    OpeningHours NVARCHAR(100),
    FOREIGN KEY (CuratorID) REFERENCES Artist(ArtistID),
	PRIMARY KEY(GalleryID)
);
--  creating Junction Table: User_Favorite_Artwork
CREATE TABLE User_Favorite_Artwork (
    UserID INT,
    ArtworkID INT,
    PRIMARY KEY (UserID, ArtworkID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ArtworkID) REFERENCES Artwork(ArtworkID)
);
-- creating Junction Table: Artwork_Gallery
CREATE TABLE Artwork_Gallery (
    ArtworkID INT,
    GalleryID INT,
    PRIMARY KEY (ArtworkID, GalleryID),
    FOREIGN KEY (ArtworkID) REFERENCES Artwork(ArtworkID),
    FOREIGN KEY (GalleryID) REFERENCES Gallery(GalleryID)
);