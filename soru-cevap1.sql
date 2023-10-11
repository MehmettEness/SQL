CREATE TABLE calisanlar1(
id char(5) PRIMARY KEY,--NOT NULL,UNIQUE,bu sütun başka tablo ile ilişkilendirilirken kullanılacak
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama date
);--referenced table/parent

CREATE TABLE adresler1(
adres_id char(5),--NULL olur, DUPLICATE olur
sokak varchar(30),
cadde varchar(30),
sehir varchar(20),
FOREIGN KEY(adres_id) REFERENCES calisanlar1(id) 
);--child

INSERT INTO calisanlar1 VALUES('10002', 'Donatello' ,12000, '2018-04-14'); 
INSERT INTO calisanlar1 VALUES('10003', null, 5000, '2018-04-14');--isim:NOT NULL yok+
INSERT INTO calisanlar1 VALUES('10004', 'Donatello', 5000, '2018-04-14');--isim UNIQUE kullanıldı 
INSERT INTO calisanlar1 VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--+
INSERT INTO calisanlar1 VALUES('10006', 'Leonardo', null, '2019-04-12');--maas:NOT NULL
INSERT INTO calisanlar1 VALUES('10007', 'Raphael', '', '2018-04-14');--maas:integer
INSERT INTO calisanlar1 VALUES('', 'April', 2000, '2018-04-14');--'' NULL değildir
INSERT INTO calisanlar1 VALUES('', 'Ms.April', 2000, '2018-04-14');--id:PK(unique)
INSERT INTO calisanlar1 VALUES('10002', 'Splinter' ,12000, '2018-04-14');--id:10002 zaten var
INSERT INTO calisanlar1 VALUES( null, 'Fred' ,12000, '2018-04-14');--id:PK:NOT NULL
INSERT INTO calisanlar1 VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10010', 'Betty' ,12000, '2018-04-14');

INSERT INTO adresler1 VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler1 VALUES('10003','Kaya Sok', '50.Cad.','Ankara');--FK: duplicate kabul eder
INSERT INTO adresler1 VALUES('10002','Taş Sok', '30.Cad.','Konya');

INSERT INTO adresler1 VALUES('10012','Taş Sok', '30.Cad.','Konya');--calisanlarda 10012 yok


INSERT INTO adresler1 VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler1 VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');


SELECT * FROM calisanlar1;
SELECT * FROM adresler1;


---------------------------------------where-------------------------------------------------
--calısanlar1 tablosundan belirli bir kayıtlarımızı görüntüleyelim --> ismi donatello olanları görüntüleyelim
select * from calisanlar1 where isim='Donatello';

--calısanlar1 tablosundan maaşı 5000 den fazla olanları alalım
select*from calisanlar1 where maas>5000;

--calısanlar1 tablosundan maaşı 5000 den fazla olan isim ve maas alalım
select  isim, maas from calisanlar1 where maas>5000;

--adresler1 tablosunda sehiri 'konya' ve adres_id si 10002 olan kaydın tüm verileri getirelim.
select * from adresler1 where sehir='Konya' and adres_id='10002';

--sehiri konya veya bursa olan adreslerin cadde ve sehir bilgilerini getirelim
select cadde,sehir from adresler1 where sehir='Konya' or sehir='Bursa';


---------------------------delete from-------------------------------

CREATE TABLE ogrenciler6(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);
INSERT INTO ogrenciler6 VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler6 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler6 VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler6 VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler6 VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler6 VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler6 VALUES(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM ogrenciler6;

--id=123 olan kaydı tablodan silelim
delete from ogrenciler6 where id=123;

--ismi Ahmet Ran olan kaydı silelimm
delete from ogrenciler6 where isim='Ahmet Ran';

--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
delete from ogrenciler6 where isim='Ahmet Ran' or isim='Veli Han';

select*from kullanıcı; --bu tablodaki tüm kayıtları silelim
delete from kullanıcı;

----parent | child ilişkisi olan tabloları silmee işlemi
select*from calisanlar1--p
select*from adresler1--c

--önce referans olan silinir.
delete from adresler1 where adres_id='10002'

delete from adresler1;

delete from calisanlar1;

-------------------------------------on delete cascade-----------------------------------

CREATE TABLE talebelerr
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);--parent

