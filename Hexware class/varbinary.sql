----------VAR BINARY---------------
/*
when we want to store image files or unstructured data
unstucted data: images,videos,odf,or extrenal rsources
so to store unstrucured we use "varbinary"
---Data in database is classified into
->structured
->unstructured

structed data: it has a specific type and can accodat e a specifd
unstructed--it stored in raq data but we access in frontend it will be disolayed but now 
*/
insert into dbo.imgtable values(10,'butterfky',(select * from openrowset(bulk'img_path',SINGLE_blob)as T1))

select * from imgtable;

create table voter(
voterphoto varbinary(max),
votername varchar(30)
);

--bulk n means png format

insert into voter values((SELECT * FROM OPENROWSET(BULK N'C:\Users\harini chowdary\Pictures\20141016_113950.jpg', SINGLE_BLOB) AS T1),
'harini');
select * from voter;

