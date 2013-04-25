/* Sample execute statement for feature 2*/
exec validate_user_identity ('John1@xmail.com','7bk3jb9');

create or replace
procedure validate_user_identity
(
p_email_id in  varchar,
p_password in  varchar
)
as
validate_user_result varchar2(1);
v_type_result varchar2(1); 
r_act_flag varchar2(1);
begin
validate_user_result := validate_user(p_email_id, p_password);
v_type_result := check_user_type(p_email_id);
  if (validate_user_result = 'Y' and v_type_result = 'A') then  --- if user is an admin 
    dbms_output.put_line('Account validated');
    update users set last_logon_time = sysdate where user_id = p_email_id;
  
  elsif(validate_user_result = 'Y' and v_type_result = 'R') then   -- if user is regular user then check if user is active 
      r_act_flag :=  check_active_flag(p_email_id);
      if (r_act_flag = 'Y') then
      dbms_output.put_line('Account validated');
       update users set last_logon_time = sysdate where user_id = p_email_id;
      else 
      dbms_output.put_line('Account could not be validated. User is currently inactive');
      end if;
  else 
    dbms_output.put_line('Account could not be validated');
  end if;
end;