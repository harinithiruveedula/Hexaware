--synonymn : it is used to duplicate the existing table
use hexaware_practice;
exec sp_tables;

select * from  company_mast
--creating synoymn

create synonym company_details
for 
company_mast;

select * from company_details
--updating new table results in the old table also

update company_details set com_name='apple' where com_id=12;

