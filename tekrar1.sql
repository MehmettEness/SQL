create database mea;
create table kullanıcı(
	user_id  int,
	name varchar (30),
	surname varchar (30),
	email varchar(100),
	grade real,
	dogum_tarihi date
);
insert into kullanıcı values('0216' , 'Mehmet Enes' , 'Arslan' , 'mehenar@gmail.com' , 91.5 , '1991-06-06'),
							('0127' , 'Zeynep' , 'Tuna' , 'zynp@gmail.com' , 90.7 , '1986-03-07');
insert into kullanıcı values('08451' , 'Cüneyt' , 'Alemdar' , 'cnyt_almdar@gmail.com' , 92.6 , '1998-10-09');							
select*from kullanıcı;
insert into kullanıcı (name , surname , grade) values ('Bahar' , 'Arslan' , 93.5);

select user_id , email , dogum_tarihi from kullanıcı;

select name , surname , email from kullanıcı;