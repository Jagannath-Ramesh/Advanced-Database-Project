create or replace
procedure create_draft 
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
begin
  y := message_seq.nextval; -- Retreive sequnce number value;
  check_sender := check_email_address(p_sender);
  if (check_sender = 1 ) then
      for i in 1..p_receiver.count 
        loop
        x := check_email_address (p_receiver(i));
          if (x = 0 ) then 
          dbms_output.put_line('An Invalid receiver was provided. Please try again.');
          exit;
          end if;
        end loop;
    else 
    dbms_output.put_line('Invalid sender provided. Please try again.');
    end if;
       if(x = 1 and check_sender = 1) then
            insert into messages values (y,'DRAFT',p_sender,p_sender,  p_receiver,
             sysdate, p_message_subject,p_message_body);
           dbms_output.put_line('Drafted Message saved successfully');
          end if;
  end;
        
        
        
        
        
        
        
        
        
        
        