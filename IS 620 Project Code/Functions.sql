/* The function will return the active / inactive flag of the user. */

create or replace
function check_active_flag (email_address in varchar) return varchar
is
 act_flag  varchar2(1);
begin
  select active_flag into act_flag from regular_user  where user_id = email_address;
  return act_flag ;
exception
  when no_data_found then
    return 'N';
end;

/* This function check if the department name is valid and returns the department ID. */

create or replace
function check_department (dept_name in varchar) return number
is
  departmentID number;
begin
  select department_id into departmentID from departments where dept_name = department_name;
  return departmentID;
exception
  when no_data_found then
   dbms_output.put_line('Invalid department name provided. Please provide a valid department name.');
    return 0;
end;

/*  This function checks the user id (in email format) for validation*/


create or replace
function check_email_address (email_address in varchar) return number
is
   email varchar2(255);
begin
  select user_id into email from users where email_address = user_id;
  return 1;
exception
  when no_data_found then
    return 0;
end;



/* This function checks to see if the message specified exists using the primary key*/

create or replace
function check_message (email_address in varchar, msg_id in number, msg_type in varchar) return number -- The input values are the primary key of the messages table 
is
   check_value varchar2(255);
begin
  select user_id into check_value from messages where( message_id = msg_id and message_type = msg_type and message_id = email_address);
  dbms_output.put_line(check_value);
  return 1;
exception
  when no_data_found then
   dbms_output.put_line ('No such message exists');
    return 0;
end;

/* This function checks if a user ID is already taken and prints appropiate message*/

create or replace
function check_user_id (email_address in varchar) return number
is
  email varchar2(255);
begin
  select user_id into email from users where email_address = user_id;
  dbms_output.put_line('User ID is already taken. Please select a different user ID. ');
  return 1;
exception
  when no_data_found then
    return 0;
end;

/* This fucntion checks the user type of a particuler user. */

create or replace
function check_user_type (email_address in varchar) return varchar
is
usr_type varchar2(10);
begin
  select user_type into usr_type from users where user_id = email_address;
  if (usr_type = 'Regular') then 
  return 'R';
  else 
  return 'A'; -- Represents an admin user. Check constraint makes sure no other type besides regular or admin is entered. 
  end if;
exception
  when no_data_found then
    return 'N';
end;

/* This fucntion is used for user authentication. */ 

create or replace
function validate_user
(
p_email_id varchar2,
p_password varchar2
)return varchar
as
pwd varchar2(255);
v_email_id varchar2(255);
begin
select user_id, password into pwd, v_email_id from users where user_id = p_email_id and password = p_password;
return 'Y';
exception
when no_data_found then
dbms_output.put_line('Incorrect user_id and or password.');
return 'N';
end;


create or replace
function check_contact_exists (email1 in varchar, email2 in varchar) return number
is
   x number;
begin
  select NUM_TIMES_CONTACTED into x from user_contacts where ( (email1 = user_id and email2 = contact_id) or (email1 = contact_id and email2 = user_id));
  return 1;
exception
  when no_data_found then
    return 0;
end;












