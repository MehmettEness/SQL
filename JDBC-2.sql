CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);

INSERT INTO hesaplar VALUES(1234, 'Fred',9500.5);
INSERT INTO hesaplar VALUES(5678, 'Barnie',6500.3);

SELECT * FROM hesaplar;

