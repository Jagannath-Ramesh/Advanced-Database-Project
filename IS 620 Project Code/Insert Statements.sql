

/* Insert statements were not necessary for the tables
regular_user, user_contacts, received_messages. 
These tables are being populated using triggers. 
The trigger code can be found in the Triggers.sql file. */





insert into departments values (departments_seq.nextval, 'Math');
insert into departments values (departments_seq.nextval, 'Chemistry');
insert into departments values (departments_seq.nextval, 'Computer Science');
insert into departments values (departments_seq.nextval, 'Physics');
insert into departments values (departments_seq.nextval, 'Information Systems');
insert into departments values (departments_seq.nextval, 'Biology');
insert into departments values (departments_seq.nextval, 'English');
insert into departments values (departments_seq.nextval, 'Language');
insert into departments values (departments_seq.nextval, 'Economics');
insert into departments values (departments_seq.nextval, 'Ancient Studies');


insert into users  (user_id, users_name, password, telephone, department_id, user_type, last_logon_time)
values 
	('bob1@xmail.com', 'Bob Jhonson', 'Bob18s9',  '(444) 000-1012', 
		(select department_id from departments where department_name = 'Math'),'Regular', sysdate);
	  
   
	  insert into users  (user_id, users_name, password, telephone, department_id, user_type, last_logon_time)
  values 
      ('John1@xmail.com', 'John Lewis',  '7bk3jb9', '(781) 023-8989', (select department_id from departments where department_name = 'Economics'),
      'Regular',sysdate );

insert into users  (user_id, users_name, password,  telephone, department_id, user_type, last_logon_time)
  values 
      ('Tony@xmail.com', 'Tony Simpson',  'hdsginl', '(671) 891-3498', (select department_id from departments where department_name = 'Economics'),
      'Regular', (select system_time from system_time));
      
insert into users  (user_id, users_name, password, telephone, department_id, user_type, last_logon_time)
  values 
      ('Ian_Kelsey@xmail.com','Ian Kelsy',  'IAsk2il', '(444) 781-0913', (select department_id from departments where department_name = 'Math'),
      'Regular', (select system_time from system_time));

insert into users  (user_id, users_name, password,  telephone, department_id, user_type, last_logon_time)
  values 
      ('Ashwin@xmail.com', 'Ashwin Patel',  '78kjh3kl9', '(782) 901-8719', (select department_id from departments where department_name = 'Ancient Studies'),
      'Regular', (select system_time from system_time));

insert into users  (user_id, users_name, password,telephone, department_id, user_type, last_logon_time)
  values 
      ('michael1@xmail.com', 'michael lewis',  'micewis1', '(718) 019-7612', (select department_id from departments where department_name = 'Biology'),
      'Regular', (select system_time from system_time));


	  
	  
	  
	  
insert into messages values (message_seq.nextval, 'SENT'
,'John1@xmail.com','John1@xmail.com',
RECEIVERS('Tony@xmail.com','John1@xmail.com'), sysdate, 'subject1', 'body1');

insert into messages values (message_seq.nextval, 'RECEIVED','John1@xmail.com','John1@xmail.com',
RECEIVERS('Tony@xmail.com','John1@xmail.com'), sysdate, 'HI', 'Where is the picture');


insert into messages values (message_seq.currval, 'RECEIVED'
,'Tony@xmail.com','John1@xmail.com',
RECEIVERS('Tony@xmail.com','John1@xmail.com'), sysdate, 'subject1', 'body1');

insert into messages values (message_seq.nextval,  'TRASH'
,'John1@xmail.com','John1@xmail.com',
RECEIVERS('Tony@xmail.com','John1@xmail.com'), sysdate, 'subject2', 'body4');

insert into messages values (message_seq.nextval, 'DRAFT'
,'Ian_Kelsey@xmail.com','Ian_Kelsey@xmail.com',
RECEIVERS('Ashwin@xmail.com','michael1@xmail.com'), sysdate, 'Hello', 'How are you doing?');




insert into system_time values (timestamp '2012-10-09 01:00:00');



---------------------------------------------------------------------------













