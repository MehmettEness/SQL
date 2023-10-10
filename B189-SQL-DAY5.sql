------------DAY'5-------------


--CREATE: insert --görünütlemek için
--READ:select -- kayıtları okumak için
--UPDATE:  --güncelleme için
--DELETE:delete -- kayıtları silmek için


--26-UPDATE komutu
--update tablo_adi set sutun_adi=yenideger 				komutu: tablodaki tüm kayıtları günceller -->DML

--update tablo_adi set sutun_adi=yenideger where 		komutu: tablodaki koşulu sağlayan kayıtları günceller -->DML --


select*from calisanlar3;
select*from markalar;

--idsi 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz. -- işyeri calisanlar3 de vakko 
update calisanlar3 
set isyeri='Trendyol'
where id =123456789;

-- id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
--sehirini 'Bursa' olarak güncelleyiniz.
update calisanlar3
set isim='Veli Yıldırım'  , sehir='Bursa'
where id=567890123;

--  markalar tablosundaki marka_id değeri 102 ye eşit veya büyük olanların marka_id'sini 2 ile çarparak değiştirin.

update markalar
set marka_id=marka_id*2
where marka_id>=102;

-- markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.

update markalar
set calisan_sayisi=calisan_sayisi+marka_id; --her hangi bir koşul olmadığı için where kullanmıyoruz

--calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.
--calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.
UPDATE calisanlar3
SET isyeri=(SELECT isyeri FROM calisanlar3 WHERE isim='Veli Yıldırım')
WHERE isim='Ali Seker'

--calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.

update calisanlar3
set isyeri=(select marka_isim from markalar where calisan_sayisi>20000)
where maas=1500;

--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
update calisanlar3
set sehir=sehir || ' Şubesi'--yerine koy dedik
where isyeri='Vakko'





--27-IS NULL condition  

CREATE TABLE people
(
ssn char(9),
name varchar(50),
address varchar(50)
);
INSERT INTO people VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO people VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO people (ssn, address) VALUES(456789012, 'Bursa');
INSERT INTO people (ssn, address) VALUES(567890123, 'Denizli');
INSERT INTO people (ssn, name) VALUES(567890123, 'Veli Han');

select*from people;

--people tablosundaki name sütununda NULL olan değerleri listeleyiniz

select * from people 
where name is null

--people tablosundaki adres sütununda NULL olmayan değerleri listleyiniz.


select * from people 
where address is not null

--people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..

update people
set name= 'MISSING...'
where name is null;

update people
set address= 'MISSING...'
where address is null;








--28-ORDER BY-- kayıtlrı belirli bir fiealda göre varsayılan olarak
--natural(artan sıralı olarak ) şekilde sıralar..

CREATE TABLE person
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 

select * from person;

--person tablosundaki tüm kayıtları adrese göre (artan) sıralayarak listeleyiniz.

select * from person
order by adres asc;

--ASC = artarak sıralama

--DESC = azalarak sıralama

--person tablosundaki tüm kayıtları soyisime göre (azalan) sıralayarak listeleyiniz.

select * from person
order by soyisim desc;


--person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.
select*from person
where soyisim='Bulut'
order by isim desc;

--person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz

select * from person
order by isim asc , soyisim desc

--İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.

select isim , soyisim from person
order by length (soyisim) asc;

--3.bir sütunda karakter uzunluğunu görmek istersek

select isim , soyisim, length (soyisim) as karakter_sayisi from person --as ile geçici isim veiyoruz..
order by length (soyisim) asc;

--Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

select isim || ' ' || soyisim ad_soyad --length(isim || soyisim) karakter_sayisi ==bize ayrı bir sütun açıp sayısına bakarız 
from  person
order by length(isim || soyisim);
--order by length (isim) + length (soyisim)

--calisanlar3 tablosunda maaşı ortalama maaştan yüksek olan çalışanların
--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz.

select isim ,sehir , maas 
from calisanlar3
where maas>(select avg(maas) from calisanlar3)  --select avg(maas) from calisanlar3 ( --ortalama maas)
order by maas asc;--maaşa göre artan sıralama











