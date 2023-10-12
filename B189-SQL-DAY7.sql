--------------DAY'7---------------------
--JOINS--BİRLEŞTİRME
--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.



CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');

CREATE TABLE siparis (
siparis_id int,
sirket_id int,
siparis_tarihi date
);
INSERT INTO siparis VALUES(11, 101, '2023-02-17');  
INSERT INTO siparis VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparis VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparis VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparis VALUES(55, 105, ' 2022-12-21');


--33-INNER JOIN:baz aldığımız sütundaki sadece ortak değerleri gösterir.

--iki tablodaki şirket id'si aynı olanların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.

select sirketler.sirket_id , sirket_isim , siparis_id , siparis_tarihi
from sirketler
inner join siparis -->her ikisinde de olan ortak verileri al dedik 
on sirketler.sirket_id=siparis.sirket_id -->sirketler deki tablomdan sirket_id sütununm ile siparis tablomdaki sirket_id birleştir dedik.

--from siparis
--inner join sirketler  şeklinde de yapabiliriz.

--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz. 

select sirketler.sirket_id , sirket_isim , siparis_id , siparis_tarihi
from sirketler
left join siparis 
on sirketler.sirket_id=siparis.sirket_id


--sipariş tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz. 

select siparis.sirket_id , sirket_isim , siparis_id , siparis_tarihi
from sirketler
right join siparis 
on sirketler.sirket_id=siparis.sirket_id


select siparis.sirket_id , sirket_isim , siparis_id , siparis_tarihi
from siparis
left join sirketler 
on sirketler.sirket_id=siparis.sirket_id

--LEFT ve RIGHT JOIN tablonun sırası değiştirilerek birbirinin yerine kullanılabilir.

--34-LEFT JOIN:Sol tablodaki(ilk tablodaki) tüm verileri getirir.
   --RIGHT JOIN:Sağ tablodaki(ikinci tablodaki) tüm verileri getirir.

   
--35-FULL JOIN:iki tablodaki baz alınan sütundaki tüm kayıtları getirir.

--her iki tablodaki tüm kayıtların tüm bilgilerini listeleyiniz.

select sirketler.sirket_id as sirketler_tablosundaki_id , sirket_isim , siparis.sirket_id as siparis_tablosundaki_id , siparis_id , siparis_tarihi
from siparis
full join sirketler 
on sirketler.sirket_id=siparis.sirket_id







--36-SELF JOIN : tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar. 

CREATE TABLE personeller  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    null);

SELECT * FROM personeller;

--herbir personelin ismi ile birlikte yöneticisinin ismini de veren bir sorgu oluşturunuz.

SELECT p.id,p.isim AS personel,m.id,m.isim AS yonetici
FROM personeller p
INNER JOIN personeller m
ON p.yonetici_id=m.id

--37-LIKE Cond.:WHERE komutu ile kullanılır, 
--Sorgular belirli bir karakter dizisini(desen-pattern) kullanarak filtreleme yapmamızı sağlar
--ILIKE:LIKE gibi ancak CASE INSENSITIVE dir.


CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

SELECT * FROM words;

select * from developers
where name='Enes Can'

--- Tablodaki degeri hatırlamıyorsak yani birkaç harf falan hatırlıyorsak o zaman LIKE kullanırız
--karakter deseni olusturmamız gerekiyor. 3 harfliydi.Şununla başlıyor bununla bitiyor gibi

--wildcard(joker-%): --0 veya daha fazla karakteri temsil eder.

select * from developers
where name like 'E%' -- e ile başlayan tüm sütunları getirir..

select * from developers
where name ilike 'e%' -- küçük büyük harf ayrımı olmaksızın hepsini getirir. I LIKE


--a harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin

select name , city
from developers
where city ilike '%a'

--ismi T ile başalayıp n harfi ile biten dev isimlerini ve maaslarını yazdıran 'QUERY' yazın

select name , salary
from developers
where name like  'T%n'

--Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin
select name salary
from developers
where name like '%an%'

--Ismi içinde e ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin
select * from developers
where name like '%e%' and name like '%a%';

--Ismi içinde önce a sonra e ile biten devlerin tüm bilgilerini yazdiran QUERY yazin

select * from developers
where name like '%a%e%'

--al? harfin başlangıcını hatırlıyorum ama geri kalan tek harfi hatırlamıyorum -->alp mi ali mi ?

--underscore(_): sadece 1 karakteri temsil eder 

--isminin 2.harfi ü olan devlerin tüm bilgilerini yazdıran query yazdırın

select * from developers
where name like '_ü%'

--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin

select * from developers
where prog_lang like '__v_' --sadece java gelir.

--Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin.ÖDEVVV
--HINT:sadece JavaScript olacak
--Isminin 2. harfi e,4. harfi y olan devlerin tum bilgilerini yazdiran QUERY yazin. ÖDEVV
--ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin:ÖDEVVVV

--38-REGEXP_LIKE(~) : Belirli bir karakter deseni içeren datalari regex kullanarak
--filtrelememizi sağlar


--words tablosu ile çalisalım
--[] : içerisindeki harfleden en az birini temsil eder.
--h harfinden sonra a veya i harfini sonra ise t harfini 
--içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.

select * from words
where word ~ 'h[ai]t' --hat ve ahata sonuçları geldi
--küçük büyük harf duyarlılıkları vardır

select * from words
where word ~* 'h[ai]t' --"hat","Hit","hAt","ahata"
--küçük büyük harf duyarlılığı yoktur.

--[-] : iki harf arasındaki  harflerden birini temsil eder

 --h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini  yazdiran QUERY yaziniz.
select * from words
where word ~* 'h[a-k]t'

-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from words
where word ~*  '[mi]'

--^ : başlangıcını gösterir , --$ : kelimenin bitisini gösterir

--a ile başlayan kelimelerin tüm bilgilerini yazdıran query yazdırın

select * from words
where word ~* '^a'

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from words
where word ~* '^[as]'

--m biten kelimelerin tum bilgilerini yazdiran QUERY yazin

select * from words
where word ~* 'm$'

-- (.*)-->0 veya daha fazla karakteri temsil eder
--   . -->sadece 1 karakteri temsil eder

--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^y.*f$'

SELECT *
FROM words
WHERE word ~* '^y(.*)f$'

--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^y.f$'

--NOT LIKE:verilen karakter desenine benzemeyenleri filtreler
-- !~     :verilen karakter desenine benzemeyenleri filtreler

-- ilk harfi h veya H olmayan kelimelerin tum bilgilerini yazdiran QUERY yaziniz.

SELECT *
FROM words 
WHERE word NOT ILIKE 'h%'


SELECT *
FROM words 
WHERE word !~* '^h'

--2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin.ÖDEV


