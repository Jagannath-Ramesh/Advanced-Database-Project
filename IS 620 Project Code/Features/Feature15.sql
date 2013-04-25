create or replace procedure admin_report(usr_id in users.user_id%type) is
type_of users.user_type%type;
counter number;
begin
select user_type into type_of from users where user_id = usr_id;
if type_of = 'Admin' then
select count(*) into counter from regular_user where active_flag='Y';
dbms_output.put_line('Number of Active Users: ' || counter);
select count(*) into counter from regular_user where active_flag='N';
dbms_output.put_line('Number of Inactive Users: ' || counter);
avg_contact(usr_id);
avg_message(usr_id);
most_active(usr_id);
else
dbms_output.put_line('User is not Admin. Only Admin user can execute this procedure');
end if;
end;


create or replace
procedure avg_contact (usr_id in users.user_id%type) is
counter1 number;
temp_count number;
counter number;
type_of users.user_type%type;
begin
  select count(*) into temp_count from regular_user where active_flag='Y';
  select (count(*)+temp_count) into counter1 from regular_user where active_flag='Y';
  select count(*) into counter from user_contacts where 
  user_id in (select user_id from regular_user where active_flag='Y') or
  user_id in (select user_id from users where user_type='Admin') or
  contact_id in (select user_id from regular_user where active_flag='Y') or
  contact_id in (select user_id from users where user_type='Admin');
  dbms_output.put_line('Avg Contacts: ' || (counter*2)/counter1);
end;

create or replace
procedure avg_message (usr_id in users.user_id%type) is
counter number;
temp_count number;
counter1 number;
type_of users.user_type%type;
begin
/*select user_type into type_of from users where user_id = usr_id;
/*if type_of = 'Admin' then*/
  select count(*) into temp_count from regular_user where active_flag='Y';
  select (count(*)+temp_count) into counter1 from users where user_type='Admin';
  select count(*) into counter from messages where message_type= 'SENT' and
  user_id in (select user_id from regular_user where active_flag='Y')
  or user_id in (select user_id from users where user_type='Admin');
  dbms_output.put_line('Avg of SENT: ' || counter/counter1);
  select count(*) into counter from messages where message_type= 'RECEIVED' and
  user_id in (select user_id from regular_user where active_flag='Y')
  or user_id in (select user_id from users where user_type='Admin');
  dbms_output.put_line('Avg of RECEIVED: ' || counter/counter1);
  select count(*) into counter from messages where message_type= 'DRAFT' and
  user_id in (select user_id from regular_user where active_flag='Y')
  or user_id in (select user_id from users where user_type='Admin');
  dbms_output.put_line('Avg of DRAFT: ' || counter/counter1);
  select count(*) into counter from messages where message_type= 'TRASH' and
  user_id in (select user_id from regular_user where active_flag='Y')
  or user_id in (select user_id from users where user_type='Admin');
  dbms_output.put_line('Avg of TRASH: ' || counter/counter1);
/*end if; */
end;


create or replace procedure most_active (users_id in users.user_id%type) is
dept departments%rowtype;
usr_id users.user_id%type;
final_usr_id users.user_id%type;
--dept_id users.department_id%type;
cursor get_dept is select * from departments;
cursor get_user is select user_id from users where department_id = dept.department_id;
counter number;
counter1 number := 0;
begin
open get_dept;
loop
  fetch get_dept into dept;
  exit when get_dept%notfound;
  final_usr_id := '';
  counter1:= 0;
    open get_user;
      loop
      fetch get_user into usr_id;
      exit when get_user%notfound;
        select count(*) into counter from messages where user_id = usr_id and 
        (message_type = 'SENT' or message_type = 'RECEIVED');
          if counter > counter1 then
            final_usr_id := usr_id;
          end if;
      end loop;
    close get_user;
    dbms_output.put_line('Most Active User for deparment ' || dept.department_name || ' is: ' || final_usr_id);
end loop;
close get_dept;
end;
