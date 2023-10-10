--------------DAY'4-------------------
--23-ALIASES: Etiket/Rumuz --> Tabloya veya sütunlara sorgularımızda geçici isim verebiliriz






CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

select* from workers;

select calisan_id from workers;-- başlık calısan?id olarak gözükmekte

select calisan_id as id from workers;--başlık  id olarak gözükmekte bu geçici olarak isimlendirilir.

select calisan_id id from workers;

select calisan_id as id , calisan_isim from workers; 

select calisan_id as id , calisan_isim as isim from workers; 

select calisan_id ||' - ' || calisan_isim as id_isim from workers; --her iki sütunun birleştirir aralrında boşluk koyarak

select *from workers as calisanlar;--tabloyu geçici olarak isimlendirme



--24-SUBQUERY--NESTED QUERY --iç içe sorgu, alt sorgu
--24-a-SUBQUERY: WHERE ile kullanımı

select*from calisanlar3;

select*from markalar;

--marka_id si 100 olan markada çalışanları listeleyiniz.

select marka_isim from markalar where marka_id=100; -- marka_id si 100 olan marka ==vakko
select *from calisanlar3 where isyeri='Vakko'; -- vakkoda calisanlari getirdi

--2.yol
select *from calisanlar3 
where isyeri= (select marka_isim 
			   from markalar              --=> select ile başlayıp id=100 olan kısma kadar olan alana subquery 
			   where marka_id=100)


--INTERVIEW QUESTION:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

select * from calisanlar3 where maas in (select max(maas) from calisanlar3);


--INTERVIEW QUESTION:calisanlar3 tablosunda ikinci en yüksek maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

select max(maas) from calisanlar3 where maas < (select max(maas)from calisanlar3);--3000

--INTERVIEW QUESTION:calisanlar3 tablosunda ikinci en yüksek maaşı alan çalışanın bilgilerini listeleyiniz. 

select* from calisanlar3
where maas in 
(select max(maas) from calisanlar3 where maas < (select max(maas)from calisanlar3));--bu kısım zatenn yukarıda 3000 veriyordu


--calisanlar3 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.

select * from calisanlar3 
where maas=(select max(maas) from calisanlar3) or maas=(select min (maas) from calisanlar3);

-- Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.

select marka_id , calisan_sayisi
from markalar
where marka_isim in(select isyeri from calisanlar3 where sehir='Ankara');

--marka_id'si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.

select isim , sehir , maas 
from calisanlar3
where isyeri in (select marka_isim from markalar where marka_id>101);

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.

select isyeri , isim , maas 
from calisanlar3
where isyeri in (select  marka_isim from markalar where calisan_sayisi>15000);


--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

-- Her markanin id'sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz

select marka_id,marka_isim, 
							(select count(sehir) 
							 from calisanlar3 
							 where isyeri=marka_isim) as sehir_sayisi-- isyeri=marka_isim olunca sırayla marka isimleri değişir.
							 
from markalar;

select sehir from calisanlar3 --tekrar edenleri gösterir

select distinct (sehir) from calisanlar3; --distinct tekrarli olanları saymazz

/*bu görünütüyü daha sonrada görüntülemek icin create view eklentisini kullanırız
bu eklenti schemas da view sekmesinde görünütlernir.*/

create view sehir_sayisi as 
select marka_id,marka_isim, 
							(select count(sehir) 
							 from calisanlar3 
							 where isyeri=marka_isim) as sehir_sayisi
							 
from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum maaşini listeleyen bir Sorgu yaziniz.

select marka_isim , calisan_sayisi , (select max(maas) from calisanlar3 where isyeri=marka_isim) as max_maas
from markalar;


-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minimum maaşini listeleyen bir Sorgu yaziniz.

select marka_isim , calisan_sayisi , (select max(maas) from calisanlar3 where isyeri=marka_isim) as maximum_maas
								   , (select min(maas) from calisanlar3 where isyeri=marka_isim) as minimum_maas --correlated subquery as kosulu oldugu için tek başına çalışmayan tablolara denir.
from markalar;




--25-EXISTS Cond.
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.
CREATE TABLE mart
(     
urun_id int,      
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;


--Mart ayında 'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz
--exists = koşul belirtir. exists sonra en az bir sonuc var ise true döndürür.

select*from nisan 
where exists (select urun_isim from mart where urun_isim='Toyota')

--Mart ayında volvo satısı yapılmış ise nisan ayındaki tüm ürnlerin bilgilerini listeleyiniz.

select*from nisan
where exists (select urun_isim from mart where urun_isim='Volvo')--false oldu yani boş olduu


--Mart ayında satilan ürünün urun_id ve musteri_isimlerini eğer Nisan ayında da satılmissa listeleyen bir sorgu yazınız

select urun_id , musteri_isim from mart
where exists (select urun_isim from nisan where nisan.urun_isim=mart.urun_isim); --corelated bağımlı olan


---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

select urun_isim , musteri_isim from nisan --nisan ayındaki urun isim ve musteri isim getirr

where exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim);  -- bana mart ayındaki ürün isim getir bumart.urun_isim=nisan.urun_isim tablosuna eşit mi 

--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

select urun_isim , musteri_isim from mart--marttaki tüm ürn ve musterileri getirir
where not exists (select urun_isim from nisan where mart.urun_isim=nisan.urun_isim);








