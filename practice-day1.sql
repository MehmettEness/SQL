CREATE TABLE ogrenciler (
	id integer primary key,
	isim varchar(50),
	adres varchar(100),
	sinav_notu integer
);

-- veya

CREATE TABLE ogrenciler (
	id integer ,
	isim varchar(50),
	adres varchar(100),
	sinav_notu integer,
	CONSTRAINT std_pk PRIMARY KEY(id)
);

-- 2 PK olursa :
CREATE TABLE ogrenciler (
	id integer ,
	isim varchar(50),
	adres varchar(100),
	sinav_notu integer,
	CONSTRAINT composite_pk PRIMARY KEY(id,isim)
);

/*
	Niye Composite PK ya ihtiyacim var ???
	
Universite ogrenci numarasi	
2023064120 gibi composite PK dusunelim 
2023 --> ogrencinin kayit oldugu yil
064 --> bolum kodu
120 --> kayit Sirasi

*/


-- Sinav notunun 0-100 arasi olma kontrolu :

CREATE TABLE ogrenciler (
	id integer primary key,
	isim varchar(50),
	adres varchar(100),
	sinav_notu integer CHECK(sinav_notu>0 AND sinav_notu<100)
);

-- Tabloma veri ekleme 
INSERT INTO ogrenciler values(1,'Betul Kuyucu','Istanbul',80);

INSERT INTO ogrenciler (id,isim,adres,sinav_notu) values 
		(2,'Zeki Bey','Izmir', 90),
		(3,'Cemal Dogan','Trabzon',65),
		(4,'Mirac','Bursa',45),
		(5,'Yavuz Bal','Antalya',55);
		
INSERT INTO ogrenciler (id,isim,sinav_notu) values
		(6,'Bilal Degirmen',95),
		(7,'Fahri Ersoz',92);
		
SELECT * FROM ogrenciler;

-- SORU1: ogrenciler tablosundaki id ve isim bilgileri ile tum recordlari getirelim :

SELECT id,isim FROM ogrenciler

-- SORU2: Sinav notu 80'den buyuk olan ogrencilerin tum bilgilerini listele
SELECT * FROM ogrenciler WHERE sinav_notu>80;

-- SORU3: Adresi Ankara olan ogrencilerin tum bilgilerini listele
SELECT * FROM ogrenciler WHERE adres='Ankara';

-- SORU4: Sinav notu 80 ve adresi Istanbul olan ogrenci ismini listele
SELECT isim FROM ogrenciler WHERE adres='Istanbul' AND sinav_notu=80;

-- SORU5: Sinav notu 55 veya 100 olan ogrencilerin tum bilgilerini listele
SELECT * FROM ogrenciler WHERE sinav_notu=55 OR sinav_notu=100;
SELECT * FROM ogrenciler WHERE sinav_notu in (55,100);

-- SORU6: Sinav notu 65 ve 85 arasinda olan ogrencilerin tum bilgilerini listele
SELECT * FROM ogrenciler WHERE sinav_notu between 65 and 85;

-- SORU7: id'si 3 ve 5 arasinda olmayan ogrencilerin isim ve sinav notu listele
SELECT isim,sinav_notu FROM ogrenciler WHERE id not between 3 and 5;

-- SORU8: En yuksek sinav puani nedir
SELECT MAX(sinav_notu) FROM ogrenciler;

-- SORU9: İzmir'de yaşayan ve sınav notu 50'den yuksek olan öğrencilerin listesi:
SELECT * FROM ogrenciler WHERE adres='Izmir' AND sinav_notu>50;

-- SORU10: Öğrenci sayısı ve ortalama sınav notu:
SELECT COUNT(*), AVG(sinav_notu) FROM ogrenciler;
SELECT COUNT(*), ROUND(AVG(sinav_notu),1) FROM ogrenciler;

-- SORU11: sinav_notu 55 olan satiri siliniz
DELETE FROM ogrenciler WHERE sinav_notu=55;

SELECT * from ogrenciler;

-- SORU12: ismi Derya Soylu veya Cemal Dogan olan satirlari siliniz
DELETE FROM ogrenciler WHERE isim='Derya Soylu' OR isim='Cemal Dogan';
DELETE FROM ogrenciler WHERE isim IN('Derya Soylu','Cemal Dogan');

-- SORU13 : Ogrenciler tablosunn icerigini siliniz
DELETE FROM ogrenciler;
TRUNCATE TABLE ogrenciler

--SORU14 : Ogrenciler Tablosunu siliniz
DROP TABLE ogrenciler
