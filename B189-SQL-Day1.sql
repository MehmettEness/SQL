--Yorum Satiri
/* coklu Yorum Satiri*/
---------------------------DAY 1 --------------------------------
--1-Database Olusturma--DDL
CREATE DATABASE mehmet_enes; --SQL komutlarindan buyuk kucuk harf duyarliligi yoktur.
--create database mehmet_enes; seklindede yazabilirdik, Daha belirgin olsun diye..

--2-Database Silme--DDL
DROP DATABASE mehmet_enes;

--3-Datalari saklamak icin = Tablo Olusturma
CREATE TABLE students(
id char(4),
name varchar(20),
grade real,
register_date date
); 
--grmek icin schemas sec tables ve otomatik geliyor. Students tablosundan sag tikla view sec

--4-Mevcut olan bir tablodan yeni tablo olusturma
CREATE TABLE grades as select name,grade from students; --daha once olusturdugum tablomdan name ve grade sec ve grades olarak yeni bir tablo olustur dedik.

--5-Tabloya data eklemek icin--DML
insert into students values('1001' , 'Sherlock Holmes' , 99.5 , '2023-10-04'); -- yukaridaki sirayla eklememiz onemli

insert into students values('1002' , 'Jack Sparrow' , 88.8 , now() );

--6-Tablodaki tum datalari gorunutuleme--DQL
select * from students;

--7-Tablonun bazi sutunlarina data  ekleme
insert into students (name , grade)values ('Harry Potter' , 99.9);
select * from students;

--8-Bir tablodaki tum kayitlarin sadece belirli sutunlarini goruntulemek istersek
select name, grade from students;

--practice
--grades tables sildik
--4.secenegi secip tekrar calistirdik
--ve refresh yapinca tekrar geldi

select * from grades;
--------------------------------------------------------------

