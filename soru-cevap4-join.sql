--***********************  join  ******************
create table filmler (
film_id int,
film_name varchar(30), 
category varchar(30) 
);

insert into filmler values (1, 'Eyvah Eyvah', 'Komedi');
insert into filmler values (2, 'Kurtlar Vadisi', 'Aksiyon');
insert into filmler values (3, 'Eltilerin Savasi', 'Komedi');
insert into filmler values (4, 'Aile Arasinda', 'Komedi');
insert into filmler values (5, 'GORA', 'Bilim Kurgu'); 
insert into filmler values (6, 'Organize Isler', 'Komedi');
insert into filmler values (7, 'Babam ve Oglum', 'Dram');

create table aktorler (
id int,
actor_name varchar(30),
film_id int
);

insert into aktorler values (1, 'Ata Demirer', 1); 
insert into aktorler values (2, 'Necati Sasmaz', 2);
insert into aktorler values (3, 'Gupse Ozay', 3);
insert into aktorler values (4, 'Engin Gunaydin', 4);
insert into aktorler values (5, 'Cem Yilmaz', 5);

select * from filmler;
select * from aktorler;

--Soru-15 Tüm film_name leri, kategorilerini ve filmlerde oynayan aktor_name leri listeleyin

select * from filmler
left join aktorler
on filmler.film_id = aktorler.film_id -- bu kısım eşitse filmlerde oynayan aktörler gelir.

--Soru-16: tüm actor_name leri ve oynadigi film name leri listeleyiniz


