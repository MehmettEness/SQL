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
select * from calisanlar53 where isyeri=(select marka_isim from markalarrr where marka_id=100);

--INTERVIEW QUESTION:calisanlar53 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

select * from calisanlar53 where maas in (select max(maas) from calisanlar53);

--INTERVIEW QUESTION:calisanlar3 tablosunda ikinci en yüksek maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

	select * from calisanlar53 where maas in (select max(maas) from calisanlar53 where maas<(select max(maas) from calisanlar53));

--calisanlar3 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.
select * from calisanlar53 where maas in(select max(maas) from calisanlar53) or maas in (select min(maas) from calisanlar53);

-- Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.

select marka_id,calisan_sayisi from markalarrr where marka_isim in (select isyeri from calisanlar53 where sehir='Ankara');

--marka_id'si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.

select isim,sehir,maas from calisanlar53 where isyeri in (select marka_isim from markalarrr where marka_id>101);

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.
select isyeri , isim , maas from calisanlar53 where isyeri in    (select marka_isim from markalarrr where calisan_sayisi>15000);

-------------------------------SUBQUERY: SELECT komutundan sonra kullanımı----------------------------------------
-- Her markanin id'sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz

select marka_id , marka_isim, (select count(sehir) as sehir_toplamlari from calisanlar53 where isyeri=marka_isim) from markalarrr 


select distinct (sehir) from calisanlar53; --tekrarsız olarak olan tüm sehirleri gösterir.

create view sehir_toplamlari as select marka_id , marka_isim, (select count(sehir) as sehir_toplamlari from calisanlar53 where isyeri=marka_isim) from markalarrr 
/*bu görünütüyü daha sonrada görüntülemek icin create view eklentisini kullanırız
bu eklenti schemas da view sekmesinde görünütlernir.*/

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum maaşini listeleyen bir Sorgu yaziniz.
select marka_isim , calisan_sayisi , (select max(maas) from calisanlar53 where isyeri=marka_isim) from markalarrr;   


-----------------------------------EXISTS Cond.----------------------------------------------------------------
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.
CREATE TABLE haziran
(     
urun_id int,      
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO haziran VALUES (10, 'Mark', 'Honda');
INSERT INTO haziran VALUES (20, 'John', 'Toyota');
INSERT INTO haziran VALUES (30, 'Amy', 'Ford');
INSERT INTO haziran VALUES (20, 'Mark', 'Toyota');
INSERT INTO haziran VALUES (10, 'Adam', 'Honda');
INSERT INTO haziran VALUES (40, 'John', 'Hyundai');
INSERT INTO haziran VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE aralık 
(     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO aralık  VALUES (10, 'Hasan', 'Honda');
INSERT INTO aralık  VALUES (10, 'Kemal', 'Honda');
INSERT INTO aralık  VALUES (20, 'Ayse', 'Toyota');
INSERT INTO aralık  VALUES (50, 'Yasar', 'Volvo');
INSERT INTO aralık  VALUES (20, 'Mine', 'Toyota');

select * from haziran;
select * from aralık ;

--haziran ayında 'Toyota' satışı yapılmış ise aralık ayındaki tüm ürünlerin bilgilerini listeleyiniz
--exists = koşul belirtir. exists sonra en az bir sonuc var ise true döndürür.

select*from aralık where exists
(select urun_isim from haziran where urun_isim='Toyota')

--haziran ayında volvo satısı yapılmış ise aralık ayındaki tüm ürnlerin bilgilerini listeleyiniz.
select * from aralık where exists 
(select urun_isim from haziran where urun_isim='Volvo') --satış olmamış yani false 

--haziran ayında satilan ürünün urun_id ve musteri_isimlerini eğer aralık ayında da satılmissa listeleyen bir sorgu yazınız

select urun_id , musteri_isim from haziran where exists
(select urun_isim from aralık where aralık.urun_isim=haziran.urun_isim);

---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--aralık ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

select urun_isim , musteri_isim from aralık where exists
(select urun_isim from haziran where haziran.urun_isim=aralık.urun_isim);

--haziran da satılıp aralık da satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--haziran ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
select urun_isim , musteri_isim from haziran where not exists
(select urun_isim from aralık where haziran.urun_isim=aralık.urun_isim);








