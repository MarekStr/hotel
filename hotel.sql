 IF OBJECT_ID ('dbo.Pobyt', 'U') IS NOT NULL
 DROP TABLE dbo.Pobyt

 IF OBJECT_ID ('dbo.Rezerwacje', 'U') IS NOT NULL
 DROP TABLE dbo.Rezerwacje

 IF OBJECT_ID ('dbo.Uzytkownicy', 'U') IS NOT NULL
 DROP TABLE dbo.Uzytkownicy

 IF OBJECT_ID ('dbo.Goscie', 'U') IS NOT NULL
 DROP TABLE dbo.Goscie

 IF OBJECT_ID ('dbo.Oferty', 'U') IS NOT NULL
 DROP TABLE dbo.Oferty

 IF OBJECT_ID ('dbo.Osoba', 'U') IS NOT NULL
 DROP TABLE dbo.Osoba

 IF OBJECT_ID ('dbo.Pokoje', 'U') IS NOT NULL
 DROP TABLE dbo.Pokoje

 IF OBJECT_ID ('dbo.PrawaDostepu', 'U') IS NOT NULL
 DROP TABLE dbo.PrawaDostepu

 IF OBJECT_ID ('dbo.TypUzytkownika', 'U') IS NOT NULL
 DROP TABLE dbo.TypUzytkownika

 IF OBJECT_ID ('dbo.Zaplata', 'U') IS NOT NULL
 DROP TABLE dbo.Zaplata

 IF OBJECT_ID ('dbo.Adresy', 'U') IS NOT NULL
 DROP TABLE dbo.Adresy

 CREATE TABLE Adresy (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 Panstwo varchar(255) DEFAULT 'Polska' NOT NULL,
 KodPocztowy varchar(6) NOT NULL,
 Miasto varchar(50) NOT NULL,
 Ulica varchar(255) NOT NULL,
 NrMieszkania varchar(5) NOT NULL
 );

 CREATE TABLE Osoba (
 ID int NOT NULL PRIMARY KEY IDENTITY(1,1),
 IDAdresu int NOT NULL FOREIGN KEY REFERENCES Adresy(ID),
 Imie varchar(255) NOT NULL,
 Nazwisko varchar(255) NOT NULL,
 AdresEmail varchar(255) NOT NULL,
 NumerTelefonu varchar(12) NOT NULL
 );

 CREATE TABLE Goscie (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 IDOsoby int NOT NULL FOREIGN KEY REFERENCES Osoba(ID),
 ZalegleOplaty int DEFAULT 0 NOT NULL,
 LacznaLiczbaDniWHotelu int DEFAULT 1 NOT NULL
 );

 CREATE TABLE Pokoje (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 NazwaPokoju varchar(50) DEFAULT 'Pokoj' NOT NULL UNIQUE,
 Cena int NOT NULL, MaxLiczbaGosci int NOT NULL
 );

 CREATE TABLE Oferty (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 IDPokoju int NOT NULL FOREIGN KEY REFERENCES Pokoje(ID),
 DataRozpoczecia datetime DEFAULT getdate() NOT NULL,
 DataZakonczenia datetime DEFAULT getdate()+1 NOT NULL,
 SzczegolyOferty varchar(255) NULL,
 Znizka int DEFAULT -5% NULL,
 RezerwacjeID int NOT NULL
 );

 CREATE TABLE PrawaDostepu (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 PrawoDostepu int NOT NULL UNIQUE,
 Opis varchar(255) NULL
 );

 CREATE TABLE TypUzytkownika (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 Typ INT NULL
 );

 CREATE TABLE Uzytkownicy (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 IDPrawaDostepu int NOT NULL FOREIGN KEY REFERENCES PrawaDostepu(ID),
 IDTypuUzytkownika int NOT NULL FOREIGN KEY REFERENCES TypUzytkownika(ID),
 IDUrzytkownika int not null FOREIGN KEY REFERENCES Osoba(ID)
 );

 CREATE TABLE Zaplata (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 SposobZaplaty varchar(100) NULL
 );

 CREATE TABLE Rezerwacje (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 IDPokoju int NOT NULL FOREIGN KEY REFERENCES Pokoje(ID),
 IDGoscia int NOT NULL FOREIGN KEY REFERENCES Goscie(ID),
 RezerwacjaPotwierdzonaPrzezID int NOT NULL FOREIGN KEY REFERENCES Uzytkownicy(ID),
 IDZaplaty int NOT NULL FOREIGN KEY REFERENCES Zaplata(ID),
 IDOferty int NOT NULL FOREIGN KEY REFERENCES Oferty(ID),
 DataOd datetime DEFAULT getdate() NOT NULL,
 DataDo datetime DEFAULT getdate()+1 NOT NULL,
 IloscDniRezerwacji int NOT NULL,
 Zaliczka int DEFAULT 10% NULL
 );

 CREATE TABLE Pobyt (
 ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 IDRezerwacji int NOT NULL FOREIGN KEY REFERENCES Rezerwacje(ID),
 Uwagi varchar(255) NULL,
 KwotaDoZaplaty int NOT NULL
 );
