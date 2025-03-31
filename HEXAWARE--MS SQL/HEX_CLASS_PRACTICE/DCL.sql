=============DATA CONTROL COMMANDS==========
/*
these lanaguage is used o control the permissions on the 
data base objects
thereare 3 basic commands we use in ms sql
1)grant
2)revoke
3)deny --only exclusive in ms sql

GRANT : it grants permissions on the table to the other user
syntax:
grant [all | insert| update| delete|] on  team2;
==so now team2  has acces to change table a
then it will be notified 

REVOKE : means permanatly removing the permissions
the revoke command i=used to delete permanetaly the permissions from the user
revoke [all | insert| update| delete]on employee to team B
then it will notify about the revoking  like permision dnied to acees the table

DENY: it temporarly revokes all the security permissions
we can deny permisions on condition basis also
syntax: deny [all|insert|select|update|delete] on tb_name to <user name> 

*/
Team A
grant all employee to Team B
team B
select * from emp.employees
delete from emp.employees where id=10

team a
deny insert,upadte,delete to team B