-- Officine
INSERT INTO public.officine
(max_veicoli, via, citta, cap, civico)
VALUES(5, 'Via Garavini', 'Russi', '48026', 102),
    (4, 'Via Brombeis', 'Napoli', '48125', 124),
    (10, 'Viale Randi', 'Cesena', '47522', 32),
    (4, 'Via Mario Rossi', 'Rimini', '43202', 154),
    (6, 'Viale Marcopolo', 'Bologna', '24320', 234);

-- Marchi
INSERT INTO public.marchi
(nomeMarchio)
VALUES('Mercedes'),
    ('Audi'),
    ('Volkswagen'),
    ('Fiat'),
    ('Peugeot'),
    ('Volvo'),
    ('Hyundai'),
    ('Ducati'),
    ('BMW'),
    ('Citroen'),
    ('Iveco'),
    ('Skoda'),
    ('Piaggio'),
    ('Ford'),
    ('Yamaha');

-- Veicoli
-- 1 Auto 2 Moto 3 Autocarro
INSERT INTO public.veicoli
(targa, anno, modello, tipo, nomeMarchio)
VALUES('BR243CD', 2001, '206', 1, 'Peugeot'),
    ('GD243DW', 2020, 'A3', 1, 'Audi'),
    ('GH222AB', 2021, 'XC60', 1, 'Volvo'),
    ('DC223AD', 2007, 'I20', 1, 'Hyundai'),
    ('ER142GT', 2012, '208 GTI', 1, 'Peugeot'),
    ('FC231GR', 2017, '500X', 1,'Fiat'),
    ('FP126BV', 2018, '308', 1, 'Peugeot'),
    ('EN89756', 2015, 'R1', 2, 'Yamaha'),
    ('GE872PS', 2020, '208', 1, 'Peugeot'),
    ('DE789KE', 2010, 'Puma', 1, 'Ford'),
    ('CF004SA', 2007, 'I10', 1, 'Hyundai'),
    ('GE872FK', 2003, 'Kuga', 1, 'Ford'),
    ('GE872OP', 2005, 'Golf', 1, 'Volkswagen'),
    ('GE872UR', 2014, '500', 1, 'Fiat'),
    ('GE872SL', 2013, 'Grande Punto', 1, 'Fiat'),
    ('GE872CC', 2014, 'Tracer 7', 2, 'Yamaha'),
    ('GE872FU', 2010, 'R7', 2, 'Yamaha'),
    ('GE872TR', 2019, 'Panda', 1, 'Fiat'),
    ('GE872GZ', 2018, 'Scala', 1, 'Skoda'),
    ('GE872CX', 2016, 'A4', 1, 'Audi'),
    ('GE872BN', 2016, 'Focus', 1, 'Ford'),
    ('GE872MN', 2013, 'Xsara', 1, 'Citroen'),
    ('GE872FF', 2020, 'Octavia', 1, 'Skoda'),
    ('GE872SM', 2021, 'Mustang', 1, 'Ford'),
    ('GE872TV', 2001, 'Santa Fe', 1, 'Hyundai');

