
exec create_account ('ruch13@xmail.com', 'Rucha Patil', 'simplk4', '(390) 792-8910','Math', 'Admin')


create or replace
PROCEDURE create_account
(
email_id in varchar,name in varchar,user_password in varchar,telephone_num in varchar,dept_name in varchar,user_type in varchar
) IS
check_user_id_result number;
check_department_result number;
BEGIN
check_user_id_result :=  check_user_id (email_id);  -- CHecks if user already exists 
 check_department_result  := check_department(upper(dept_name));  -- checks if department name provided is valid 
  if (check_user_id_result = 0 and  check_department_result  <> 0) then
    insert into users
    (
      USER_ID,USERS_NAME,PASSWORD,TELEPHONE,DEPARTMENT_ID,USER_TYPE,LAST_LOGON_TIME)
    values
    ( email_id,name,user_password,telephone_num,check_department_result ,user_type, sysdate);
      dbms_output.put_line('Account created succesfully');  
	else
    dbms_output.put_line('Account cannot be created.'); 
  end if;
  end;
  
  
  
  
  