-- Operacje CRUD oraz widoki bazy danych

 INSERT Adresy (KodPocztowy,Miasto,Ulica,NrMieszkania)
 VALUES ('32-020','Krakow','Jagielonska',123),
 ('55-021','Warszawa','Zabia',1),
 ('12-022','Zakopane','Kotela',132),
 ('31-030','Glogow','Wacka',5343),
 ('12-120','Tarnow','Zbyszka',123),
 ('12-030','Krzeszowice','Gorska',11),
 ('24-541','Sopot','Morska',21),
 ('34-023','Nowy Targ','Rozana',62),
 ('21-340','Wroclaw','Dziwna',83),
 ('35-540','Wieliczka','Wesola',63),
 ('33-540','Krak�w','Wolska',163),
 ('34-123','Tarnowskie G�ry','Romana',62),
 ('24-340','Z�oty potok','Dziwaczna',83),
 ('35-540','Inowrocek','Smutna',63),
 ('33-540','Krak�w','Wolska',163)

 update Adresy
 set KodPocztowy = '12-120'
 where Miasto = 'Tarnow'

 select * from Adresy

 INSERT Osoba (IDAdresu, Imie, Nazwisko, AdresEmail, NumerTelefonu)
 VALUES (1,'Waclaw','Kulala','w.kulala@lsls.com',123123123),
 (2,'Jan','Nowak','J.Now@Onet.com',999999999),
 (3,'Bogdan','Kowalski','Bog.Kowal@Wp.pl',009900123),
 (4,'Anna','Kukulka','Annanana.Kul@G.com',888222123),
 (5,'Piotr','Mazur','Piotr.ma@aol.com',789456125),
 (6,'Marek','Lewandowski','M.Lewandowski@iii.com',454684789),
 (7,'Wojciech','Kowalczyk ','wojckow@Onet.com',999999999),
 (8,'Joanna','Krawczyk','JoannKr@up.pl',009900123),
 (9,'Katarzyna','Nowakowski','KatNowakowski@Gookle.com',888222123),
 (10,'Zbigniew','Sikora','Zb.Sikora@inl.com',892129283),
 (11,'Barbara','Kszot','BarbaraKszot@iii.com',123545789),
 (12,'Kinga','Welflon','Kingawelflon@Onet.com',234657780),
 (13,'Wac�aw','M�otek','Wac�awM�otek@up.pl',347649589),
 (14,'Dariusz','W�jcik','DariuszW�jcik@Gookle.com',293847900),
 (15,'Mietek','Sroka','MietekSroka@inl.com',209843546)

 Update Osoba
 Set AdresEmail = 'x@z.abc'
 where Imie = 'Jan'

 select * from Osoba

 INSERT Goscie (IDOsoby)
 VALUES (3),(4),(5)

 INSERT Pokoje (NazwaPokoju, Cena, MaxLiczbaGosci)
 VALUES ('Zeznia',1000,5),
 ('Stalin',100,2),
 ('Dentysta',5000,3),
 ('101',50,1),
 ('123',70,1),
 ('Kuznia',1000,10),
 ('202',500,2),
 ('404',250,2),
 ('Widokowy',2000,5),
 ('Cieply',300,2),
 ('LuxDelux',8000,4),
 ('Morski',500,3),
 ('Zimny',70,2),
 ('Kwiatowy',900,5),
 ('Drewniany',800,2),
 ('Kamienny',500,2),
 ('Jasny',500,3),
 ('Ciemny',70,2),
 ('Ma��e�ski',900,5),
 ('Sercowy',800,2),
 ('Wodny',500,2)

 delete Pokoje
 where NazwaPokoju = '404'

 update Pokoje
 set MaxLiczbaGosci = 2
 WHERE MaxLiczbaGosci = 1

 insert Oferty (IDPokoju, SzczegolyOferty)
 values (1,'oferta wielkanocna'),
 (2,'oferta wielkanocna'),
 (3,'oferta wielkanocna'),
 (6,'oferta wielkanocna'),
 (5,'oferta wielkanocna')

 update Oferty
 set Znizka = 5
 WHERE Znizka = 0

 select * from Oferty

 INSERT PrawaDostepu (PrawoDostepu, Opis)
 VALUES ('User','Standardowe konto uzytkownika hotelowego'),
 ('Gosc', 'Standardowe konto goscia'),
 ('Admin','Admin systemu'),
 ('Root', 'Super user admin turbo na sterydach')

 alter table PrawaDostepu add UnixSkrot int default 1 check(UnixSkrot = 1 or UnixSkrot = 2 or UnixSkrot =3)

 select * from PrawaDostepu

 INSERT TypUzytkownika (Typ)
 values ('user'),
 ('gosc'),
 ('admin'),
 ('root')

 INSERT Uzytkownicy (IDPrawaDostepu, IDTypuUzytkownika)
 values (1,1),(2,2),(3,3),(4,4)

 INSERT Zaplata (SposobZaplaty)
 values ('Karta'),('Gotowka'),('Ziemniaki'),('Gosc Szefa'),('BitCoin')
 delete Zaplata
 where ID > 6
 select * from Zaplata

 INSERT Rezerwacje (IDPokoju, IDGoscia,RezerwacjaPotwierdzonaPrzezID,IDZaplaty,IDOferty)
 Values (1,1,1,3,1),
 (2,2,1,2,3),
 (3,3,1,4,2)
 select * from Goscie

 update Rezerwacje
 set IDZaplaty = (SELECT ID from Zaplata where SposobZaplaty = 'BitCoin')
 where IDZaplaty = (SELECT ID from Zaplata where SposobZaplaty = 'Ziemniaki')

 select * from Rezerwacje

 Insert Pobyt (IDRezerwacji, Uwagi, KwotaDoZaplaty)
 values (5,'stluczone lustro', 10000),
 (6,'Rozbite TV', 2000),
 (7,'Ukradzony kran', 250)

 update PrawaDostepu
 set UnixSkrot = 1
 where id > 0

 update PrawaDostepu
 set UnixSkrot = 3
 where PrawoDostepu = 'Root' or PrawoDostepu = 'Admin'

