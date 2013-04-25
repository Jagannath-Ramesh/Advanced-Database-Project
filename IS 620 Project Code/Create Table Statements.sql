create or replace
type Receivers as varray(20) of varchar2(255);


create table system_time
(
system_time timestamp not null
);

create table departments
(
department_id number not null, 
department_name varchar2(255) not null
);

create table users
(
user_id varchar2(255) not null,
users_name varchar2(255) not null, 
password varchar2(255) not null, 
telephone varchar2(25) constraint telephone_check CHECK (REGEXP_LIKE(telephone, '^\(\d{3}\) \d{3}-\d{4}$')) not null,
department_id number not null, 
user_type varchar2(7) not null, 
last_logon_time timestamp not null, 
check(user_type in ('Regular', 'Admin'))
);


create table regular_user
(
user_id varchar2(255) not null, 
active_flag varchar2(1) not null,
check(active_flag in ('Y', 'N'))
);

alter table departments add unique (department_name); 



create table user_contacts 
(
user_id varchar2(255) not null,
contact_id varchar2(255) not null,
num_times_contacted number not null
);



alter table departments add constraint pk_departments PRIMARY KEY (department_id);
alter table users add constraint pk_users PRIMARY KEY (user_id);
alter table regular_user add constraint pk_regular_users PRIMARY KEY (user_id);
alter table user_contacts add constraint pk_user_contacts PRIMARY KEY (user_id, contact_id);

alter table users add constraint fk_users_department FOREIGN KEY (department_id) references departments (department_id) on delete cascade;
alter table regular_user add constraint fk_regular_user FOREIGN KEY (user_id) references users(user_id) on delete cascade;
alter table user_contacts add constraint fk_user_contacts_uid FOREIGN KEY (user_id) references users(user_id) on delete cascade;
alter table user_contacts add constraint fk_user_contacts_cid FOREIGN KEY (contact_id) references users(user_id)on delete cascade;



create table messages
(
message_id number not null, 
message_type varchar2(255) not null, 
user_id varchar2(255) not null, 
sender varchar2(255), 
receiver RECEIVERS, 
message_time timestamp not null, 
message_subject varchar2(255), 
message_body varchar2(1024),
CONSTRAINT FK1_messages FOREIGN KEY (sender) REFERENCES USERS (user_id),
constraint FK3_messages FOREIGN KEY (user_id) REFERENCES USERS (user_id) on delete cascade,
CONSTRAINT pk_messages PRIMARY KEY (message_id, message_type, user_id),
CHECK (message_type in ('RECEIVED', 'SENT', 'TRASH', 'DRAFT'))
);



create table received_messages
(
message_id number not null, 
message_type varchar2(255) not null, 
user_id varchar2(255) not null, 
read_unread_flag varchar2(1) default 'Y' not null,
CONSTRAINT FK1_r_messages FOREIGN KEY (message_id, message_type, user_id) REFERENCES messages (message_id,message_type,user_id) on delete cascade,
CONSTRAINT pk_R_messages PRIMARY KEY (message_id, message_type, user_id)
);


















