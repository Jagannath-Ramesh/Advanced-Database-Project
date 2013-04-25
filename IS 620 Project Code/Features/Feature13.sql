exec delete_trashed_message(47,'TRASH','Tony@xmail.com');

select * from messages ;

create or replace
procedure delete_trashed_message
(
p_message_id in messages.message_id%type,
p_message_type in messages.message_type%type,
p_user_id in messages.user_id%type
)
is
begin
if( p_message_type = 'TRASH')
then    
      delete from  messages  where (message_id = p_message_id and message_type = p_message_type and user_id = p_user_id);
      dbms_output.put_line('Message permanantly deleted');
  else 
  dbms_output.put_line('Selected message is not a trashed message');
  end if;
exception
when no_data_found then 
dbms_output.put_line('No such message exisits');
end;