-- Procedury

 CREATE PROCEDURE dbo.pRozliczenieByName
 @Imie varchar(255), @Nazwisko varchar(255)
 as
 begin
 if @Imie is null or @Nazwisko is null
 BEGIN
 RAISERROR('NULL values are not allowed', 14, 1)
 RETURN
 end
 select *
 from dbo.vRozliczenia as vr
 where vr.Imie = @Imie and vr.Nazwisko = @Nazwisko
 end

 EXECUTE dbo.pRozliczenieByName 'Bogdan', 'Kowalski'
 select * from vRozliczenia

 CREATE PROCEDURE dbo.pDodajOferte
 @NazwaPokoju varchar(255), @NazwaOferty varchar(255), @Znizka int
 as
 begin
 if @NazwaPokoju is null or @Znizka is null
 BEGIN
 RAISERROR('NULL values are not allowed', 14, 1)
 RETURN
 end
 insert Oferty (IDPokoju, SzczegolyOferty, Znizka)
 values ((
 select id
 from Pokoje as p
 where p.NazwaPokoju = @NazwaPokoju
 ),
 @NazwaOferty,
 @Znizka)
 end

 EXECUTE dbo.pDodajOferte 'LuxDelux', 'Taka sobie oferta nowa', 1
 select * from Oferty

 CREATE PROCEDURE dbo.pAktualizujCenePokoju
 @NazwaPokoju varchar(255), @Cena money
 as
 begin
 if @NazwaPokoju is null or @Cena is null
 BEGIN
 RAISERROR('NULL values are not allowed', 14, 1)
 RETURN
 end
 update Pokoje
 set Cena = @Cena
 where NazwaPokoju = @NazwaPokoju
 end

 EXECUTE dbo.pAktualizujCenePokoju 'LuxDelux', 600
 select * from Pokoje

 Create PROCEDURE dbo.aktualizujAdressOsoby
 @id int, @Miasto varchar(255), @ulica varchar(255)
 as
 begin
 if @id is null or @Miasto is null or @ulica is null
 BEGIN
 RAISERROR('NULL values are not allowed', 14, 1)
 RETURN
 end
 update Adresy
 set Miasto = @Miasto, Ulica = @ulica
 where id = @id
 end

 execute dbo.aktualizujAdressOsoby 1, 'Warszawa', 'Woronicza'
 select * from dbo.Goscie

 Create PROCEDURE dbo.przed�uzPobyt
 @idGo�cua int, @ilo��Dni int
 as
 begin
 if @idGo�cua is null or @ilo��Dni is null
 BEGIN
 RAISERROR('NULL values are not allowed', 14, 1)
 RETURN
 end
 update Goscie
 set LacznaLiczbaDniWHotelu = @ilo��Dni
 where id = @idGo�cua
 end

 execute dbo.przed�uzPobyt 3, 10
 select * from dbo.Goscie

 Create PROCEDURE dbo.dodajuwagiDoPobyty
 @id int, @uwaga varchar(255)
 as
 begin
 if @id is null or @uwaga is null
 BEGIN
 RAISERROR('NULL values are not allowed', 14, 1)
 RETURN
 end
 update Pobyt
 set Uwagi = @uwaga
 where id = @id
 end

 CREATE PROC dbo.Dluznicy
 AS
 BEGIN
 SELECT *
 FROM dbo.Goscie
 WHERE ZalegleOplaty > 0
 END

 EXECUTE dbo.Dluznicy
 select * from Goscie

 CREATE PROCEDURE dbo.pDodajOsobe
 @IDAdresu int, @Imie varchar(255), @Nazwisko varchar(255), @AdresEmail varchar(255), @NumerTelefonu varchar(12)
 as
 begin
 if @IDAdresu is null or @Imie is null or @Nazwisko is null or @AdresEmail is null or @NumerTelefonu is null
 BEGIN
 RAISERROR('NULL values are not allowed', 14, 1)
 RETURN
 end

 insert INTO Osoba (IDAdresu, Imie, Nazwisko, AdresEmail, NumerTelefonu)
 values (@IDAdresu, @Imie, @Nazwisko, @AdresEmail, @NumerTelefonu)

 end

 EXECUTE dbo.pDodajOsobe 12,'John', 'Doe', 'john@doe.com', '112112112'
 select * from Osoba

 CREATE PROCEDURE dbo.pAktualizujZalegleOplaty
 @IDOsoby int, @ZalegleOplaty money
 as
 begin
 if @IDOsoby is null or @ZalegleOplaty is null
 BEGIN
 RAISERROR('NULL values are not allowed', 14, 1)
 RETURN
 end
 update Goscie
 set ZalegleOplaty = @ZalegleOplaty
 where IDOsoby = @IDOsoby
 end

 EXECUTE dbo.pAktualizujZalegleOplaty 3, 100
 select * from Goscie

