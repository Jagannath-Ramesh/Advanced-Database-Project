      
/* Sample execute statement*/
exec sent_count('John1@xmail.com', 12);  
	

	
create or replace
procedure sent_count ( usr_id users.user_id%type, k number) is
counter number;
counter1 number;
msg_type messages.message_type%type;
Today Date;
Curr_Date timestamp;
Begin
if check_email_address(usr_id) <> 0 then
  select count(*) into  counter From messages where message_type = 'SENT'
  and user_id= usr_id;
  dbms_output.put_line('Number of Sent Messages: ' || counter);
      

  select count(distinct(message_id)) into counter from messages where message_type= 'DRAFT' 
  and sender= usr_id;
  dbms_output.put_line('Number of Drafted Messages: ' || counter);

  select count(*) into counter From received_messages where user_id = usr_id
  and read_unread_flag = 'Y';
  dbms_output.put_line('Number of Received Read Messages: ' || counter);

  select count(*) into counter From received_messages
  where user_id= usr_id and read_unread_flag= 'N';
  dbms_output.put_line('Number of Received Unread Messages: ' || counter);

  select count(*) into counter from user_contacts
  where (user_id= usr_id or contact_id = usr_id);
  dbms_output.put_line('Number of Contacts: ' || counter);

  select system_time into Curr_Date from system_time;
  Today := Curr_Date - k;  /* Curr_Date - Interval k Day; */
  Dbms_Output.Put_Line(Today);
  /*Present_Day := To_Char(Today, 'DD-MON-YYYY HH:MI:SS');
  Present_Day := Present_Day || '.00';
  Dbms_Output.Put_Line(Present_Day);
  Present_Time := To_Timestamp(Present_Day);
  Dbms_Output.Put_Line(Present_Time);
*/
 
  select count(*) into counter from messages where message_time >= Today and 
  message_type='SENT' and user_id= usr_id;
  
  select count(*) into counter1 from messages where message_time >= Today and 
  message_type= 'RECEIVED' and user_id= usr_id;
  
  
  dbms_output.put_line('Number of sent and received messages in ' || k || ' Days: ' || 
  (counter+counter1));
else 
  dbms_output.put_line('Invalid user ID provided.');
end if;
End;