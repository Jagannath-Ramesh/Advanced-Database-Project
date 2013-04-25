
exec addUserContact ('ruch13@xmail.com', 'rucha@xmail.com');

create or replace
procedure AddUserContact (USERID IN varchar, CONTACTID IN varchar)
IS
x number;
y number;
z number;
begin 
 x := check_email_address (USERID);
 y := check_email_address (CONTACTID);
 if (x = 1 and y =1 ) then 
    z := check_contact_exists (USERID, CONTACTID);
     if (z =1 ) then 
     dbms_output.put_line('User is already listed as a contact');
     else 
     insert into user_contacts values (USERID, CONTACTID,1 );
     dbms_output.put_line('User contact added succesfully');
     end if;
 else
     dbms_output.put_line( 'An invalid contact ID or user ID was provided');
 end if;
 end;
 
 
 