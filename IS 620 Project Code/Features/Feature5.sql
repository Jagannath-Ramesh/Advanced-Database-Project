create or replace
procedure send_message
(
  p_sender in messages.sender%type,
   p_receiver in messages.receiver%type,
  p_message_subject in  varchar, 
  p_message_body in varchar
)
is 
  check_sender number;
  x number;
  y number;
  z varchar2(255);
  w varchar2(255);
begin
  y := message_seq.nextval; -- Retreive sequnce number value;
  check_sender := check_email_address(p_sender);
  if (check_sender = 1 ) then
      for i in 1..p_receiver.count 
        loop
        x := check_email_address (p_receiver(i));
          if (x = 0 ) then 
          dbms_output.put_line('An Invalid receiver was provided. Please try again.');
          elsif( x= 1) then 
              
                  z := check_user_type(p_receiver(i));
                  if ( z = 'R') then 
                  w := check_active_flag (p_receiver(i));
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
        insert into messages values (y,'SENT',p_sender,p_sender,p_receiver, sysdate, p_message_subject,p_message_body);
        
       for i in 1..p_receiver.count 
        loop       
            insert into messages values (y,'RECEIVED',p_receiver(i),p_sender,  p_receiver,
             sysdate, p_message_subject,p_message_body);
        end loop;
           dbms_output.put_line('Message sent successfully');
      end if;
  end;
  
  
  
  
  ------------------------------------------------------------------------------------------------------------------------
 

create or replace
procedure send_draft_message
(
  p_message_id messages.message_id%type,
  p_user_id in messages.sender%type
)
is
  check_sender number;
  x number;
 v_message_type varchar(255);
 v_sender messages.sender%type;
 v_receiver messages.receiver%type;
 v_message_subject messages.message_subject%type;
 v_message_body messages.message_body%type;
begin
  select message_type into v_message_type from messages where message_id = p_message_id and user_id = p_user_id;
  select sender, receiver,message_subject, message_body
  into v_sender, v_receiver, v_message_subject, v_message_body from messages
  where message_id = p_message_id and user_id = p_user_id;
  check_sender := check_email_address(p_user_id);
  if (check_sender = 1 ) then
      for i in 1..v_receiver.count
        loop
        x := check_email_address (v_receiver(i));
          if (x = 0 ) then
          dbms_output.put_line('An Invalid receiver was provided. Please try again.');
          exit;
          end if;
        end loop;
    else
    dbms_output.put_line('Invalid sender provided. Please try again.');
    end if;
       if(x = 1) then
          if(v_message_type = 'DRAFT') then
          insert into messages values (p_message_id,'SENT',p_user_id,v_sender,v_receiver, sysdate, v_message_subject,v_message_body);
       
          for i in 1..v_receiver.count
          loop      
            insert into messages values (p_message_id,'RECEIVED',v_receiver(i),v_sender,  v_receiver,
             sysdate, v_message_subject,v_message_body);
          end loop;
          delete from messages where message_id = p_message_id and user_id = p_user_id and message_type = 'DRAFT';
           dbms_output.put_line('Message sent successfully');
           else dbms_output.put_line('No such message exists');
          end if;
        end if;
  end;

