
create or replace procedure top5
(
p_useremail users.user_id%type
)
as
contacts varchar2(255);
p_user_id varchar2(255);
cursor top5 is select contact_id into contacts from user_contacts where user_id = p_useremail order by num_times_contacted desc;

begin
open top5;
dbms_output.put_line('Your top 5 contacted persons are:');
loop
fetch top5 into contacts;
exit when top5%notfound or top5%rowcount = 5;
dbms_output.put_line(contacts);
end loop;
close top5;
exception
when no_data_found then
dbms_output.put_line('No rows found');
end;