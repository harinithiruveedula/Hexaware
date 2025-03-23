--Creating a database
create database hexaware_coding;
--using that database
use hexaware_coding;
/*
CODING CHALLENGE -5
===========Virtual Art Gallery==============
*/
-----------------------------------CREATING THE TABLES-------------------------------
-- Creating the Artists table
create table Artists(
                   ArtistID int,
				   Name VARCHAR(255) NOT NULL,
				   Biography TEXT,
				   Nationality VARCHAR(100),
				   primary key(ArtistID),
				   );

--Creating the Categories table
CREATE TABLE Categories (
                CategoryID INT,
				Name VARCHAR(100) NOT NULL,
				PRIMARY KEY(CategoryID),
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
		FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
		FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
		);
--Creating the Exhibitions table
CREATE TABLE Exhibitions (
               ExhibitionID INT PRIMARY KEY,
			   Title VARCHAR(255) NOT NULL,
			   StartDate DATE,
			   EndDate DATE,
			   Description TEXT
			   );

-- Create a table to associate artworks with exhibitions
CREATE TABLE ExhibitionArtworks (
                           ExhibitionID INT,
						   ArtworkID INT,
						   PRIMARY KEY (ExhibitionID, ArtworkID),
						   FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
						   FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)
						   );
----------------------------------INSERTING THE VALUES----------------------------------

