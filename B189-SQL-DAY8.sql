--------------DAY'8-----------------

SELECT * FROM developers;

SELECT *
FROM developers
WHERE name LIKE 'A%n'


--39-String Fonksiyonlar

SELECT name,LENGTH(name)
FROM developers

--Ayşenur Han değerinde en sonda boşluk var:(

--developers tablosunda name değerlerindeki 
--başlangıç ve sondaki boşlukları kaldırınız.

update developers
set name=trim(name) --name deki boşlukları kaldır.

--developers tablosunda name değerlerinde 'Ayşenur' kelimesini 'Ayşe' ile değiştiririnz.

update developers
set name=replace(name, 'Ayşenur','Ayşe')

--developers tablosundaki tüm kayıtların 
--name değerlerini büyük harfe 
-- prog_lang değerlerinin küçük harfe çevirerek görüntüleyiniz.

select upper (name) , lower (prog_lang)
from developers

select * from calisanlar3;

--calisanlar3 tablosunda isyeri='Vakko' olan kayıtlarda
-- 'Şubesi ' ifadesini siliniz

update calisanlar3
set sehir=substring (sehir,1,length(sehir)-7)  ---1 dediğimiz A harfinden başla --- -7 dediğimiz ise Şubesi ve boşluk sildedik
where  isyeri='Vakko'

--words tablosunda tüm kelimeleri(word) ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.

select initcap(word) from words;

--words tablosunda tüm kelimeleri ve tüm kelimelerin(word) ilk 2 harfini görüntüleyiniz.

select word, substring(word,1,2) from words; --1.indexi al 2 harfi göster

--words tablosunda tüm kelimeleri ve tüm kelimelerin(word)2.indexten itabern kalan  harfleri görüntüleyiniz.

select word, substring(word,2) from words;

--40-Fetch next n row only: -- sadece sıradaki ilk n satırı getirir.
-- 				      limit n:-- sadece sıradaki ilk n satırı getirir.
--					  offset n:--satırı atlayıp sonrakileri getirir.


--developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz

select * from developers
fetch next 3 row only;

--developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.

select * from developers
offset 2                --2 satır atla
fetch next 3 row only; --ilk 3 tanesini getir.

--developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.
--İkiside aynı sonuçları getirir.

select *from developers
order by salary asc
fetch next 3 row only;


select *from developers
order by salary asc
limit 3;

--developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.
select * from developers
order by salary desc
offset 1 --1.kaydı atla
limit 1;  -- 1.getir dedik böylelikle 2.yi getirdi

--41-Alter Table : Tabloyu güncellemek için kullanılır :DDL

alter table calisanlar3 
add column yas int --calisanlar 3 tabloma int girilecek yas tablosu ekle

select * from calisanlar3

--calisanlar3 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
--varsayılan olarak remote değeri TRUE olsun

alter table calisanlar3
add column remote boolean 
default true

--calisanlar3 tablosunda yas sutununu siliniz.
alter table calisanlar3
drop column yas;

--calisanlar3 tablosundaki maas sutununun data tipini real olarak güncelleyiniz.

alter table calisanlar3
alter column maas type real; --maas sütunum int idi. maas sütunumu tipini real olarak yap dedik. Ondalıklı sayilar için

--calisanlar3 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.
alter table calisanlar3
rename column maas to gelir; --rename: değiştir -- column maas: maas tablom --to gelir: gelir ile değiştir

--calisanlar3 tablosunun ismini employees olarak güncelleyiniz.
alter table calisanlar3
rename to employees;

select * from calisanlar3; -- nesne mevcutr değil
select*from employees;

--employees tablomuzdaki id tablosundaki integer degerini varchar(20) yapın

alter table employees
alter column id type varchar(20); 

--employees tablosunda id sütüunun data tipini int olarak tekrar güncelleyiniz
ALTER TABLE employees
ALTER COLUMN id TYPE INT USING id::INT --USING id::INT  buunu yazmazsask uyarı veriyor sil tekrar bak ..

--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.
ALTER TABLE employees
alter column isim set not null

--NOT:içinde kayıtlar bulunan bir tabloyu güncellerken bir sütuna 
--NOT NULL,PK,FK,UNIQUE vs constraintleri ekleyebilmek için önce
--bu sütunların değerleri ilgili const.  sağlıyor olmalı.

--şirketler tablosaunda sirket_id sütununa primary key constrainiti ekleyiniz

select*from sirketler;

alter table sirketler
add primary key (sirket_id);

--sirketler tablosunda sirket_isim sütununa un,que constraşntş ekleyelim

alter table sirketler
add unique (sirket_isim);


--siparis tablosunda sirket_id sütununa FK constraşntş ekleyelim
alter table siparis
add foreign key (sirket_id) references sirketler(sirket_id) -- sirketler tablosunda 104 ve 105 olmadıgı için değiştirmez

select * from siparis; 

-- o yüzden alttaki komutu yazmamız lazım
delete from siparis where sirket_id in (104,105)

--siparis tablosundaki FK constrainti kaldırınız
alter table siparis
drop constraint siparis_sirket_id_fkey -- burada soldaki tabloda key kısmını nasıl yazdıysa o şekilde aynı ismini yazarız 

--42-Transaction : database de en küçün işlem birimi
--       BEGIN:transactionı başlatır
--       COMMIT:transactionı onaylar ve sonlandırır
--       SAVEPOINT: kayıt noktası oluşturur
--       ROLLBACK:değişikleri mevcut duruma geri döndürür,transactionı sonlandırır

CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);

INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);--update: hesaplar tablomdan bakiyeyi değiştir , bakiyeyi 1000 azalt where : kimen hesap nosu 1234 olandan
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);--update: hesaplar tablomdan bakiyeyi değiştir , bakiyeyi 1000 arttır where : kimen hesap nosu 1234 olandan


SELECT * FROM hesaplar;

UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--sistemde hata oluştu. Database çöktü..
--alttaki veri de çalıştırıldı ama database çöktü böylece harry hesabından 1000 eksildi ama jack hesabına 1000 eklenmedi
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;
--veriler tutarsız


SELECT * FROM hesaplar;


--birbirne bağımlı işlemleri tek bir kod ile yapmalıyız 

BEGIN;					--begin : yazdığımızda sol taraftaki listede tablo olusturmaz
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;					--commit: yazdığımızda gözükür kayıt altına alınırı onaylanır.
---------------------------------------------------------------------------------------------------------------------


BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SAVEPOINT x;		--savepoint x : değişiklik yapmadan önce herhangi bir problem olusursa bu başa geri dön dedikk

SELECT * FROM hesaplar;

--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;

--sistemde hata oluştu, catch bloğundan devam

UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--bu işlem başarısız
--veriler tutarsız

COMMIT;
--}catch(hata){
ROLLBACK TO x;		---veriler tutarsızsa rollback to x ile mevcut degerlere geri döneriz  
--}

-----------------------------------pozitif senaryo-----------------------------------------------
--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı

UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı

COMMIT;

--}catch(hata){
ROLLBACK TO x;
--}

SELECT * FROM hesaplar;