/* Triggery
W przypadku Triggerów zastosowaliśmy dodatkowe tabele do zbierania logów oraz
procedury wspomagające logowanie operacji, które były uruchamiane bezpośrednio w
trigerach.*/

 create table LOGS(
 ID int not null PRIMARY KEY IDENTITY(1,1),
 date_time datetime not null default GETDATE(),
 log_info varchar(255) not null
 )

 create PROCEDURE dodajLog @log_info varchar(255)
 as
 begin
 if @log_info is null
 BEGIN
 RAISERROR('log musi zawierac informacje o logu! - to chyba oczywiste?! :)', 14, 1)
 RETURN
 end
 insert into LOGS (log_info)
 values
 (
 @log_info
 )
 end

 --Trigger zabezpieczajacy baze danych i tym samym system przed usunieciem administratora lub root-a
 -- oraz o to aby w bazie byl przynajmniej jeden "super user"

 create trigger usunOsobe
 on Osoba
 for delete
 as
 begin
 if (
 (
 select count(*) from deleted
 )
 > 1
 )
 begin
 RAISERROR('Mozna usunac tylko jednego uzytkownika na raz!', 16, 1)
 ROLLBACK TRANSACTION
 end
 if (
 (
 select count(*) from Osoba as o
 inner join Uzytkownicy as u
 on o.ID = u.ID
 inner join TypUzytkownika as t
 on u.IDTypuUzytkownika = t.ID
 where Typ = 'root'
 )
 < 2
 )
 begin
 RAISERROR('To jedyny root w systemie! ~Wyznacz nowego roota przed usunieciem', 16, 1)
 EXEC dodajLog (SELECT '[Fail] nie udana proba usuniecia super usera : jedyny sper user! ' + Imie + ' ' + Nazwisko
as info from Deleted)
 ROLLBACK TRANSACTION
 end
 if (
 (
 select Typ from deleted as o
 inner join Uzytkownicy as u
 on o.ID = u.ID
 inner join TypUzytkownika as t
 on u.IDTypuUzytkownika = t.ID
 )
 = 'admin'
 or
 (
 select Typ from deleted as o
 inner join Uzytkownicy as u
 on o.ID = u.ID
 inner join TypUzytkownika as t
 on u.IDTypuUzytkownika = t.ID
 )
 = 'root'
 )
 begin
 RAISERROR('Nie mozna usunac super uzytkownika', 16, 1)
 EXEC dodajLog (SELECT '[Fail] nie udana proba usuniecia super usera ' + Imie + ' ' + Nazwisko as info from Deleted)
 ROLLBACK TRANSACTION
 end
 EXEC dodajLog (SELECT Imie + ' ' + Nazwisko + ' usuniety z bazy danych' as info from Deleted)
 end

 --Trigger zabezpieczajacy baze danych i tym samym system przed usunieciem administratora lub root-a
 -- oraz o to aby w bazie byl przynajmniej jeden "super user"
 create trigger dodanoPokoj
 on Pokoje
 for insert
 as
 begin
 if (
 (
 select count(*) from inserted
 )
 = 0
 )
 begin
 RAISERROR('musisz dodac przynajmniej jeden pokoj', 16, 1)
 ROLLBACK TRANSACTION
 end
 if (
 (
 select Cena from inserted
 )
 = 0
 )
 begin
 RAISERROR('Cena musi byc wieksza niz 0!', 16, 1)
 ROLLBACK TRANSACTION
 end
 EXEC dodajLog (SELECT 'Dodano pokoj ' + i.NazwaPokoju + ' ' + 'w cenie: ' + i.Cena as info from inserted as i)
 end

 create trigger usunPokoj
 on Pokoje
 for delete
 as
 begin
 if (
 (
 select count(*) from deleted
 )
 > 1
 )
 begin
 RAISERROR('Mozna usunac tylko jeden pokoj na raz!', 16, 1)
 EXEC dodajLog 'probowano usunac wiele pokoji na raz!'
 ROLLBACK TRANSACTION
 end
 if (
 (
 select o.SzczegolyOferty from Oferty as o
 inner join deleted as del
 on o.IDPokoju = del.id
 )
 is not null
 )
 begin
 RAISERROR('Pokoj posiada przypisana oferte specjalna', 16, 1)
 exec dodajLog 'Nieudana proba usuniecia pokoju z oferta specjalna'
 ROLLBACK TRANSACTION
 end
 EXEC dodajLog (SELECT '[Sukces] Usunieto pokoj ' + i.NazwaPokoju + ' ' + 'w cenie: ' + i.Cena as info from inserted as i)
 end

 select * from logs

 create trigger usunAdres
 on Adresy
 for delete
 as
 begin
 if (select count (*) from deleted)>1)
 begin
 RAISERROR('Mozna usunac tylko jeden adres na raz!', 16, 1)
 EXEC dodajLog 'probowano usunac wiele adresow na raz!'
 ROLLBACK TRANSACTION
 end
 end

 create trigger usunGoscia
 on Goscie
 for delete
 as
 begin
 if ( (select COUNT (*) from deleted) >1 )
 begin
 RAISERROR('Mozna usunac tylko jednego goscia na raz!', 16, 1)
 EXEC dodajLog 'probowano usunac wielu gosci na raz!'
 ROLLBACK TRANSACTION
 end

 if ( ( select ZalegleOplaty from Goscie ) > 0 )
 begin
 RAISERROR('Nie mo�na usunac gosica kt�ry ma zalegle oplaty', 16, 1)
 EXEC dodajLog 'probowano usunac goscia ktory ma u nas cos do zaplacenia!'
 ROLLBACK TRANSACTION
 end
 end

 create trigger dodanoOsobe
 on Osoba
 for insert
 as
 begin
 if ( (select COUNT(*) from inserted)=0 )
 begin
 RAISERROR('musisz dodac przynajmniej jedna osobe', 16, 1)
 ROLLBACK TRANSACTION
 end
 if ( ( select len(NumerTelefonu) from inserted ) <9 )
 begin
 RAISERROR('musisz podac poprawny numer telefonu co najmniej 9 cyfr', 16, 1)
 ROLLBACK TRANSACTION
 end
 end

 create TABLE czarna_lista_log(
 id int not null PRIMARY KEY IDENTITY(1,1),
 idGoscia int not null FOREIGN KEY REFERENCES Goscie(ID),
 oCoChodzi VARCHAR(255) not null,
 zaleglosci int default 0
 )

 create PROCEDURE dodajGosciaDoCzarnelListy @email VARCHAR(255), @dlaczego VARCHAR(255)
 as
 BEGIN
 if @email is null or @dlaczego is NULL
 begin
 RAISERROR ('Email i powod sa niezbedne!',14,1)
 ROLLBACK
 END
 insert into czarna_lista_log (idGoscia, oCoChodzi, zaleglosci)
 values (
 (
 select id from Osoba as o where o.AdresEmail = @email
 ),
 @dlaczego,
 (
 select ZalegleOplaty from Goscie as g
 inner join Osoba as o
 on g.id = (
 SELECT id from osoba as o where o.AdresEmail = @email
 )

 )
 )
 end

 create TRIGGER dodajDoCzarnejListy
 on czarna_lista_log
 for insert
 AS
 BEGIN
 if (select count(*) from inserted) > 0
 OR
 (select count(*) from deleted) > 0
 BEGIN
 RAISERROR ('Mozna dodac tylko jedna osobe do czarnej listy na raz!',10,1)
 ROLLBACK TRANSACTION
 end

 if (
 SELECT ZalegleOplaty from Goscie as g
 INNER join inserted as i
 on i.idGoscia = g.IDOsoby
 ) > 0
 begin
 exec dodajLog (
 select 'Dodano do czarnej listy goscia, id: ' + idGoscia +
 ' ,poniewaz: ' + oCoChodzi +
 ' , z zaleglosciami na poziomie: ' + zaleglosci + ' PLN'
 from inserted
 )
 end
 end

 create trigger usunZCzarnejListy @email VARCHAR(255), @dlaczego VARCHAR(@255)
 on czarna_lista_log
 for DELETE
 as
 BEGIN

 if ((select count(*) from deleted)>1)
 BEGIN
 RAISERROR ('Hola hola! pojedynczo usuwamy z czarnej listy! Trzeba wszystko sprawdzic! :)',2,1)
 EXEC dodajLog ('udaremniona proba usuniecia wielu gosci z czarnej listy! uff :D')
 ROLLBACK TRANSACTION
 END

 if ((@email is null) or (@dlaczego is null))
 BEGIN
 RAISERROR ('tak na powaznie? skad mam wiedziec kogo usunac i dlaczego!')
 exec dodajLog ('wykryto bystrego uzytkownika...')
 ROLLBACK TRANSACTION
 end

 END