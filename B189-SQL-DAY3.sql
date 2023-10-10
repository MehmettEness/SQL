------------------ DAY'3 DT-NT -------------------
------------------   tekrar ------------------

CREATE TABLE calisanlar(
id char(5) PRIMARY KEY,--NOT NULL,UMIQUE,bu sütun başka tablo ile ilişkilendirilirken kullanılacak
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama date
);--referenced table/parent

CREATE TABLE adresler(
adres_id char(5),--NULL olur, DUPLICATE olur
sokak varchar(30),
cadde varchar(30),
sehir varchar(20),
FOREIGN KEY(adres_id) REFERENCES calisanlar(id) 
);--child

INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14');--isim:NOT NULL yok+
INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14');--isim UNIQUE 
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--+
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12');--maas:NOT NULL
INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14');--maas:integer
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');--'' NULL değildir
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14');--id:PK(unique)
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14');--id:10002 zaten var
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14');--id:PK:NOT NULL
INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');--FK: duplicate kabul eder
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');

INSERT INTO adresler VALUES('10012','Taş Sok', '30.Cad.','Konya');--calisanlarda 10012 yok


INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');


SELECT * FROM calisanlar;
SELECT * FROM adresler;

--14- WHERE koşulu

--calısanlar tablosundan belirli bir kayıtlarımızı görüntüleyelim --> ismi donatello olanları görüntüleyelim

select * from calisanlar where isim='Donatello';

--calısanlar tablosundan maaşı 5000 den fazla olanları alalım

select * from calisanlar where maas>5000;

--calısanlar tablosundan maaşı 5000 den fazla olan isim ve maas alalım

select isim , maas from calisanlar where maas>5000;

--adresler tablosunda sehiri 'konya' ve adres_id si 10002 olan kaydın tüm verileri getirelim.

select*from adresler where adres_id = '10002' and sehir='Konya';

--sehiri konya veya bursa olan adreslerin cadde ve sehir bilgilerini getirelim

select cadde , sehir from adresler where sehir='Konya' or sehir='Bursa'

--15-delete from tablo ismi .. where koşul belirticez (tablodan silme)--DML

CREATE TABLE ogrenciler1
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);
INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler1 VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler1 VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler1 VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler1 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler1 VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler1 VALUES(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM ogrenciler1;

--id=123 olan kaydı tablodan silelim

delete from ogrenciler1 where id=123;

--ismi Kemal Tan olan kaydı silelimm

delete from ogrenciler1 where isim='Kemal Tan';

--ismi Ahmet Ran veya Veli Han olan kayıtları silelim

delete from ogrenciler1 where isim='Ahmet Ran' or isim= 'Veli Han';

select * from students;--day 1 de olusturmustuk
--Tablodaki tüm kayıtları silmek istersek
--students tablosundaki tüm kayıtları silme
delete from students;

--tablodaki tüm komutları silme 2.yöntem
--doctors tablosundaki tüm kayıtları silelim
select*from doctors;
truncate table doctors; --bu komutta siler

--17-parent-child ilişkisi olan tablolarda silme işlemi

select*from calisanlar;--parent
select*from adresler;--child

--calısanlar tablosundaki tüm kayıtları silelim
delete from calisanlar; --hatan veriyoor cünkü adres_id referans edilmiştir.
delete from calisanlar where id='10002'; --yine aynı şekilde referans edildiği icin silemezz

delete from adresler where adres_id='10002';--referans alınan kayıt silindi
delete from calisanlar where adres_id='10002';

delete from adresler;--tüm ilşşki koparıldı artık silebildik. Çünkü referanslarını silebildik
delete from calisanlar;

--18-on delete cascade --kademeli silme işlemini otomatik olarak yapar

CREATE TABLE talebeler
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);--parent

CREATE TABLE notlar( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id) on delete cascade
);--child

