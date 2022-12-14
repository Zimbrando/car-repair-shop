-- TABLEs Section
-- _____________ 

DROP TABLE IF EXISTS LAVORI CASCADE;
CREATE TABLE LAVORI (
     idDipendente INT NOT NULL,
     data_assunzione date NOT NULL,
     idOfficina INT NOT NULL,
     CONSTRAINT ID_Lavor_Dipen_ID PRIMARY KEY (idDipendente)
);

DROP TABLE IF EXISTS DIPENDENTI CASCADE;
CREATE TABLE DIPENDENTI (
     idDipendente SERIAL NOT NULL,
     cognome VARCHAR(20) NOT NULL,
     nome VARCHAR(20) NOT NULL,
     codice_fiscale VARCHAR(16) NOT NULL,
     telefono VARCHAR(10) NOT NULL,
     email VARCHAR(30) NOT NULL,
     CONSTRAINT ID_Dipendente_ID PRIMARY KEY (idDipendente)
);

DROP TABLE IF EXISTS TIPO_SERVIZI CASCADE;
CREATE TABLE TIPO_SERVIZI (
     tariffa NUMERIC(4,2) NOT NULL,
     nomeTipo VARCHAR(30) NOT NULL,
     CONSTRAINT SID_Tipo_servizio_ID PRIMARY KEY (nomeTipo)
);

DROP TABLE IF EXISTS CLASSE_COMPONENTI CASCADE;
CREATE TABLE CLASSE_COMPONENTI (
     codiceEAN VARCHAR(30) NOT NULL,
     nome VARCHAR(20) NOT NULL,
     marca VARCHAR(20) NOT NULL,
     prezzo NUMERIC(5,2) NOT NULL,
     CONSTRAINT ID_Classe_componente_ID PRIMARY KEY (codiceEAN)
);

DROP TABLE IF EXISTS CLIENTI CASCADE;
CREATE TABLE CLIENTI (
     idCliente SERIAL NOT NULL,
     cognome VARCHAR(20) NOT NULL,
     nome VARCHAR(20) NOT NULL,
     codice_fiscale VARCHAR(16) NOT NULL,
     telefono VARCHAR(10) NOT NULL,
     email VARCHAR(30) NOT NULL,
     nome_azienda VARCHAR(20),
     CONSTRAINT ID_Cliente_ID PRIMARY KEY (idCliente)
);

DROP TABLE IF EXISTS COMPONENTI CASCADE;
CREATE TABLE COMPONENTI (
     idComponente SERIAL NOT NULL,
     seriale VARCHAR(30) NOT NULL,
     codiceEAN VARCHAR(30) NOT NULL,
     idServizio INT,
     idOfficina INT NOT NULL,
     CONSTRAINT ID_Componente_ID PRIMARY KEY (idComponente),
     CONSTRAINT SID_Componente_ID UNIQUE (seriale, codiceEAN)
);

DROP TABLE IF EXISTS ESITI CASCADE;
CREATE TABLE ESITI (
     idEsito SERIAL NOT NULL,
     idServizio INT NOT NULL,
     eseguito BOOLEAN NOT NULL,
     data_chiusura date NOT NULL,
     descrizione VARCHAR(256),
     importo NUMERIC(6,2),
     CONSTRAINT ID_Esito_ID PRIMARY KEY (idEsito),
     CONSTRAINT SID_Esito_Servi_ID UNIQUE (idServizio)
);

DROP TABLE IF EXISTS VEICOLI CASCADE;
CREATE TABLE VEICOLI (
     targa VARCHAR(7) NOT NULL,
     anno INT NOT NULL,
     modello VARCHAR(20) NOT NULL,
     tipo INT NOT NULL,
     nomeMarchio VARCHAR(30) NOT NULL,
     CONSTRAINT ID_Veicolo_ID PRIMARY KEY (targa)
);

DROP TABLE IF EXISTS MARCHI CASCADE;
CREATE TABLE MARCHI (
     nomeMarchio VARCHAR(20) NOT NULL,
     CONSTRAINT ID_Marchio_ID PRIMARY KEY (nomeMarchio)
);


DROP TABLE IF EXISTS OFFICINE CASCADE;
CREATE TABLE OFFICINE (
     idOfficina SERIAL NOT NULL,
     max_veicoli INT NOT NULL,
     via VARCHAR(40) NOT NULL,
     citta VARCHAR(20) NOT NULL,
     cap VARCHAR(5) NOT NULL,
     civico INT NOT NULL,
     CONSTRAINT ID_Officina_ID PRIMARY KEY (idOfficina)
);

DROP TABLE IF EXISTS SERVIZI CASCADE;
CREATE TABLE SERVIZI (
     idServizio SERIAL NOT NULL,
     tempo_stimato INT NOT NULL,
     descrizione VARCHAR(256) NOT NULL,
     data_servizio date NOT NULL,
     ora TIME NOT NULL,
     idOfficina INT NOT NULL,
     idCliente INT NOT NULL,
     nomeTipo VARCHAR(30) NOT NULL,
     targa VARCHAR(7) NOT NULL,
     CONSTRAINT ID_Servizio_ID PRIMARY KEY (idServizio),
     CONSTRAINT SID_Servizio_ID UNIQUE (idCliente, data_servizio, ora)
);