-- Clienti
INSERT INTO public.clienti
(cognome, nome, codice_fiscale, telefono, email)
VALUES('Sternini', 'Marco', 'STRMRC67M42H753K', '3420476702', 'marco@email.it'),
    ('Saccomandi', 'Chiara', 'SCCCHR67M42H753K', '3339234291', 'chiara@email.it'),
    ('Rossi', 'Lorenzo', 'RSSLNZ77D06D720H', '3453929921', 'lorenzo@email.it'),
    ('Babini', 'Anna', 'BBNNNA99R24L049K', '3705874112', 'anna@email.it'),
    ('Montanari', 'Francesca', 'MNTFNC82C07L424Q', '3665884785', 'francesca@email.it'),
    ('Ferretti', 'Irene', 'FRRRNI90A05F704T', '3387415233', 'irene@email.it'),
    ('Lorenzini', 'Sara', 'LRNSRA95D30A944I', '3284756122', 'sara@email.it'),
    ('Fabbri', 'Maria', 'FBBMRA84P17L378S', '3397512899', 'maria@email.it'),
    ('Siviglia', 'Alessia', 'SVGLSS98E14B519R', '3485874058', 'alessia@email.it'),
    ('Storti', 'Adriano', 'STRDRN96T07H501L', '3258974221', 'adriano@email.it'),
    ('Baglio', 'Giuseppe', 'BGLGPP00B21D612J', '3357984562', 'giuseppe@email.it'),
    ('Poretti', 'Leonardo', 'PRTLRD87H11G702Y', '3561253479', 'leonardo@email.it'),
    ('Miccoli', 'Antonio', 'MCCNTN64B04G478E', '3571456287', 'antonio@email.it'),
    ('Buonadonna','Roberto','BNDRRT02R15G273K','3314587988', 'roberto@email.it');

INSERT INTO public.clienti
(cognome, nome, codice_fiscale, email, nome_azienda, telefono)
VALUES('Nardi', 'Massimo', 'NRDMSM34T02E798D', 'nmassim@gmail.com', 'Resoft s.r.l', '3124325430'),
    ('Vuksan', 'Tiziano', 'VKSTZN58H02C001D', 'tvuksan@hotmail.it', 'Astim s.r.l', '3248321329'),
    ('Maiorca', 'Sofia', 'MRCSFO05B03G337B', 'msofia@live.it','Benassi s.r.l', '3331928328');


-- Dipendenti
INSERT INTO public.dipendenti
(cognome, nome, codice_fiscale, telefono, email)
VALUES('Rossi', 'Mario', 'RSSRRT81P15H294T', '3353678026', 'mario@cars.it'),
    ('Verdi', 'Gennaro', 'VRDGNR03E04L219H', '3941686851', 'gennaro@cars.it'),
    ('Sintoni', 'Samuele', 'SNTSML75T03A390Q', '3703529927', 'samuele@cars.it'),
    ('Pierantoni', 'Veronica', 'PRNVNC04M60A089N', '3389974396', 'veronica@cars.it'),
    ('Gardini', 'Enrico', 'GRDNRC77L68F839H', '3752480360', 'enrico@cars.it'),
    ('Fornari', 'Riccardo', 'FRNRCR89P44B180N', '3484569141', 'riccardo@cars.it'),
    ('Doe', 'John', 'DOEJHN85D25Z114U', '3917407356', 'john@cars.it'),
    ('Verrati', 'Lucia', 'VRRLCU73E30A271M', '3124354234', 'lucia@cars.it'),
    ('Bezzi', 'Filippo', 'BZZFPP98T23F052J', '3608125794', 'filippo@cars.it'),
    ('Chiari', 'Federico', 'CHRFRC00T01B963H', '3542519616', 'federico@cars.it'),
    ('Bianchi', 'Alice', 'BNCLCA01T06D086O', '3536229669', 'alice@cars.it'); 

-- Tipo servizi
INSERT INTO public.tipo_servizi
(tariffa, nomeTipo)
VALUES (20, 'Tagliando'),
    (35, 'Riparazione meccanica'),
    (40, 'Riparazione elettronica');

