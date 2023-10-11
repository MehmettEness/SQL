-----------------------aliases--> Etiketleme/Rumuz----------------- geçici isim verme
CREATE TABLE workerss(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workerss VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workerss VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workerss VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from workerss 

select calisan_id from workerss;
select calisan_id as calisanlar from workerss; --calisan_id ismini calisanlar olarak geçici değiştirdi

select calisan_isim isim from workerss; --calisan_isim ismii isim olarak  geçici değiştirdi

select calisan_id ||' - ' || calisan_isim as id_isim from workerss;


------------------------SUBQUERY--NESTED QUERY --iç içe sorgu, alt sorgu------------------------------------
---------SUBQUERY: WHERE ile kullanımı-------------

select * from calisanlar53;
select * from markalarrr;

--marka_id si 100 olan markada çalışanları listeleyiniz.
select * from calisanlar53
where isyeri in (select marka_isim from markalarrr where marka_id=100);

--INTERVIEW QUESTION:calisanlar53 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 
select * from calisanlar53 
where maas in (select max(maas) from calisanlar53);

--INTERVIEW QUESTION:calisanlar53 tablosunda ikinci en yüksek maaşı alan çalışanın tüm fieldlarını listeleyiniz.
select max(maas) from calisanlar53 where maas < (select max(maas) from calisanlar53);

--INTERVIEW QUESTION:calisanlar53 tablosunda ikinci en yüksekk maaşı alan çalışanın bilgilerini listeleyiniz.
select * from calisanlar53
where maas in (select max(maas) from calisanlar53 where maas < (select max(maas) from calisanlar53)) ; 

--calisanlar53 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.

select * from calisanlar53
where maas in (select max(maas) from calisanlar53) or maas in (select min(maas) from calisanlar53);