--sample data into the Artists table
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
 (1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
 (2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
 (3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

 --sample data into the Categories table
INSERT INTO Categories (CategoryID, Name) VALUES
 (1, 'Painting'),
 (2, 'Sculpture'),
 (3, 'Photography');

 --sample data into the Artworks table
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
 (1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
 (2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
 (3, 'Guernica', 1, 1, 1937, 'Pablo Picasso \''s powerful anti-war mural.', 'guernica.jpg');

 --sample data into the Exhibitions table
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
 (1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
 (2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

 --sample data into exhibiton artwork
 INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
 (1, 1),
 (1, 2),
 (1, 3),
 (2, 2);

 ------------To view all the created tables---------------------------
 select * from Artists;
 select * from Categories;
 select * from Artworks;
 select * from Exhibitions;
 select * from ExhibitionArtworks;
 ----------------------------------CODING CHALLENGE ----------------------------
 ---Queries for the given questions
/*
1)Retrieve the names of all artists along with the number of artworks they have in the gallery, and 
list them in descending order of the number of artworks.
*/
select A.name as name_of_the_Artist ,
      count(art.ArtworkID) as no_of_Artworks
from Artists A
left join Artworks art
on A.ArtistID=art.ArtistID
group by A.ArtistID,A.Name
order by no_of_Artworks desc;
--LOGIC :
/*
->using LEFT JOIN to include all artsits
->grouping them by id and name
*/

--2)List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order them by the year in ascending order.

select art.title  as Title_of_Artworks, 
          A.Nationality ,
		  art.Year
from Artworks art
inner join Artists A
on a.ArtistID=art.ArtistID
where A.Nationality in ('Spanish' , 'Dutch')
order by art.Year asc;
---LOGIC USED:
/*
->using "INNER JOIN" beacuse and using "IN" operator to filter
->and "ASC" for ordering them in asecnding order
*/

--3)Find the names of all artists who have artworks in the 'Painting' category, and the number of  artworks they have in this category

select A.name as Name_of_the_Artist ,
       C.Name as category,
	   count(art.ArtworkID) as no_of_artworks
from Artists A 
inner join Artworks  art
on a.ArtistID=art.ArtistID
inner join Categories c
on art.CategoryID=c.CategoryID
where c.Name='Painting'
group by A.ArtistID,A.Name,c.Name
order by no_of_artworks desc;
--LOGIC USED::
/*
->using multiple join to join mutltiple tables
->filtering records based on the given condition
->grouping them and ordering the records
*/

--4)List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their artists and categories.

select    art.title ,
          A.name as artist_name ,
		  E.Title as exhibition_title,
		  C.Name as Category
from Artworks art
inner join Artists A
on A.ArtistID=art.ArtistID

inner join Categories C
on art.CategoryID=c.CategoryID

inner join ExhibitionArtworks EA
on Ea.ArtworkID=art.ArtworkID

inner join Exhibitions E
on ea.ExhibitionID=e.ExhibitionID

where e.Title='Modern Art Masterpieces';
--LOGIC USED::
/*
->joining the multiple tables
->filtering the records using "WHERE"
*/

--5)Find the artists who have more than two artworks in the gallery

select A.Name ,count(art.ArtworkID) as no_of_artworks
from Artists A
inner join Artworks art
on A.ArtistID=art.ArtistID
group by A.ArtistID, A.name
having count(art.ArtworkID)>2
order by no_of_artworks desc;
--LOGIC USED::
/*
->using "INNER JOIN" 
->using aggregate function such as "COUNT"
->ordering the records in descending order
*/

--6)Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and 'Renaissance Art' exhibitions

select art.Title as Title_of_artwork
from Artworks art
inner join ExhibitionArtworks EA
on art.ArtworkID=ea.ArtworkID
inner join Exhibitions e
on e.ExhibitionID=ea.ExhibitionID
where e.Title in('Modern Art Masterpieces','Renaissance Art')
group by art.artworkid,art.title
having count(distinct e.ExhibitionID)=2
--LOGIC USED::
/*
->using multiple join conditoon
->fitering the records using "WHERE"
->grouping the records
->using "HAVING" to filter records appearing in both the given conditions
*/

--7)Find the total number of artworks in each category
select count(art.ArtworkID) as no_of_artworks ,c.Name as category_name
from Artworks art
right join Categories c
on art.CategoryID=c.CategoryID
group  by c.Name
order by no_of_artworks desc

--LOGIC USED::
/*
->using "RIGHT JOIN" to return record even have zero values
->using aggregate function "COUNT" to count the id's
->grouping them by name
->ordering them in desc
*/

--8)List artists who have more than 3 artworks in the gallery.

select A.name,count(art.ArtworkID) as no_of_artworks
from Artists A
inner join Artworks art
on a.ArtistID=art.ArtistID
group by art.ArtistID,A.Name
having count(art.ArtworkID)>3
order  by no_of_artworks desc;
--LOGIC USED::
/*
->using inner join
->using aggregate function
->using HAVING to check the condition
->ordering them in descending order
*/
--9)Find the artworks created by artists from a specific nationality (e.g., Spanish)

select A.Name as artist_name ,A.Nationality ,art.Title as artwork
from Artists A
inner join Artworks art
on A.ArtistID=art.ArtistID
where a.Nationality='Spanish';
--LOGIC USED::
/*
->using joins
->using "WHERE" condtion to filter records
*/
--10)List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci inner sub query is written  to exhibitions that feature both Vincent van Gogh and Leonardo da Vinci.
select e.title as exhibition_title, 
       a.name as artist_name, 
       art.title as artwork_title
from exhibitions e
join exhibitionartworks ea on ea.exhibitionid = e.exhibitionid
join artworks art on art.artworkid = ea.artworkid
join artists a on a.artistid = art.artistid
where a.name in ('vincent van gogh', 'leonardo da vinci')
and e.title in (
    select e1.title
    from exhibitions e1
    join exhibitionartworks ea1 on ea1.exhibitionid = e1.exhibitionid
    join artworks art1 on art1.artworkid = ea1.artworkid
    join artists a1 on a1.artistid = art1.artistid
    where a1.name in ('vincent van gogh', 'leonardo da vinci')
    group by e1.title
    having count(distinct a1.name) = 2
)
order by e.title, a.name;
--LOGIC USED::
/*
->using a subquery to check both conition for artists
->using having to check count
*/
--11)Find all the artworks that have not been included in any exhibition.
select art.title 
from Artworks art
left join ExhibitionArtworks ea
on art.ArtworkID=ea.ArtworkID
where ea.ExhibitionID is null;
--LOGIC USED::
/*
->using left join to filter records even no values are there
->using "WHERE" to return records on given condition
->"IS null" return only null value
*/

