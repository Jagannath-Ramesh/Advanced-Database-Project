create or replace
procedure updt_sys_time (
new_time in system_time.system_time%type) is
usr_id users.user_id%type;
cursor get_usr is select user_id from users where user_type = 'Regular'
and last_logon_time <= new_time - interval '90' day;
begin
open get_usr;
loop
fetch get_usr into usr_id;
exit when get_usr%notfound;
update regular_user set active_flag='N' 
where user_id = usr_id;
end loop;
close get_usr;
delete from messages where message_type = 'TRASH' and
message_time <= new_time - interval '30' day;
end;