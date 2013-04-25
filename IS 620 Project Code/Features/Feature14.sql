create or replace
procedure change_account_status (ADMIN_ID IN varchar,REGULAR_USR_ID in varchar, Y_N in varchar )
IS
x number;
y number;
z varchar2(1);
w varchar2(1);
b varchar2(1);
begin 
 x := check_email_address (ADMIN_ID);
 y := check_email_address (REGULAR_USR_ID);
 if (x = 1 and y =1 ) then 
     z := check_user_type(ADMIN_ID);
     w := check_user_type(REGULAR_USR_ID);
     select active_flag into b from regular_user where user_id = REGULAR_USR_ID;
          if (z = 'A' and w = 'R' and b = 'Y') then 
               if (Y_N = 'N') then 
              update regular_user set active_flag = 'N' where user_id = REGULAR_USR_ID;
              dbms_output.put_line('User has been set to inactive');
              else 
              dbms_output.put_line('User is already set to active');
              end if;
          elsif(z = 'A' and w = 'R' and b = 'N') then 
                if (Y_N = 'Y') then 
                update regular_user set active_flag = 'Y' where user_id = REGULAR_USR_ID;
                dbms_output.put_line('User has been set to active');
                else 
                dbms_output.put_line('User is already set to inactive');
                end if;
          else 
          dbms_output.put_line('User is trying to perform action that is not allowed. Only an  admin can change the  account belong to a Regular user');
          end if;
  
end if;
    end;
 