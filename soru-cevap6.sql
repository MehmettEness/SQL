--------------------------------GROUP BY CLAUSE--------------------------------
CREATE TABLE manavvv
(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);

INSERT INTO manavvv VALUES( 'Ali', 'Elma', 5);
INSERT INTO manavvv VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manavvv VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manavvv VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manavvv VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manavvv VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manavvv VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manavvv VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manavvv VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manavvv VALUES( 'Ayse', 'Uzum', 2);


SELECT * FROM manavvv;

--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.

select isim, sum(urun_miktar) toplam_kg from manavvv
group by isim

--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
--toplam ürün miktarına göre AZALAN sıralayınız.

select isim , sum(urun_miktar) toplam_kg from manavvv 
group by isim
order by toplam_kg desc

--Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralı görüntüleyiniz.

select isim , urun_adi , sum(urun_miktar) toplam_kg from manavvv
group by isim , urun_adi
order by isim

--ürün ismine göre her bir ürünü alan toplam kişi sayısı gösteriniz.
select urun_adi , count(isim) toplam_kisi_sayisi from manavvv
group by urun_adi

--Isme göre alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz

select isim , sum(urun_miktar) , count ( distinct urun_adi) from manavvv
group by isim

--Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sıralayınız.

select urun_miktar , count(distinct isim) musteri_sayisi  from manavvv
group by urun_miktar
order by musteri_sayisi asc

--------------------------------HAVING CLAUSE--------------------------------
--group by ile gruplama yaptıktan sonra geriye döndüreln sonucu filtrelemek istersek having clause kullanıyoruz 

drop table personeller;

CREATE TABLE personeller  (
id int,
isim varchar(50),
sehir varchar(50), 
maas int,  
sirket varchar(20)
);

INSERT INTO personeller VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personeller VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personeller VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personeller VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personeller VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personeller VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personeller VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select*from personeller;

--Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.

select sirket ,  min(maas) min_maas from personeller
group by sirket
having min(maas)>4000

--Maaşı 4000 den fazla olan çalışanlardan, her bir şirketin MIN maas bilgisini görüntüleyiniz.
select sirket , min(maas) min_maas from personeller
where maas>4000
group by sirket

--gruplamadan sonra koşul istiyorsa having kullanırız.
--gruplamadan önce koşul istiyorsa where kullanırız.

--Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.

select isim , sum(maas)  from personeller
group by isim
having sum(maas)>10000
--id isim sehir maas sirket
--Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız

select sehir , count(distinct id) personel_sayisi from personeller
group by sehir
having count(distinct id)>1

--Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.
select sehir , max(distinct maas) from personeller
group by sehir
having max(distinct maas)<5000


--------------------------------------------------UNION--------------------------------------------------
--iki farklı sorgunun sonucunu birleştirerek tek bir sütunda görünütlemeyi sağlar
--tekrar eden degerler var ise bunları göstermez
--union all : union gibi kullanılır ama farklı tekrarlı deger var ise tekrarlı olanlrı da gösterir.


DROP TABLE developerss;

CREATE TABLE developerss(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Abdullah Berk','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Mehmet Cenk','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Han ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Kübra Han','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Muhammed Demir','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Fevzi Kaya','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Enes Can','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Tansu Han','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Said Ran','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Mustafa Pak','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Hakan Tek','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Deniz Çetin','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developerss(name,email,salary,prog_lang,city,age) VALUES('Betül Çetin','ummu@mail.com',4000,'C#','Bursa',29);

---------------------------------------------ilişkili tablolar---------------------------------------------------------

CREATE TABLE contct_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developerss(id)	
);

INSERT INTO contct_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contct_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contct_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contct_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contct_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contct_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contct_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contct_info VALUES(8,'Dev Sok.',8,'Van');


SELECT * FROM developerss;
SELECT * FROM contct_info;

--1--Yaşı 25’den büyük olan developer isimlerini ve 
--2--yaşı 30'dan küçük developerların kullandığı prog. dillerini 
--3--birlikte tekrarsız gösteren sorguyu yaziniz

--1
select name from developerss where age>25 

-3
union

--2
select prog_lang from developerss where age<30


--1--Yaşı 25’den büyük olan developer isimlerini ve 
--2--yaşı 30'dan küçük developerların kullandığı prog. dillerini 
--3--birlikte tekrarlı gösteren sorguyu yaziniz

select name from developerss where age>25 

-3
union all

--2
select prog_lang from developerss where age<30


--Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarsız gösteren sorguyu yaziniz

select salary , prog_lang from developerss where prog_lang='Java'
union
select age , prog_lang from developerss where prog_lang='JavaScript'

--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.

select city , salary from developerss where id=8
union
select city , number from contct_info where address_id=8;

--developerss tablosundaki şehirler ve
--calisanlar53 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz

select city from developerss
union
select sehir from calisanlar53;


------------------------------------------INTERSECT------------------------------------------
--iki farklı sorgunun sonuçlarından ortak olanları(kesişimi)
--tekrarsız olarak gösterir.

--developerss tablosundaki şehirler ve
--calisanlar53 tablosunda sehirlerin
--aynı olanlarını tekrarsız olarak listeleyiniz

select city from developerss
intersect
select sehir from calisanlar53

--developers tablosunda Java kullananların çalıştıkları şehirler ve
--calisanlar3 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
--ortak olanlarını listeleyiniz.

select city from developerss where prog_lang='Java'
intersect
select sehir from calisanlar53 where maas >1000; 


-----------------------------------------------------except----------------------------------------------------- 
--Bir sorgunun sonuclarını, diğer sorgunun sonuclarından farklı olanları gösterir.

--developers tablosundaki şehirleri
--calisanlar3 tablosunda sehirler hariç olarak listeleyiniz

select city from developerss 
except
select sehir from calisanlar53;


--calisanlar3 tablosundaki şehirleri
--developers tablosunda sehirler hariç olarak listeleyiniz

select sehir from calisanlar53
except
select city from developerss
select * from developerss
select * from contct_info

----developers tablosundaki maaşı 4000 den büyük olanların idlerinden
--contact_info tablosunda olmayanları listeleyiniz.
select  id from developerss where salary>4000
except
select address_id from contct_info 




