exec replyTo_all (46, 'Tony@xmail.com', 'xxxx');

create or replace
procedure replyTo_all
(
  p_msg_id in messages.message_id%type,
  p_msg_usr_id in messages.user_id%type,
  p_message_body in messages.message_body%type
)
is 
  v_receiver messages.receiver%type;
  v_subj messages.message_subject%type;
  check_sender number;
  x number;
  y number;
  z varchar2(255);
  w varchar2(255);

begin
      y := message_seq.nextval; -- Retreive sequnce number value; 
          select receiver, message_subject into  v_receiver ,v_subj  from messages 
          where user_id =  p_msg_usr_id and message_type = 'RECEIVED' and  message_id =  p_msg_id; 
          
        check_sender := check_email_address(p_msg_usr_id);
        if (check_sender = 1 ) then
        for i in 1.. v_receiver.count 
        loop
        x := check_email_address (v_receiver(i));
          if (x = 0 ) then 
          dbms_output.put_line('An Invalid receiver was provided. Please try again.');
          elsif( x= 1) then 
              
                  z := check_user_type(v_receiver(i));
                  if ( z = 'R') then 
                  w := check_active_flag (v_receiver(i));
                      if ( w = 'N') then 
                      dbms_output.put_line('A receiver provided is currently inactive');
                      end if;
                  end if;
                 
          end if;
          
          exit;
      end loop; 
    else 
    dbms_output.put_line('Invalid sender provided. Please try again.');
    end if;
       if(x = 1 and w <> 'N') then
    
          insert into messages values (y,'SENT',  p_msg_usr_id,  p_msg_usr_id, v_receiver, sysdate,'RE:'|| v_subj,p_message_body);
          for i in 1..v_receiver.count 
          loop       
          insert into messages values (y,'RECEIVED',v_receiver(i),p_msg_usr_id,v_receiver,
          sysdate, v_subj,p_message_body);
          end loop;
          dbms_output.put_line('Message sent successfully'); 
      end if;
          exception
          when no_data_found then
          dbms_output.put_line('No such message exists');
  end;