CREATE TABLE notlarr( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
constraint nott_fk foreign key (talebe_id) references talebelerr (id) on delete cascade
	);
--child

INSERT INTO talebelerr VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO talebelerr VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebelerr VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO talebelerr VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO talebelerr VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO talebelerr VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO talebelerr VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO talebelerr VALUES(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlarr VALUES ('123','kimya',75);
INSERT INTO notlarr VALUES ('124', 'fizik',65);
INSERT INTO notlarr VALUES ('125', 'tarih',90);
INSERT INTO notlarr VALUES ('126', 'Matematik',90);
INSERT INTO notlarr VALUES ('127', 'Matematik',90);
INSERT INTO notlarr VALUES (null, 'tarih',90);

SELECT * FROM talebelerr;
SELECT * FROM notlarr;

--notlar tablosundan id=123 olan kaydı silelim
delete from notlarr where talebe_id=123;

--talebeler tablosundan id si 126 olan kaydı silelim
delete from talebelerr where id=123;

--talebeler tablosundaki tüm kayıtları silebilir miyiz.
delete from talebelerr;

----------------------------------tabloyu komple silme schemadan kaldırma-------------------------------------
--şiirler tablosunu silelim
select*from şiirler;

drop table şiirler;

--talebelerr55 tablosunu silelim------böyle bir tablo yok
drop table talebelerr55;
drop table if exists talebelerr55; --bize sadece not verir. 

-----------------------------in condition-------------------------------

CREATE TABLE musterilerr  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musterilerr VALUES (10, 'Mark', 'Orange');
INSERT INTO musterilerr VALUES (10, 'Mark', 'Orange');
INSERT INTO musterilerr VALUES (20, 'John', 'Apple');
INSERT INTO musterilerr VALUES (30, 'Amy', 'Palm');
INSERT INTO musterilerr VALUES (20, 'Mark', 'Apple');
INSERT INTO musterilerr VALUES (10, 'Adem', 'Orange');
INSERT INTO musterilerr VALUES (40, 'John', 'Apricot');
INSERT INTO musterilerr VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musterilerr;

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.

select*from musterilerr where urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot';

---birden fazla or kullandığımız için
select*from musterilerr where urun_isim in ('Orange' , 'Apple' , 'Apricot' )

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olmayan verileri listeleyiniz.
select*from musterilerr where urun_isim not in ('Orange' , 'Apple' , 'Apricot' );

------------------------between .. and .. komutu-----------------------------------------

--Müşteriler tablosunda urun_id 20 ile 40(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
select * from musterilerr where urun_id between 20 and 40; 

--Müşteriler tablosunda urun_id 20 den küçük veya 30(dahil değil) büyük  arasinda olan urunlerin tum bilgilerini listeleyiniz	

select * from musterilerr where urun_id not between 20 and 30;

--22-Aggregate Fonksiyonlarr -- birden çok hesaplamalar yapar ve bize tek bir deger verir.
/*
avg=ortalama
count=saymak
sum=toplama
min=minimum
max=maksimum
*/
	
CREATE TABLE calisanlar53 (
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar53 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar53 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar53 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar53 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar53 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar53 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar53 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalarrr
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO markalarrr VALUES(100, 'Vakko', 12000);
INSERT INTO markalarrr VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalarrr VALUES(102, 'Adidas', 10000);
INSERT INTO markalarrr VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalarrr;
SELECT * FROM calisanlar53;	

--calısanlar53 tablosundaki max massı görüntüle
select max(maas) from calisanlar53;

--calısanlar53 tablosundaki min massı görüntüle
select min(maas) from calisanlar53;

--calısanlar53 tablosundaki toplam massı görüntüle
select sum(maas) from calisanlar53;

--calısanlar53 tablosundaki ortalama massı görünütle
select avg(maas) from calisanlar53;--2714.2857142857142857

--ondalıklı kısmı görmek istemezsek
select round (avg(maas) , 2 ) from calisanlar53;--virgülden sonra görmek istediğimiz rakam kısmı

--calısanlar53 tablosundaki kayıt sayisini görünütleyiniz
select count(*) from calisanlar53;

--calısanlar53 tablosundaki maası 2500 olanların sayisini görünütleyiniz
select count(maas) from calisanlar53 where maas=2500;
/*
avg=ortalama
count=saymak
sum=toplama
min=minimum
max=maksimum
*/