DROP TABLE IF EXISTS ASSEGNAZIONI CASCADE;
CREATE TABLE ASSEGNAZIONI (
     idDipendente INT NOT NULL,
     idServizio INT NOT NULL,
     CONSTRAINT ID_Assegnazione_ID PRIMARY KEY (idDipendente, idServizio)
);

-- CONSTRAINTs Section
-- ___________________ 

ALTER TABLE ASSEGNAZIONI ADD CONSTRAINT EQU_Asseg_Servi_FK
     FOREIGN KEY (idServizio)
     REFERENCES SERVIZI;

ALTER TABLE ASSEGNAZIONI ADD CONSTRAINT EQU_Asseg_Dipen
     FOREIGN KEY (idDipendente)
     REFERENCES DIPENDENTI;

ALTER TABLE COMPONENTI ADD CONSTRAINT REF_Compo_Class_FK
     FOREIGN KEY (codiceEAN)
     REFERENCES CLASSE_COMPONENTI;

ALTER TABLE COMPONENTI ADD CONSTRAINT REF_Compo_Servi_FK
     FOREIGN KEY (idServizio)
     REFERENCES SERVIZI;

ALTER TABLE COMPONENTI ADD CONSTRAINT REF_Compo_Offic_FK
     FOREIGN KEY (idOfficina)
     REFERENCES OFFICINE;

ALTER TABLE ESITI ADD CONSTRAINT SID_Esito_Servi_FK
     FOREIGN KEY (idServizio)
     REFERENCES SERVIZI;

ALTER TABLE LAVORI ADD CONSTRAINT REF_Lavor_Offic_FK
     FOREIGN KEY (idOfficina)
     REFERENCES OFFICINE;

ALTER TABLE LAVORI ADD CONSTRAINT ID_Lavor_Dipen_FK
     FOREIGN KEY (idDipendente)
     REFERENCES DIPENDENTI;

ALTER TABLE SERVIZI ADD CONSTRAINT REF_Servi_Veico_FK
     FOREIGN KEY (targa)
     REFERENCES VEICOLI;

ALTER TABLE SERVIZI ADD CONSTRAINT REF_Servi_Offic_FK
     FOREIGN KEY (idOfficina)
     REFERENCES OFFICINE;

ALTER TABLE SERVIZI ADD CONSTRAINT EQU_Servi_Clien
     FOREIGN KEY (idCliente)
     REFERENCES CLIENTI;

ALTER TABLE VEICOLI ADD CONSTRAINT REF_Veico_March_FK
     FOREIGN KEY (nomeMarchio)
     REFERENCES MARCHI;

ALTER TABLE SERVIZI ADD CONSTRAINT REF_Servi_Tipo__FK
     FOREIGN KEY (nomeTipo)
     REFERENCES TIPO_SERVIZI;


-- INDEX Section
-- _____________ 

CREATE UNIQUE INDEX ID_Assegnazione_IND
     on ASSEGNAZIONI (idDipendente, idServizio);

CREATE INDEX EQU_Asseg_Servi_IND
     on ASSEGNAZIONI (idServizio);

CREATE UNIQUE INDEX ID_Classe_componente_IND
     on CLASSE_COMPONENTI (codiceEAN);

CREATE UNIQUE INDEX ID_Cliente_IND
     on CLIENTI (idCliente);

CREATE UNIQUE INDEX ID_Componente_IND
     on COMPONENTI (seriale, codiceEAN);

CREATE UNIQUE INDEX SID_Componente_IND
     on COMPONENTI (idComponente);

CREATE INDEX REF_Compo_Class_IND
     on COMPONENTI (codiceEAN);

CREATE INDEX REF_Compo_Servi_IND
     on COMPONENTI (idServizio);

CREATE UNIQUE INDEX ID_Dipendente_IND
     on DIPENDENTI (idDipendente);

CREATE UNIQUE INDEX ID_Esito_IND
     on ESITI (idEsito);

CREATE UNIQUE INDEX SID_Esito_Servi_IND
     on ESITI (idServizio);

CREATE UNIQUE INDEX SID_Marchio_IND
     on MARCHI (nomeMarchio);

CREATE INDEX REF_Lavor_Offic_IND
     on LAVORI (idOfficina);

CREATE UNIQUE INDEX ID_Lavor_Dipen_IND
     on LAVORI (idDipendente);

CREATE UNIQUE INDEX ID_Officina_IND
     on OFFICINE (idOfficina);

CREATE UNIQUE INDEX ID_Servizio_IND
     on SERVIZI (idServizio);

CREATE UNIQUE INDEX SID_Servizio_IND
     on SERVIZI (idCliente, data_servizio, ora);

CREATE INDEX REF_Servi_Tipo__IND
     on SERVIZI (nomeTipo);

CREATE INDEX REF_Servi_Offic_IND
     on SERVIZI (idOfficina);

CREATE UNIQUE INDEX ID_Tipo_servizio_IND
     on TIPO_SERVIZI (nomeTipo);

CREATE UNIQUE INDEX ID_Veicolo_IND
     on VEICOLI (targa);

CREATE INDEX REF_Veico_March_IND
     on VEICOLI (nomeMarchio);