-- Servizi
INSERT INTO public.servizi
(tempo_stimato, descrizione, data_servizio, ora, idofficina, idcliente, nomeTipo, targa)
VALUES(1, 'Kilometraggio corrente: 140.000km', '12/08/2022', '15:00', 1, 1, 'Tagliando', 'BR243CD'),
    (1, 'Kilometraggio corrente: 50.000km', '12/08/2022', '13:00', 1, 5, 'Tagliando', 'BR243CD'),
    (2, 'Rumore strano alla partenza', '10/08/2022', '9:00', 1, 2, 'Riparazione meccanica', 'GD243DW'),
    (1, 'Sostituzione radiatore', '11/08/2022', '8:00', 1, 4, 'Riparazione meccanica', 'DC223AD'),
    (3, 'Cambio marmitta', '11/08/2022', '9:00', 1, 13, 'Riparazione meccanica', 'ER142GT'),
    (1, 'Cambio filtro olio', '12/08/2022', '8:00', 2, 10, 'Riparazione meccanica', 'GE872OP'),
    (2, 'Sostituzione iniettori', '12/08/2022', '9:00', 1, 7, 'Riparazione meccanica', 'GE872FF'),
    (5, 'Sostituzione trasmissione', '13/08/2022', '10:00', 1, 8, 'Riparazione meccanica', 'GE872FK'),
    (2, 'Pulizia filtri del gas', '13/08/2022', '8:00', 1, 3, 'Riparazione meccanica', 'GE872CX'),
    (1, 'Sostituzione fari anteriori', '14/08/2022', '8:00', 1, 12, 'Riparazione elettronica', 'DE789KE'),
    (1, 'Sostituzione fari posteriori', '14/08/2022', '10:00', 1, 11, 'Riparazione elettronica', 'EN89756'),
    (2, 'Controllo centralina elettrica', '16/08/2022', '8:00', 2, 6, 'Riparazione elettronica', 'FP126BV');

-- Assegnazioni
INSERT INTO public.assegnazioni
(iddipendente, idservizio)
VALUES(1, 1),
    (2, 1),
    (4, 2),
    (2, 3);

-- Classe Componenti
INSERT INTO public.classe_componenti
(codiceean, nome, marca, prezzo)
VALUES('978020137962', 'Filtro Aria', 'Soft tech', 10.50),
    ('973020137962', 'Freni a disco', 'Brake Tech', 35.00),
    ('938022117962', '1kg olio motore', 'Castrol', 17.80),
    ('978040155962', 'Freni a disco', 'Peugeot', 55.99),
    ('975740137922', 'Liquido refrigerante', 'Vuter', 9.99),
    ('918027187962', 'Filtro olio', 'Castrol', 22.50);

-- Componenti utilizzati
INSERT INTO public.componenti
(seriale, codiceean, idservizio, idofficina)
VALUES('1425332', '978020137962', 1, 1),
    ('1435672', '938022117962', 1, 1),
    ('1231232', '938022117962', 2, 2);

-- Componenti in magazzino
INSERT INTO public.componenti
    (seriale, codiceean, idofficina)
VALUES('1425432', '978020137962', 1),
    ('1425232', '978020137962', 1),
    ('1435442', '975740137922', 1),
    ('1425242', '973020137962', 2),
    ('1725436', '973020137962', 2),
    ('1435632', '918027187962', 1),
    ('1325672', '918027187962', 1),
    ('1225432', '978040155962', 2),
    ('1416432', '978040155962', 2),
    ('1423477', '938022117962', 2);

-- Lavori
INSERT INTO public.lavori
(iddipendente, data_assunzione, idofficina)
VALUES(1, '23/02/2020', 1),
    (2, '10/04/2018', 1),
    (3, '10/04/2018', 1),
    (4, '23/02/2020', 1),
    (5, '07/11/2019', 1),
    (6, '10/04/2018', 1),
    (7, '23/02/2020', 1),
    (8, '07/11/2019', 3),
    (9, '23/02/2020', 3),
    (10, '07/11/2019', 4),
    (11, '07/11/2019', 5);

-- Esiti
INSERT INTO public.esiti
(idservizio, eseguito, data_chiusura, descrizione, importo)
VALUES(2, true, '11/08/2022', 'Rabbocco di olio', 40.00);

INSERT INTO public.esiti
(idservizio, eseguito, data_chiusura, descrizione)
VALUES(3, false, '12/08/22', 'Ricambio rifiutato dal cliente');


