create or replace
procedure search_word ( usr_id users.user_id%type, In_Word varchar2)
Is
Out_Message Messages%Rowtype;
  cursor Cur_Search is select * from Messages 
  Where user_id = usr_id and (Message_Body like '%' || In_Word || '%'
  Or message_subject like '%' || In_Word || '%');
Begin
  Open Cur_Search;
  Loop
    FETCH Cur_Search INTO Out_Message;
    Exit When Cur_Search%Notfound;
    Dbms_Output.put('Id: ' || Out_Message.Message_Id || ' Message Type: ' || Out_Message.Message_Type);
    Dbms_Output.put(' Sender: ' || Out_Message.Sender || ' Receiver: ' );
    for i in 1..Out_Message.Receiver.count loop
    Dbms_Output.put(Out_Message.Receiver(i) || ', ');
    end loop;
    dbms_output.put_line(' Subject: ' || Out_Message.message_subject || ' Body: ' || Out_Message.message_body);
  end loop; 
  close Cur_Search;
end;