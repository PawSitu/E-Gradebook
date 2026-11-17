CREATE TABLE Osoba (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Imie TEXT NOT NULL,
    Nazwisko TEXT NOT NULL,
    Login TEXT NOT NULL UNIQUE,
    Haslo TEXT NOT NULL
);

CREATE TABLE Admin (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    FOREIGN KEY (OsobaId) REFERENCES Osoba(Id)
);

CREATE TABLE Klasa (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Nazwa TEXT NOT NULL
);

CREATE TABLE Uczen (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    OsobaId INTEGER NOT NULL,
    KlasaId INTEGER NOT NULL,
    FOREIGN KEY (OsobaId) REFERENCES Osoba(Id),
    FOREIGN KEY (KlasaId) REFERENCES Klasa(Id)
);

CREATE TABLE Nauczyciel (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    OsobaId INTEGER NOT NULL,
    FOREIGN KEY (OsobaId) REFERENCES Osoba(Id)
);

CREATE TABLE Przedmiot (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Nazwa TEXT NOT NULL
);

CREATE TABLE Zajecia (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    NauczycielId INTEGER NOT NULL,
    PrzedmiotId INTEGER NOT NULL,
    FOREIGN KEY (NauczycielId) REFERENCES Nauczyciel(Id),
    FOREIGN KEY (PrzedmiotId) REFERENCES Przedmiot(Id)
);

