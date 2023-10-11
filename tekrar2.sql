create table şiirler(
	id int,
	name varchar (50),
	email varchar (50),
	sehir varchar (50)
);
insert into şiirler values (9000 , 'yağmurlar' , 'kitap@hotmail.com' , 'ankara');
insert into şiirler values (9001, ' kaldırım' , 'dost@gmail.com' , 'istanbul');
insert into şiirler values (9002 , '' , 'sairler@mail.com');
insert into şiirler (name ) values ('gökyüzü');

select * from şiirler;

-----unique constraint eklemee
create table evHalkı(
	id serial,
	name varchar(50),
	email varchar(50) unique,
	salary real,
	work_name varchar(50)
);

insert into evHalkı values (1,'Mahmut sdfsdf' , 'mhmt@mail.com' , 4500 , 'İnşaat');
insert into evHalkı (name , email , salary , work_name) values ('Ahmet' , 'aww@mail.com' , 1564 , 'IT');
insert into evHalkı (name , email , salary , work_name) values ('Meryem' , 'awwtr@mail.com' , 5645 , 'Mimar');
insert into evHalkı (name , email , salary , work_name) values ('Meryem' , 'awwhtr@mail.com' , 5645 , 'Mühendis');
select * from evhalkı;

----------------not null----------------------
create table ogrenciler(
	id serial,
	name varchar(50) not null,
	email varchar(50) unique,
	salary real
);
insert into ogrenciler(name, email,salary) values ('Özlem Akyel' , 'ozl@mail.com' , 6546);
insert into ogrenciler(email,salary) values ('sdf@mail.com' , 1561);--name not null oldugu için kabul etmez
insert into ogrenciler(name, email,salary) values ('' , 'sfdg@mail.com' , 4684); --boşlugu kabul eder.

select * from ogrenciler;

----------------primary key PK----------------------------------
create table ogrenci4(
	id int primary key,--not nulldır , unique dir , başka bir tablo ile ilişkilendirmek için kullanırız
	name varchar(50),
	grade real,
	register_date date
);
select * from ogrenci4

------------composite key--------------------
create table ogrenciler5(
	id int,
	name varchar (50),
	grade real,
	register_date date,
	constraint ogr_4 primary key (id,name)
);
select * from  ogrenciler5;

-----------------foreign key-----------------------
create table adresler(
	adres_id int,
	street varchar(50),
	city varchar(50),
	student_id int,
	constraint adr_fk foreign key (student_id) references ogrenci4(id)
	--ogrenciler4 tablomda id yi pk yaptık burada foreign key ile birleştirdik
);

select * from adresler;

--------------------check---------------------------------

create table personeller( 
	id int,
	name varchar (50),
	salary real not null check (salary>5000),
	age int check (age>0 and age<50)
	);
insert into personeller values (11,'Enes',5900,33);
insert into personeller values (11,'Mehmet',4900.45);--salary>5000 old için kabul etmez.
insert into personeller values (12,'Arslan',5649,57);--age 0 ile 50 arasında old icin kabul ettmez.
insert into personeller values (17,'Random',8975,15);

select*from personeller;

