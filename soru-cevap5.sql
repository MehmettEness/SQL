--CREATE: insert --görünütlemek için
--READ:select -- kayıtları okumak için
--UPDATE:  --güncelleme için
--DELETE:delete -- kayıtları silmek için

------------------------------------------UPDATE------------------------------------------------
--update tablo_adi set sutun_adi=yenideger 				komutu: tablodaki tüm kayıtları günceller -->DML

--update tablo_adi set sutun_adi=yenideger where 		komutu: tablodaki koşulu sağlayan kayıtları günceller -->DML --


select*from calisanlar53;
select*from markalarrr;

--idsi 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz. -- işyeri calisanlar3 de vakko 

update calisanlar53 set isyeri='Trendyol'
where id=123456789;

-- id'si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
--sehirini 'Bursa' olarak güncelleyiniz.

update calisanlar53 set isim ='Veli Yıldırım' , sehir='Bursa'
where id=567890123;

--  markalar tablosundaki marka_id değeri 102 ye eşit veya büyük olanların marka_id'sini 2 ile çarparak değiştirin.

update markalarrr set marka_id=marka_id*2
where marka_id>=102;

-- markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.

update markalarrr set calisan_sayisi= calisan_sayisi + marka_id


--calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.

update calisanlar53 set isyeri= (select isyeri from calisanlar53 where isim='Veli Yıldırım')
where isim ='Ali Seker';

--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
update calisanlar53 set isyeri =sehir || ' Şubesi' where isyeri ='Vakko'





