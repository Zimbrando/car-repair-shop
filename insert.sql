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
(nome)
VALUES('Mercedes'),
    ('Audi'),
    ('Fiat'),
    ('Peugeot'),
    ('Volvo'),
    ('Hyundai'),
    ('Ducati'),
    ('BMW'),
    ('Iveco'),
    ('Piaggio');

-- Veicoli
-- 1 Auto 2 Moto 3 Autocarro
INSERT INTO public.veicoli
(targa, anno, modello, tipo, idmarchio)
VALUES('BR243CD', 2001, '206', 1, 4),
    ('GD243DW', 2020, 'A3', 1, 2),
    ('GH222AB', 2021, 'XC60', 1, 5),
    ('DC223AD', 2007, 'I20', 1, 6),
    ('ER142GT', 2012, '208 GTI', 1, 4),
    ('FC231GR', 2017, '500X', 1, 3),
    ('FP126BV', 2018, '308', 1, 4);

-- Clienti
INSERT INTO public.clienti
(cognome, nome, codice_fiscale, telefono)
VALUES('Sternini', 'Marco', 'STRMRC67M42H753K', '3420476702'),
    ('Saccomandi', 'Chiara', 'SCCCHR67M42H753K', '3339234291'),
    ('Rossi', 'Lorenzo', 'RSSLNZ77D06D720H', '3453929921');

INSERT INTO public.clienti
(cognome, nome, codice_fiscale, email, nome_azienda)
VALUES('Nardi', 'Massimo', 'NRDMSM34T02E798D', 'nmassim@gmail.com', 'Resoft s.r.l'),
    ('Vuksan', 'Tiziano', 'VKSTZN58H02C001D', 'tvuksan@email.it', 'Astim s.r.l');


-- Dipendenti
INSERT INTO public.dipendenti
(cognome, nome, codice_fiscale, telefono)
VALUES('Rossi', 'Mario', 'ASD', '3124354234'),
    ('Verdi', 'Gennaro', 'ASD', '3124354234'),
    ('Carafassi', 'Samuele', 'ASD', '3124354234'),
    ('Pierantoni', 'Veronica', 'ASD', '3124354234'),
    ('Tagliaferri', 'Enrico', 'ASD', '3124354234'),
    ('Fragozzi', 'Riccardo', 'ASD', '3124354234'),
    ('Lefebvre', 'Clement', 'ASD', '3124354234'),
    ('Beleffi', 'Lucia', 'ASD', '3124354234'),
    ('Bezzi', 'Filippo', 'ASD', '3124354234'),
    ('Federici', 'Federico', 'ASD', '3124354234'),
    ('Bianchi', 'Alice', 'ASD', '3124354234');

-- Servizi
INSERT INTO public.servizi
(tempo_stimato, descrizione, data_servizio, ora, idofficina, idcliente, tipo, idveicolo)
VALUES(1, 'Kilometraggio corrente: 140.000km', '12/08/2022', '15:00', 1, 1, 1, 1),
    (2, 'Rumore strano alla partenza', '10/08/2022', '9:00', 2, 2, 2, 2);

-- Assegnazioni
INSERT INTO public.assegnazioni
(iddipendente, idservizio)
VALUES(1, 1),
    (2, 1),
    (4, 2);

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
(seriale, codiceean, idservizio)
VALUES('1425332', '978020137962', 1),
    ('1435672', '938022117962', 1),
    ('1231232', '938022117962', 2);

-- Componenti in magazzino
INSERT INTO public.componenti
    (seriale, codiceean)
VALUES('1425432', '978020137962'),
    ('1425232', '978020137962'),
    ('1435442', '975740137922'),
    ('1425242', '973020137962'),
    ('1725436', '973020137962'),
    ('1435632', '918027187962'),
    ('1325672', '918027187962'),
    ('1225432', '978040155962'),
    ('1416432', '978040155962'),
    ('1423477', '938022117962');

-- Lavori
INSERT INTO public.lavori
(iddipendente, data_assunzione, idofficina)
VALUES(1, '23/02/2020', 1),
    (2, '10/04/2018', 1),
    (3, '10/04/2018', 1),
    (4, '23/02/2020', 2),
    (5, '07/11/2019', 2),
    (6, '10/04/2018', 2),
    (7, '23/02/2020', 2),
    (8, '07/11/2019', 3),
    (9, '23/02/2020', 3),
    (10, '07/11/2019', 4),
    (11, '07/11/2019', 5);

-- Esiti
INSERT INTO public.esiti
(idservizio, eseguito, data_chiusura, descrizione, importo)
VALUES(2, true, '11/08/2022', 'Rabbocco di olio', 40.00);


