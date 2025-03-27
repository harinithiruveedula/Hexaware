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
    [Password] NVARCHAR(100) NOT NULL, -- Using square brackets to avoid keyword conflict
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
    CuratorID INT NULL,  -- Changed from NOT NULL to NULL
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
