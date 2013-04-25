create or replace
trigger update_received_messages
after insert 
on messages
for each row when (new.MESSAGE_TYPE = 'RECEIVED')
begin 
insert into received_messages  values (:new.MESSAGE_ID, :new.message_type, :new.USER_ID, 'N');
end;



create or replace
trigger contact_count
after insert or update 
on messages 
for each row when (new.message_type = 'RECEIVED')
declare 
x number;
begin 
select num_times_contacted into x  from user_contacts where (:new.sender= user_id and :new.user_id = contact_id); 
if x is not null
then 
update user_contacts set num_times_contacted = (x+1) where (:new.sender= user_id and :new.user_id = contact_id); 
end if;
exception 
when no_data_found then
insert into user_contacts values (:new.sender, :new.user_id,1);
end;



create or replace
trigger create_new_regualar_user_flag
after insert 
on users 
for each row 
begin 
if (:new.user_type = 'Regular')
then insert into regular_user values (:new.user_id, 'Y');
end if;
end;