CREATE TABLE PlanZajec (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    KlasaId INTEGER NOT NULL,
    ZajeciaId INTEGER NOT NULL,
    DzienTygodnia TEXT NOT NULL CHECK (DzienTygodnia IN ('Poniedzialek','Wtorek','Sroda','Czwartek','Piatek')),
    Godzina TEXT NOT NULL,
    FOREIGN KEY (KlasaId) REFERENCES Klasa(Id),
    FOREIGN KEY (ZajeciaId) REFERENCES Zajecia(Id)
);
CREATE TABLE Frekwencja (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    UczenId INTEGER NOT NULL,
    ZajeciaId INTEGER NOT NULL,
    Data TEXT NOT NULL,
    Status INTEGER NOT NULL,
    FOREIGN KEY (UczenId) REFERENCES Uczen(Id),
    FOREIGN KEY (ZajeciaId) REFERENCES Zajecia(Id)
);
CREATE TABLE Ocena (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Wartosc REAL NOT NULL,
    DataWystawienia TEXT NOT NULL,
    UczenId INTEGER NOT NULL,
    ZajeciaId INTEGER NOT NULL,
    FOREIGN KEY (UczenId) REFERENCES Uczen(Id),
    FOREIGN KEY (ZajeciaId) REFERENCES Zajecia(Id)
);
-- Osoba (Uczniowie / Zmyślone dane)
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (1, 'Zofia', 'Mazurek', 'zofia.mazurek', 'u1');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (2, 'Mikołaj', 'Krawiec', 'mikolaj.krawiec', 'u2');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (3, 'Hanna', 'Bąk', 'hanna.bak', 'u3');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (4, 'Antoni', 'Królikowski', 'antoni.krolikowski', 'u4');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (5, 'Laura', 'Stępień', 'laura.stepien', 'u5');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (6, 'Szymon', 'Wróbel', 'szymon.wrobel', 'u6');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (7, 'Maja', 'Czarnecka', 'maja.czarnecka', 'u7');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (8, 'Aleksander', 'Zieliński', 'aleksander.zielinski', 'u8');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (9, 'Julia', 'Jabłońska', 'julia.jablonska', 'u9');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (10, 'Wojciech', 'Głowacki', 'wojciech.glowacki', 'u10');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (11, 'Alicja', 'Sikora', 'alicja.sikora', 'u11');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (12, 'Kacper', 'Szewczyk', 'kacper.szewczyk', 'u12'); 
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (13, 'Oliwia', 'Rutkowska', 'oliwia.rutkowska', 'u13');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (14, 'Jakub', 'Michalak', 'jakub.michalak', 'u14');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (15, 'Igor', 'Ostrowski', 'igor.ostrowski', 'u15');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (16, 'Michał', 'Tomaszewski', 'michal.tomaszewski', 'u16');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (17, 'Dawid', 'Baran', 'dawid.baran', 'u17');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (18, 'Kamil', 'Marciniak', 'kamil.marciniak', 'u18');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (19, 'Oskar', 'Zając', 'oskar.zajac', 'u19');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (20, 'Julian', 'Dudek', 'julian.dudek', 'u20');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (21, 'Leon', 'Kaczmarek', 'leon.kaczmarek', 'u21');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (22, 'Marcel', 'Borkowski', 'marcel.borkowski', 'u22');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (23, 'Krystian', 'Sokołowski', 'krystian.sokolowski', 'u23');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (24, 'Borys', 'Maciejewski', 'borys.maciejewski', 'u24');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (25, 'Tymon', 'Czajkowski', 'tymon.czajkowski', 'u25');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (26, 'Hubert', 'Górski', 'hubert.gorski', 'u26');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (27, 'Tadeusz', 'Mucha', 'tadeusz.mucha', 'u27');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (28, 'Maksymilian', 'Walczak', 'maksymilian.walczak', 'u28');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (29, 'Miłosz', 'Gąsior', 'milosz.gasior', 'u29');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (30, 'Olaf', 'Szczepański', 'olaf.szczepanski', 'u30');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (31, 'Iwo', 'Włodarczyk', 'iwo.wlodarczyk', 'u31');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (32, 'Eryk', 'Mazurek', 'eryk.mazurek', 'u32');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (33, 'Ksawery', 'Krupa', 'ksawery.krupa', 'u33');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (34, 'Grzegorz', 'Kurek', 'grzegorz.kurek', 'u34');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (35, 'Artur', 'Lis', 'artur.lis', 'u35');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (36, 'Magdalena', 'Błaszczyk', 'magdalena.blaszczyk', 'u36');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (37, 'Karolina', 'Jaworska', 'karolina.jaworska', 'u37');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (38, 'Agata', 'Sobczak', 'agata.sobczak', 'u38');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (39, 'Wiktoria', 'Cieślak', 'wiktoria.cieslak', 'u39');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (40, 'Dominika', 'Gajewska', 'dominika.gajewska', 'u40');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (41, 'Izabela', 'Zakrzewska', 'izabela.zakrzewska', 'u41');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (42, 'Kinga', 'Skowrońska', 'kinga.skowronska', 'u42');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (43, 'Otylia', 'Kozioł', 'otylia.koziol', 'u43');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (44, 'Nadia', 'Kalinowska', 'nadia.kalinowska', 'u44');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (45, 'Roksana', 'Kołodziej', 'roksana.kolodziej', 'u45');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (46, 'Kornelia', 'Młynarczyk', 'kornelia.mlynarczyk', 'u46');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (47, 'Daria', 'Klimek', 'daria.klimek', 'u47');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (48, 'Milena', 'Kaźmierczak', 'milena.kazmierczak', 'u48');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (49, 'Klara', 'Szczepaniak', 'klara.szczepaniak', 'u49');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (50, 'Malwina', 'Laskowska', 'malwina.laskowska', 'u50');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (51, 'Błażej', 'Ziółkowski', 'blazej.ziolkowski', 'u51');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (52, 'Sara', 'Koper', 'sara.koper', 'u52');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (53, 'Lidia', 'Stasiak', 'lidia.stasiak', 'u53');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (54, 'Zuzanna', 'Gołębiewska', 'zuzanna.golebiewska', 'u54');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (55, 'Nina', 'Mucha', 'nina.mucha', 'u55');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (56, 'Pola', 'Czyż', 'pola.czyz', 'u56');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (57, 'Tola', 'Ratajczak', 'tola.ratajczak', 'u57');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (58, 'Marlena', 'Olszewska', 'marlena.olszewska', 'u58');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (59, 'Adrianna', 'Konieczna', 'adrianna.konieczna', 'u59');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (60, 'Dagmara', 'Wojtasiak', 'dagmara.wojtasiak', 'u60');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (61, 'Jadwiga', 'Zaręba', 'jadwiga.zareba', 'u61');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (62, 'Radosław', 'Krzemiński', 'radoslaw.krzeminski', 'u62');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (63, 'Sebastian', 'Wrona', 'sebastian.wrona', 'u63');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (64, 'Anita', 'Banaś', 'anita.banas', 'u64');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (65, 'Bozena', 'Kurek', 'bozena.kurek', 'u65');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (66, 'Emil', 'Dębski', 'emil.debski', 'u66');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (67, 'Ewelina', 'Skiba', 'ewelina.skiba', 'u67');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (68, 'Arkadiusz', 'Bednarczyk', 'arkadiusz.bednarczyk', 'u68');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (69, 'Marta', 'Grzelak', 'marta.grzelak', 'u69');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (70, 'Dorota', 'Sokołowska', 'dorota.sokolowska', 'u70');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (71, 'Daniel', 'Janowski', 'daniel.janowski', 'u71');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (72, 'Sylwia', 'Cieślik', 'sylwia.cieslik', 'u72');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (73, 'Konrad', 'Szymczak', 'konrad.szymczak', 'u73');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (74, 'Oliwier', 'Białek', 'oliwier.bialek', 'u74');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (75, 'Albert', 'Wilk', 'albert.wilk', 'u75');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (76, 'Norbert', 'Żukowski', 'norbert.zukowski', 'u76');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (77, 'Ignacy', 'Kowalik', 'ignacy.kowalik', 'u77');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (78, 'Cezary', 'Gajewski', 'cezary.gajewski', 'u78');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (79, 'Stanisław', 'Kosiński', 'stanislaw.kosinski', 'u79');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (80, 'Kajetan', 'Wesołowski', 'kajetan.wesolowski', 'u80');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (81, 'Monika', 'Kuś', 'monika.kus', 'u81');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (82, 'Fabian', 'Augustyniak', 'fabian.augustyniak', 'u82');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (83, 'Maks', 'Kowalczyk', 'maks.kowalczyk', 'u83');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (84, 'Marika', 'Jasińska', 'marika.jasinska', 'u84');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (85, 'Dorian', 'Makowski', 'dorian.makowski', 'u85');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (86, 'Natan', 'Tomczak', 'natan.tomczak', 'u86');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (87, 'Róża', 'Kubiak', 'roza.kubiak', 'u87');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (88, 'Aurelia', 'Dziedzic', 'aurelia.dziedzic', 'u88');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (89, 'Jerzy', 'Pluta', 'jerzy.pluta', 'u89');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (90, 'Wanda', 'Górska', 'wanda.gorska', 'u90');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (91, 'Jędrzej', 'Bielawski', 'jedrzej.bielawski', 'u91');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (92, 'Lucjan', 'Wojciechowski', 'lucjan.wojciechowski', 'u92');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (93, 'Ryszard', 'Serafin', 'ryszard.serafin', 'u93');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (94, 'Dariusz', 'Drozd', 'dariusz.drozd', 'u94');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (95, 'Krystian', 'Małecki', 'krystian.malecki', 'u95');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (96, 'Waldemar', 'Kasprzak', 'waldemar.kasprzak', 'u96');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (97, 'Zbigniew', 'Gawron', 'zbigniew.gawron', 'u97');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (98, 'Marek', 'Stępień', 'marek.stepien', 'u98');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (99, 'Tomasz', 'Banasiak', 'tomasz.banasiak', 'u99');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (100, 'Sylwester', 'Chmielewski', 'sylwester.chmielewski', 'u100');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (101, 'Marian', 'Michalik', 'marian.michalik', 'u101');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (102, 'Lilianna', 'Grzybowska', 'lilianna.grzybowska', 'u102');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (103, 'Ariel', 'Pająk', 'ariel.pajak', 'u103');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (104, 'Mirosław', 'Szostak', 'miroslaw.szostak', 'u104');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (105, 'Andrzej', 'Mazurek', 'andrzej.mazurek', 'u105');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (106, 'Roman', 'Kot', 'roman.kot', 'u106');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (107, 'Witold', 'Jurek', 'witold.jurek', 'u107');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (108, 'Joachim', 'Prokop', 'joachim.prokop', 'u108');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (109, 'Eustachy', 'Bednarski', 'eustachy.bednarski', 'u109');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (110, 'Gracjan', 'Krupiński', 'gracjan.krupinski', 'u110');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (111, 'Kornel', 'Domagała', 'kornel.domagala', 'u111');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (112, 'Bohdan', 'Gruszka', 'bohdan.gruszka', 'u112');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (113, 'Szczepan', 'Bąkowski', 'szczepan.bakowski', 'u113');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (114, 'Cyprian', 'Nawrocki', 'cyprian.nawrocki', 'u114');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (115, 'Teodor', 'Wojtkowiak', 'teodor.wojtkowiak', 'u115');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (116, 'Feliks', 'Bogusz', 'feliks.bogusz', 'u116');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (117, 'Janusz', 'Majewski', 'janusz.majewski', 'u117');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (118, 'Bogusław', 'Sikorski', 'boguslaw.sikorski', 'u118');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (119, 'Sonia', 'Kaczmarczyk', 'sonia.kaczmarczyk', 'u119');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (120, 'Olgierd', 'Cybulski', 'olgierd.cybulski', 'u120');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (121, 'Blanka', 'Turek', 'blanka.turek', 'u121');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (122, 'Stefan', 'Gołębiowski', 'stefan.golebiowski', 'u122');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (123, 'Leonard', 'Zieliński', 'leonard.zielinski', 'u123');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (124, 'Borysław', 'Zięba', 'boryslaw.zieba', 'u124');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (125, 'Remigiusz', 'Wójtowicz', 'remigiusz.wojtowicz', 'u125');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (126, 'Juliusz', 'Szczepanik', 'juliusz.szczepanik', 'u126');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (127, 'Seweryn', 'Czubak', 'seweryn.czubak', 'u127');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (128, 'Leszek', 'Gaj', 'leszek.gaj', 'u128');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (129, 'Lucjan', 'Wąsowski', 'lucjan.wasowski', 'u129');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (130, 'Bogumił', 'Wasiak', 'bogumil.wasiak', 'u130');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (131, 'Zygmunt', 'Kuźniar', 'zygmunt.kuzniar', 'u131');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (132, 'Miron', 'Mroczek', 'miron.mroczek', 'u132');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (133, 'Florian', 'Piątek', 'florian.piatek', 'u133');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (134, 'Teresa', 'Dec', 'teresa.dec', 'u134');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (135, 'Gerard', 'Kozioł', 'gerard.koziol', 'u135');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (136, 'Józef', 'Skiba', 'jozef.skiba', 'u136');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (137, 'Kaja', 'Szyszka', 'kaja.szyszka', 'u137');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (138, 'Gwidon', 'Sobczak', 'gwidon.sobczak', 'u138');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (139, 'Amelia', 'Piasecka', 'amelia.piasecka', 'u139');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (140, 'Ida', 'Tarnowska', 'ida.tarnowska', 'u140');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (141, 'Malina', 'Trzcińska', 'malina.trzcinska', 'u141');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (142, 'Róża', 'Olszewska', 'roza.olszewska', 'u142');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (143, 'Bronisław', 'Sowa', 'bronislaw.sowa', 'u143');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (144, 'Apoloniusz', 'Włodarczyk', 'apoloniusz.wlodarczyk', 'u144');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (145, 'Lech', 'Wroński', 'lech.wronski', 'u145');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (146, 'Xawery', 'Puchalski', 'xawery.puchalski', 'u146');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (147, 'Korneliusz', 'Zaremba', 'korneliusz.zaremba', 'u147');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (148, 'Wacław', 'Janik', 'waclaw.janik', 'u148');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (149, 'Bianka', 'Czerwińska', 'bianka.czerwinska', 'u149');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (150, 'Edward', 'Markiewicz', 'edward.markiewicz', 'u150');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (151, 'Bernard', 'Malinowski', 'bernard.malinowski', 'u151');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (152, 'Amadeusz', 'Stępień', 'amadeusz.stepien', 'u152');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (153, 'Dionizy', 'Maj', 'dionizy.maj', 'u153');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (154, 'Emanuel', 'Kłos', 'emanuel.klos', 'u154');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (155, 'Jonasz', 'Nowicki', 'jonasz.nowicki', 'u155');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (156, 'Alojzy', 'Tomczyk', 'alojzy.tomczyk', 'u156');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (157, 'Ludwik', 'Dąbek', 'ludwik.dabek', 'u157');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (158, 'Maksym', 'Cieślar', 'maksym.cieslar', 'u158');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (159, 'Kalina', 'Kalinowska', 'kalina.kalinowska', 'u159');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (160, 'Gabriel', 'Sobolewski', 'gabriel.sobolewski', 'u160');

