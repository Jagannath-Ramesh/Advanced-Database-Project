create or replace
procedure organize_messages(usr_id users.user_id%type) is
msg_first messages%rowtype;
msg_second messages%rowtype;
cursor first_msg is select * from messages where message_subject not like 'RE%' 
and user_id=usr_id order by message_time desc;
cursor second_msg is select * from messages where message_subject like '%' || msg_first.message_subject || '%' 
and user_id=usr_id order by message_time desc;
begin
open first_msg;
  loop
    fetch first_msg into msg_first;
    exit when first_msg%notfound;
    open second_msg;
      loop
        fetch second_msg into msg_second;
        exit when second_msg%notfound;
        dbms_output.put('Msg Id: ' || msg_second.message_id);
        dbms_output.put(' Sender: ' || msg_second.sender);
        dbms_output.put(' Receiver: ');
        for i in 1 .. msg_second.receiver.count
        loop
          dbms_output.put(msg_second.receiver(i) || ', ');
        end loop;
        dbms_output.put(' Subject: ' || msg_second.message_subject);
        dbms_output.put_line(' Body: ' || msg_second.message_body);
      end loop; 
      dbms_output.put_line(second_msg%rowcount);
    close second_msg;
  end loop;
close first_msg;
end;