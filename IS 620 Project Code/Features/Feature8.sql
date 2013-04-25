select * from messages order by message_id;

exec delete_message (47,'RECEIVED','Tony@xmail.com')

create or replace
procedure delete_message
(
p_message_id in messages.message_id%type,
p_message_type in messages.message_type%type,
p_user_id in messages.user_id%type
)
is
temp_message_id messages.message_id%type := p_message_id;
temp_message_type messages.message_type%type := p_message_type;
temp_user_id messages.user_id%type := p_user_id;
x varchar2(10);
begin
if( p_message_type = 'DRAFT' or p_message_type = 'SENT')then    
         select message_type into x from messages where user_id = 'p_user_id' and message_id = p_message_id;
         if (x = 'TRASH')then 
          dbms_output.put_line('Message is already a trashed message');
          else    
          update messages set message_type = 'TRASH' where (message_id = p_message_id and message_type = p_message_type and user_id = p_user_id);
          dbms_output.put_line('Message sucessfully moved to trash');
         end if;     
elsif(p_message_type = 'RECEIVED')then 
         select message_type into x from messages where user_id = 'p_user_id' and message_id = p_message_id;
         if (x = 'TRASH') then 
         dbms_output.put_line('Message is already a trashed message');
         else 
          delete from RECEIVED_MESSAGES where ( message_id = p_message_id and message_type = p_message_type and user_id = p_user_id);
          update messages set message_type = 'TRASH' where message_id = p_message_id and message_type = p_message_type and user_id = p_user_id;
          dbms_output.put_line('Message sucessfully moved to trash');
        end if;
  else 
    dbms_output.put_line('Message is already a trashed message');
  
  end if;

exception
when no_data_found then 
dbms_output.put_line('No such message exisits');
end;