
----------------------------------------------------------JOINS--BİRLEŞTİRME-------------------------------------------------
--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.



CREATE TABLE sirketleri  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketleri VALUES(100, 'IBM');
INSERT INTO sirketleri VALUES(101, 'GOOGLE');
INSERT INTO sirketleri VALUES(102, 'MICROSOFT');
INSERT INTO sirketleri VALUES(103, 'APPLE');

CREATE TABLE siparisleri (
siparis_id int,
sirket_id int,
siparis_tarihi date
);
INSERT INTO siparisleri VALUES(11, 101, '2023-02-17');  
INSERT INTO siparisleri VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparisleri VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparisleri VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparisleri VALUES(55, 105, ' 2022-12-21');

select * from sirketleri;
select*from siparisleri;


---------------------------INNER JOIN:baz aldığımız sütundaki sadece ortak değerleri gösterir.-----------------------------

--iki tablodaki şirket id'si aynı olanların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.

select sirketleri.sirket_id , sirket_isim , siparis_tarihi ,  siparis_id
from sirketleri
inner join siparisleri

--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz. 

select sirketleri.sirket_id , sirket_isim , siparis_tarihi ,  siparis_id
from sirketleri
left join siparisleri
on sirketleri.sirket_id=siparisleri.sirket_id

--sipariş tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz. 

select siparisleri.sirket_id , sirket_isim , siparis_tarihi ,  siparis_id
from siparisleri
right join sirketleri
on sirketleri.sirket_id=siparisleri.sirket_id

-------------------------LIKE Cond.:WHERE komutu ile kullanılır, --------------------------------------
--Sorgular belirli bir karakter dizisini(desen-pattern) kullanarak filtreleme yapmamızı sağlar
--ILIKE:LIKE gibi ancak CASE INSENSITIVE dir.

CREATE TABLE worrds
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO worrds VALUES (1001, 'hot', 3);
INSERT INTO worrds VALUES (1002, 'hat', 3);
INSERT INTO worrds VALUES (1003, 'Hit', 3);
INSERT INTO worrds VALUES (1004, 'hbt', 3);
INSERT INTO worrds VALUES (1008, 'hct', 3);
INSERT INTO worrds VALUES (1005, 'adem', 4);
INSERT INTO worrds VALUES (1006, 'selim', 6);
INSERT INTO worrds VALUES (1007, 'yusuf', 5);
INSERT INTO worrds VALUES (1009, 'hAt', 3);
INSERT INTO worrds VALUES (1010, 'yaf', 5);
INSERT INTO worrds VALUES (1011, 'ahata', 3);

SELECT * FROM worrds;

select * from developerss where name ='Enes Can'

--wildcard(joker-%): --0 veya daha fazla karakteri temsil eder.

select * from developerss
where name ilike 'e%'-- küçük büyük harf ayrımı olmaksızın hepsini getirir. I LIKE

--a harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin

select name , city 
from developerss
where city ilike '%a'

--ismi T ile başalayıp n harfi ile biten dev isimlerini ve maaslarını yazdıran 'QUERY' yazın
select name , salary
from developerss
where name like 'T%n'

--Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin
select name , salary 
from developerss
where name like '%an%'

--isminin 2.harfi ü olan devlerin tüm bilgilerini yazdıran query yazdırın

select * from developerss
where name like '_ü%'

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin

select * from developerss
where prog_lang like '__v_'


-----------------------REGEXP_LIKE(~) ---------------------------------
-- Belirli bir karakter deseni içeren datalari regex kullanarak
--filtrelememizi sağlar

--[] : içerisindeki harfleden en az birini temsil eder.
--h harfinden sonra a veya i harfini sonra ise t harfini 
--içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.

select * from worrds
where word ~* 'h[ai]t' 
--* küçük büyük harf duyarlılığı yoktur.
--"hat","Hit","hAt","ahata"
--küçük büyük harf duyarlılıkları vardır

--h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini  yazdiran QUERY yaziniz.
select * from worrds
where word ~* 'h[a-k]t'

--^ : başlangıcını gösterir , --$ : kelimenin bitisini gösterir

--a ile başlayan kelimelerin tüm bilgilerini yazdıran query yazdırın

select * from worrds
where word ~* '^a'

--m biten kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from worrds
where word ~* 'm$'

--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin

select * from worrds
where word ~* '^y.f$'




