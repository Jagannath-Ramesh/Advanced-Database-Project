

exec find_contact('bob1@xmail.com', 'Rucha');

create or replace
procedure find_contact
(usr_id in users.user_id%type,usr_name in users.users_name%type) is
usr_lst users%rowtype;
d_name departments.department_name%type;
cursor search is select * from users where users_name LIKE '%' || usr_name || '%';
begin
  open search;
    loop
      fetch search into usr_lst;
      exit when search%notfound;
      dbms_output.put('User Id: ' || usr_lst.user_id);
      select department_name into d_name from departments where department_id = usr_lst.department_id;
      dbms_output.put(' Department: ' || d_name);
      dbms_output.put(' Name: ' || usr_lst.users_name);
      dbms_output.put_line(' Telephone: ' || usr_lst.telephone);
    end loop;
    if(search%rowcount = 0)
    then dbms_output.put_line('No users exist with given name');
    end if;
  close search;
end;