--12)List artists who have created artworks in all available categories.
select A.name
from Artists A
inner join Artworks art
on a.ArtistID=art.ArtistID
inner join Categories c
on art.CategoryID=c.CategoryID
group by a.ArtistID,a.Name
having count(distinct art.CategoryID)=(SELECT COUNT(*) FROM Categories);
--LOGIC USED::
/*
->distinct categories in artworks is  compared  with the total number of categories
to find out the artist avaiable  in all available catogories
*/

--13)List the total number of artworks in each category.
select c.Name as category_name,count(art.ArtworkID) as total_no_of_artworks
from Artworks art
right join Categories c
on art.CategoryID=c.CategoryID
group by c.Name
order by total_no_of_artworks desc;
--LOGIC USED::
/*
->using right join to return even no values
->grouping them by name
->ordering them in descending order
*/

--14)Find the artists who have more than 2 artworks in the gallery.
select a.name ,count(art.ArtworkID) as no_of_artworks
from Artists a
inner join Artworks art
on a.ArtistID=art.ArtistID
group by a.ArtistID,a.Name
having count(art.ArtworkID)>2
order by no_of_artworks desc;
--LOGIC USED::
/*
->using inner join 
->checking the condiotion using "HAVING" and "count"
*/

--15)List the categories with the average year of artworks they contain, only for categories with more than 1 artwork.
select   avg(art.year) as average_year,c.Name
from Artworks art
 left join Categories c
on art.CategoryID=c.CategoryID
group by c.Name
having count(art.ArtworkID)>1;
--LOGIC USED::
/*
->using inner join 
->checking the condiotion using "HAVING" and "count"
*/


--16)Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition
select art.title as name_ofartwork , e.Title
from Artworks art
join ExhibitionArtworks EA
on art.ArtworkID=ea.ArtworkID
join Exhibitions e
on e.ExhibitionID=ea.ExhibitionID
where e.Title='Modern Art Masterpieces';

--LOGIC USED::
/*
->using inner join 
->checking the condiotion where 

*/

--17)Find the categories where the average year of artworks is greater than the average year of all artworks.

select C.name
from Categories c
join Artworks a
on c.CategoryID=a.CategoryID
group by c.Name
having avg(a.Year)> (select avg(Year) from Artworks)
--LOGIC USED::
/*
->using inner join 
->checking the condiotion using "HAVING" and "count"
*/

--18)List the artworks that were not exhibited in any exhibition
select art.title  as name_of_artwork
from Artworks art
left join ExhibitionArtworks ea
on art.ArtworkID= ea.ArtworkID
where ea.ExhibitionID is null

--LOGIC USED::
/*
->using left join 
->checking the condiotion using "WHERE"
-->using IS NULL
*/

--19)Show artists who have artworks in the same category as "Mona Lisa."
select a.name  as name_of_artist
from Artists a
inner join Artworks art
on a.ArtistID=art.ArtistID
where Art.CategoryID = (select CategoryID from Artworks where Title = 'Mona Lisa');
--LOGIC USED::
/*
->using inner join 
->checking the condiotion using "WHERE"
*/



--20)List the names of artists and the number of artworks they have in the gallery.

select a.name,count(art.ArtworkID) as no_of_artworks
from Artists a
left join Artworks art
on a.ArtistID=art.ArtistID
group by a.ArtistID,a.Name
order by no_of_artworks desc;

--LOGIC USED::
/*
->using left join 
-->using aggregate function "COUNT"
->grouping the records
->ordering them 
*/

-- HARINI SAI THIRUVEEDULA