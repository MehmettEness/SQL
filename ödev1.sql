/*------------------------------------
ÖDEVV:)
1) Tablo Oluşturma

"tedarikciler" isminde bir tablo olusturun,
"tedarikci_id", "tedarikci_ismi", "tedarikci_adres"
ve "ulasim_tarihi"	field'lari olsun. 

2) Var olan tablodan yeni tablo olusturmak 
 "tedarikci_info" isminde bir tabloyu  "tedarikciler" tablosundan olusturun.
Icinde "tedarikci_ismi", "ulasim_tarihi" field'lari olsun

3) Data ekleme
" ogretmenler" isminde tablo olusturun.
 Icinde "kimlik_no", "isim", "brans" ve "cinsiyet" field'lari olsun.
"ogretmenler" tablosuna bilgileri asagidaki gibi olan kisileri ekleyin.
kimlik_no: 234431223, isim: Ayse Guler, brans : Matematik, cinsiyet: kadin.
kimlik_no: 234431224, isim: Ali Guler, brans : Fizik, cinsiyet: erkek.

4) bazı fieldları olan kayıt ekleme
"ogretmenler" tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
kimlik_no: 567597624, isim: Veli Guler
-------------------------------------*/
create table tedarikciler(
tedarikci_id int,
tedarikci_ismi varchar(50),
tedarikci_adres varchar (50),
ulasim_tarihi varchar (50)	
);
select*from tedarikciler;
create table tedarikciler_info as select tedarikci_ismi , ulasim_tarihi from tedarikciler;
select*from tedarikciler_info;
create table ogretmenler(
kimlik_no int,
isim varchar (50),
brans varchar (50),
cinsiyet char (5)	
);
select*from ogretmenler;
insert into ogretmenler values (234431223, 'Ayse Guler' , 'Matematik' , 'kadin');
insert into ogretmenler values (234431224 , 'Ali Guler' , 'Fizik' , 'erkek');
insert into ogretmenler(kimlik_no,isim) values (567597624 , 'Veli Guler');