INSERT INTO talebeler VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO talebeler VALUES(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);
INSERT INTO notlar VALUES ('127', 'Matematik',90);
INSERT INTO notlar VALUES (null, 'tarih',90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

--notlar tablosundan id=123 olan kaydı silelim
delete from notlar where talebe_id='123'

--talebeler tablosundan id si 126 olan kaydı silelim

(--parentten referansli bir kaydı silmek icin aşamalı bire silme işlemi uyguluyorduk
--on deelete cascade işlemi aktif oldugu için bu özellik otomatik olarak silecek
--önce notlar tablosundan referans olanı siler , sonra parentten silinen kaydı siler	

delete from talebeler where id=126; 
	
--talebeler tablosundaki tüm kayıtları silebilir miyiz.
delete from talebeler;
	
--19-Tabloyu silme= Tabloyu schemadan kaldırma
--sairler tablosunu silelim
	select*from sairler
	
drop table sairler;--DDL	
	
--talebler tablosunu da silelim
drop table talebeler;	--tablo içindeki kayıtları silmiştik  ama tablolar hala bağımlı oldugu için silmez
--aşamalı olarak talebler tablosunu silerr	
drop table talebeler cascade ;
	
--talebeler1 tablosunu silelim
drop table talebeler1;--böyle bir tablo oluşturmadık . Hata alırız.Sileceğimiz tablonun varlıgından emin değilsek
drop table if exists talebeler1; -- eger varsa sil dedik. Olmadığı iöçin silmedi ve hata vermedi. Bize not verdi...
	
--20-in condition
	
CREATE TABLE musteriler  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;
	
--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
	
select * from musteriler where urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot' 

-- birden fazla or kullanılması durumunda yapılması gereken
select * from musteriler where urun_isim in( 'Orange', 'Apple', 'Apricot')	
	
--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olmayan verileri listeleyiniz.	
	
select * from musteriler where urun_isim not in ('Orange', 'Apple', 'Apricot')	
	
	
--21- Between .. and .. komutu
	
--Müşteriler tablosunda urun_id 20 ile 40(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz	
select*from musteriler where urun_id>=20 and urun_id<=40;
	
	--2.yol
select*from musteriler where urun_id between 20 and 40;	
	
--Müşteriler tablosunda urun_id 20 den küçük veya 30(dahil değil) büyük  arasinda olan urunlerin tum bilgilerini listeleyiniz	
select*from musteriler where urun_id<20 or urun_id>30;
	
	--2,yol
select*from musteriler where urun_id not between 20 and 30;	
	
--22-Aggregate Fonksiyonlarr	-- birden çok hesaplamalar yapar ve bize tek bir deger verir.
	
/*avg=ortalama
count=saymak
sum=toplama
min=minimum
max=maksimum*/
	
CREATE TABLE calisanlar3 (
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalar;
SELECT * FROM calisanlar3;
	
--calısanlar3 tablosundaki max massı görünütle
select max (maas) from calisanlar3;	--7000

--calısanlar3 tablosundaki min massı görünütle
select min (maas) from calisanlar3;
	
--calısanlar3 tablosundaki toplam massı görünütle	
select sum(maas) from calisanlar3;
	
--calısanlar3 tablosundaki ortalama massı görünütle
select avg(maas) from 	calisanlar3; --2714.2857142857142857
	
--ondalıklı kısmı görmek istemiyoruzzz
select round (avg(maas) , 2 ) from 	calisanlar3;--2714.29 virgülden sonraki iki degeri yuvarlra dedik	
	
--calısanlar3 tablosundaki kayıt sayisini görünütleyiniz
select count (*) from calisanlar3; --7	--* herhangi bir sütünunu degerini ver dedik * yerine sütun isminide kullanabilirdik..
	
--calısanlar3 tablosundaki maası 2500 olanların sayisini görünütleyiniz	
select count (maas) from calisanlar3 where maas=2500;
	
	
	
	
	