-- Nauczyciele (Zmyślone dane)
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (161, 'Marcin', 'Szymański', 'marcin.szymanski', 'u161');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (162, 'Justyna', 'Liszowska', 'justyna.liszowska', 'u162');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (163, 'Iwona', 'Krakowska', 'iwona.krakowska', 'u163');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (164, 'Piotr', 'Konieczny', 'piotr.konieczny', 'u164');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (165, 'Maciej', 'Polak', 'maciej.polak', 'u165');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (166, 'Marta', 'Kołodziejczyk', 'marta.kolodziejczyk', 'u166');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (167, 'Karol', 'Szewczyk', 'karol.szewczyk', 'u167');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (168, 'Agnieszka', 'Leśniak', 'agnieszka.lesniak', 'u168');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (169, 'Dominik', 'Mika', 'dominik.mika', 'u169');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (170, 'Halina', 'Krupińska', 'halina.krupinska', 'u170');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (171, 'Barbara', 'Urbaniak', 'barbara.urbaniak', 'u171');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (172, 'Edyta', 'Wasiak', 'edyta.wasiak', 'u172');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (173, 'Rafał', 'Musiał', 'rafal.musial', 'u173');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (174, 'Jan', 'Turek', 'jan.turek', 'u174');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (175, 'Ewa', 'Kaczmarczyk', 'ewa.kaczmarczyk', 'u175');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (176, 'Krystyna', 'Lis', 'krystyna.lis', 'u176');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (177, 'Mateusz', 'Żak', 'mateusz.zak', 'u177');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (178, 'Tomasz', 'Dziedzic', 'tomasz.dziedzic', 'u178');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (179, 'Paweł', 'Krupa', 'pawel.krupa', 'u179');
INSERT INTO Osoba (Id, Imie, Nazwisko, Login, Haslo) VALUES (180, 'Sylwia', 'Górska', 'sylwia.gorska', 'u180');



