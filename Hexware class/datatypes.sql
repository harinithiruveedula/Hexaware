
--Geography datatype
create table spataildata(
locationid int primary key,
locationname nvarchar(20),
GeoLocation geography
);

--geo-round earth coridiante system
insert into spataildata values(1,
                      'hyderabad',geography::Point(17.4065, 78.4772,40.89));
select * from spataildata;

