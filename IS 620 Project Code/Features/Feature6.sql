

create or replace
procedure read_new_message
(
userId in varchar,
msgs_id in number
)
as
cursor cursor1 is 
select 
        messages.message_id,  messages.message_type, messages.user_id, messages.sender,
        messages.receiver, messages.message_time, messages.message_subject, 
        messages.message_body, received_messages.read_unread_flag
from  messages , received_messages  
where (messages.message_id = received_messages.message_id and 
      messages.message_type = received_messages.message_type and 
      messages.user_id = received_messages.user_id and 
      messages.user_id = userId  and  messages.message_type = 'RECEIVED' and messages.message_id = msgs_id);
msg_id messages.message_id%type;
msg_type messages.message_type%type;
usrID messages.user_id%type;
v_sender messages.sender%type;
v_receiver RECEIVERS;
v_time messages.message_time%type;
v_subj messages.message_subject%type;
v_body messages.message_body%type;
read_Y_N  received_messages.read_unread_flag%type;
begin 
open cursor1;
loop
fetch cursor1 into msg_id,msg_type, usrID, v_sender, v_receiver,v_time,v_subj,v_body,read_Y_N ;
exit when cursor1%notfound;
if(cursor1%notfound = false)
then 
update received_messages set read_unread_flag = 'Y' where message_id = msgs_id and user_id = userID;
end if;
dbms_output.put_line ('Read' || read_Y_N || ' Message ID:' || msg_id || ' Sender ' ||  v_sender ||'  Time '|| v_time);
dbms_output.put_line('Message Subject: ' || v_subj);
dbms_output.put_line('Message Body: ' || v_body);
dbms_output.put('Receivers:');
for i in 1..v_receiver.count 
loop
dbms_output.put (v_receiver(i)|| ', ');
 end loop;
  dbms_output.new_line;
  dbms_output.new_line;
end loop;
close cursor1;
end;



-----------------------------------------------------
create or replace
procedure view_messages
(
userId in varchar,
msg_type in varchar
)
as
cursor cursor1 is select message_id,sender, receiver,message_time, message_subject from  messages 
where user_id = userID and message_type = msg_type order by message_time ;
msg_id messages.message_id%type;
v_sender messages.sender%type;
v_receiver messages.receiver%type;
v_time messages.message_time%type;
v_subj messages.message_subject%type;
begin 
open cursor1;
loop
fetch cursor1 into msg_id, v_sender, v_receiver,v_time,v_subj;

exit when cursor1%notfound;

dbms_output.put_line ('Message ID:' || msg_id || ' Sender ' ||  v_sender ||'  Time '|| v_time);
dbms_output.put_line('Message Subject: ' || v_subj);
dbms_output.put('Receivers:');
for i in 1..v_receiver.count 
loop
dbms_output.put (v_receiver(i)|| ', ');
 end loop;
  dbms_output.new_line;
  dbms_output.new_line;
end loop;

if(cursor1%rowcount = 0)
then dbms_output.put_line('You have no messages');
end if;
close cursor1;
end;