-- Klasa
INSERT INTO Klasa (Id, Nazwa) VALUES (1, '1A');
INSERT INTO Klasa (Id, Nazwa) VALUES (2, '1B');
INSERT INTO Klasa (Id, Nazwa) VALUES (3, '2A');
INSERT INTO Klasa (Id, Nazwa) VALUES (4, '2B');
INSERT INTO Klasa (Id, Nazwa) VALUES (5, '3A');
INSERT INTO Klasa (Id, Nazwa) VALUES (6, '3B');
INSERT INTO Klasa (Id, Nazwa) VALUES (7, '4A');
INSERT INTO Klasa (Id, Nazwa) VALUES (8, '4B');

-- Uczen
-- 1A
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (1, 1, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (2, 2, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (3, 3, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (4, 4, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (5, 5, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (6, 6, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (7, 7, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (8, 8, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (9, 9, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (10, 10, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (11, 11, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (12, 12, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (13, 13, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (14, 14, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (15, 15, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (16, 16, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (17, 17, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (18, 18, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (19, 19, 1);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (20, 20, 1);
-- 1B
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (21, 21, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (22, 22, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (23, 23, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (24, 24, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (25, 25, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (26, 26, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (27, 27, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (28, 28, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (29, 29, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (30, 30, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (31, 31, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (32, 32, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (33, 33, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (34, 34, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (35, 35, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (36, 36, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (37, 37, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (38, 38, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (39, 39, 2);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (40, 40, 2);

-- 2A
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (41, 41, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (42, 42, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (43, 43, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (44, 44, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (45, 45, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (46, 46, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (47, 47, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (48, 48, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (49, 49, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (50, 50, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (51, 51, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (52, 52, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (53, 53, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (54, 54, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (55, 55, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (56, 56, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (57, 57, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (58, 58, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (59, 59, 3);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (60, 60, 3);

-- 2B
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (61, 61, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (62, 62, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (63, 63, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (64, 64, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (65, 65, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (66, 66, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (67, 67, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (68, 68, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (69, 69, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (70, 70, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (71, 71, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (72, 72, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (73, 73, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (74, 74, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (75, 75, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (76, 76, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (77, 77, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (78, 78, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (79, 79, 4);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (80, 80, 4);

-- 3A
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (81, 81, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (82, 82, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (83, 83, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (84, 84, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (85, 85, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (86, 86, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (87, 87, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (88, 88, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (89, 89, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (90, 90, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (91, 91, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (92, 92, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (93, 93, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (94, 94, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (95, 95, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (96, 96, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (97, 97, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (98, 98, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (99, 99, 5);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (100, 100, 5);

-- 3B
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (101, 101, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (102, 102, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (103, 103, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (104, 104, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (105, 105, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (106, 106, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (107, 107, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (108, 108, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (109, 109, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (110, 110, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (111, 111, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (112, 112, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (113, 113, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (114, 114, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (115, 115, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (116, 116, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (117, 117, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (118, 118, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (119, 119, 6);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (120, 120, 6);

-- 4A
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (121, 121, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (122, 122, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (123, 123, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (124, 124, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (125, 125, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (126, 126, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (127, 127, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (128, 128, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (129, 129, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (130, 130, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (131, 131, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (132, 132, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (133, 133, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (134, 134, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (135, 135, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (136, 136, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (137, 137, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (138, 138, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (139, 139, 7);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (140, 140, 7);

-- 4B
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (141, 141, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (142, 142, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (143, 143, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (144, 144, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (145, 145, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (146, 146, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (147, 147, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (148, 148, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (149, 149, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (150, 150, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (151, 151, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (152, 152, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (153, 153, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (154, 154, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (155, 155, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (156, 156, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (157, 157, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (158, 158, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (159, 159, 8);
INSERT INTO Uczen (Id, OsobaId, KlasaId) VALUES (160, 160, 8);


-- Nauczyciel
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (1, 161);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (2, 162);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (3, 163);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (4, 164);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (5, 165);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (6, 166);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (7, 167);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (8, 168);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (9, 169);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (10, 170);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (11, 171);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (12, 172);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (13, 173);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (14, 174);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (15, 175);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (16, 176);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (17, 177);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (18, 178);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (19, 179);
INSERT INTO Nauczyciel (Id, OsobaId) VALUES (20, 180);


-- Przedmiot
INSERT INTO Przedmiot (Id, Nazwa) VALUES (1, 'Matematyka');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (2, 'Polski');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (3, 'Fizyka');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (4, 'Chemia');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (5, 'Biologia');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (6, 'Historia');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (7, 'WF');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (8, 'Informatyka');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (9, 'Angielski');
INSERT INTO Przedmiot (Id, Nazwa) VALUES (10, 'Geografia');

-- Zajecia (kto czego uczy)
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (1, 1, 1);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (2, 2, 2);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (3, 3, 3);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (4, 4, 4);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (5, 5, 5);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (6, 6, 6);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (7, 7, 7);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (8, 8, 8);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (9, 9, 9);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (10, 10, 10);

INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (11, 11, 1);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (12, 12, 2);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (13, 13, 3);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (14, 14, 4);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (15, 15, 5);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (16, 16, 6);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (17, 17, 7);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (18, 18, 8);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (19, 19, 9);
INSERT INTO Zajecia (Id, NauczycielId, PrzedmiotId) VALUES (20, 20, 10);


-- PlanZajec
-- 1A
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (1,1,1,'Poniedzialek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (2,1,2,'Poniedzialek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (3,1,3,'Poniedzialek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (4,1,4,'Wtorek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (5,1,5,'Wtorek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (6,1,6,'Sroda','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (7,1,7,'Sroda','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (8,1,8,'Czwartek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (9,1,9,'Czwartek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (10,1,10,'Piatek','10:15');
-- 1B
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (11,2,11,'Poniedzialek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (12,2,12,'Poniedzialek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (13,2,13,'Poniedzialek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (14,2,14,'Wtorek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (15,2,15,'Wtorek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (16,2,16,'Sroda','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (17,2,17,'Sroda','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (18,2,18,'Czwartek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (19,2,19,'Czwartek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (20,2,20,'Piatek','10:15');
-- 2A
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (21,3,1,'Poniedzialek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (22,3,2,'Poniedzialek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (23,3,,'Wtorek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (24,3,,'Wtorek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (25,3,,'Wtorek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (26,3,,'Sroda','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (27,3,,'Sroda','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (28,3,,'Czwartek','13:45');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (29,3,,'Piatek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (30,3,,'Piatek','12:00');
-- 2B
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (31,4,11,'Poniedzialek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (32,4,12,'Poniedzialek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (33,4,13,'Wtorek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (34,4,14,'Wtorek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (35,4,15,'Wtorek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (36,4,16,'Sroda','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (37,4,17,'Sroda','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (38,4,18,'Czwartek','13:45');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (39,4,19,'Piatek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (40,4,20,'Piatek','12:00');
-- 3A
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (41,5,1,'Poniedzialek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (42,5,2,'Wtorek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (43,5,3,'Wtorek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (44,5,4,'Sroda''10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (45,5,5,'Sroda','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (46,5,6,'Czwartek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (47,5,7,'Czwartek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (48,5,8,'Piatek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (49,5,9,'Piatek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (50,5,10,'Piatek','13:45');
-- 3B
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (51,6,1,'Poniedzialek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (52,6,2,'Wtorek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (53,6,3,'Wtorek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (54,6,4,'Sroda','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (55,6,5,'Sroda','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (56,6,6,'Czwartek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (57,6,7,'Czwartek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (58,6,8,'Piatek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (59,6,9,'Piatek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (60,6,10,'Piatek','13:45');
-- 4A
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (61,7,11,'Poniedzialek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (62,7,12,'Poniedzialek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (63,7,13,'Wtorek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (64,7,14,'Sroda','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (65,7,15,'Czwartek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (66,7,16,'Czwartek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (67,7,17,'Czwartek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (68,7,18,'Piatek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (69,7,19,'Piatek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (70,7,20,'Piatek','13:45');
-- 4B
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (71,8,1,'Poniedzialek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (72,8,2,'Poniedzialek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (73,8,3,'Wtorek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (74,8,4,'Sroda','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (75,8,5,'Czwartek','8:30');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (76,8,6,'Czwartek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (77,8,7,'Czwartek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (78,8,8,'Piatek','10:15');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (79,8,9,'Piatek','12:00');
INSERT INTO PlanZajec (Id, KlasaId, ZajeciaId, DzienTygodnia, Godzina) VALUES (80,8,10,'Piatek','13:45');



-- Frekwencja
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (1, 1, '2025-06-10', 1);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (2, 1, '2025-06-10', 0);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (3, 2, '2025-06-10', 1);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (4, 3, '2025-06-10', 1);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (5, 4, '2025-06-10', 0);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (6, 5, '2025-06-10', 1);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (7, 5, '2025-06-10', 1);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (8, 6, '2025-06-10', 1);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (9, 7, '2025-06-10', 0);
INSERT INTO Frekwencja (UczenId, ZajeciaId, Data, Status) VALUES (10, 8, '2025-06-10', 1);
-- Ocena
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (1, 2.0, '2024-05-08', 1, 1);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (2, 3.0, '2024-05-09', 2, 2);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (3, 4.0, '2024-05-10', 3, 3);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (4, 5.0, '2024-05-11', 4, 4);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (5, 2.0, '2024-05-12', 5, 5);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (6, 3.0, '2024-05-13', 1, 6);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (7, 4.5, '2024-05-14', 2, 7);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (8, 5.0, '2024-05-15', 3, 8);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (9, 2.5, '2024-05-16', 4, 9);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (10, 3.5, '2024-05-17', 5, 10);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (11, 4.5, '2024-05-18', 1, 1);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (12, 5.5, '2024-05-19', 2, 2);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (13, 2.5, '2024-05-20', 3, 3);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (14, 3.5, '2024-05-21', 4, 4);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (15, 4.5, '2024-05-22', 5, 5);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (16, 5.5, '2024-05-23', 1, 6);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (17, 2.5, '2024-05-24', 2, 7);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (18, 3.5, '2024-05-25', 3, 8);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (19, 4.5, '2024-05-26', 4, 9);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (20, 5.5, '2024-05-27', 5, 10);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (21, 2.5, '2024-05-08', 1, 1);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (22, 3.5, '2024-05-09', 2, 2);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (23, 4.5, '2024-05-10', 3, 3);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (24, 5.5, '2024-05-11', 4, 4);
INSERT INTO Ocena (Id, Wartosc, DataWystawienia, UczenId, ZajeciaId) VALUES (25, 2.5, '2024-05-12', 5, 5);