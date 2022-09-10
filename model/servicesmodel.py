from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, pyqtSlot, QDateTime
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel

class Services(QObject):

    modelChanged = pyqtSignal(QObject)
    filterChanged = pyqtSignal(str)
    dateChanged = pyqtSignal(QDateTime)
    workshopChanged = pyqtSignal(int)


    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = ServicesModel()
        self._filter = ""
        self._workshop = -1
        self._date = QDateTime()
        self._full = False
        self.dateChanged.connect(self.refresh)
        self.filterChanged.connect(self.refresh)
        self.workshopChanged.connect(self.refresh)

    @pyqtProperty(QObject, notify=modelChanged)
    def model(self):
        return self._model

    @pyqtProperty(int, notify=workshopChanged)
    def workshop(self):
        return self._workshop

    @workshop.setter
    def workshop(self, workshop: int):
        self._workshop = workshop
        self.workshopChanged.emit(workshop)

    @pyqtProperty(str, notify=filterChanged)
    def filter(self):
        return self._filter

    @filter.setter
    def filter(self, filter: str):
        self._filter = filter
        self.filterChanged.emit(filter)

    @pyqtProperty(QDateTime, notify=dateChanged)
    def date(self):
        return self._date

    @date.setter
    def date(self, date: QDateTime):
        self._date = date
        self.dateChanged.emit(date)

    @pyqtSlot(int,result=int)
    def getIdByIndex(self, index: int):
        self.model.query().seek(index)
        return self.model.query().value("idServizio")

    @pyqtSlot(int,result=bool)
    def getStatusByIndex(self, index: int):
        self.model.query().seek(index)
        return self.model.query().value("completato")

    @pyqtSlot(int, str, QDateTime, QDateTime, int, str, str, list, result=bool)
    def addService(self, tempo: int, descrizione: str, data :QDateTime, ora: QDateTime, idcliente: int, nomeTipo: str, targa: str, dipendenti :list):
        query = QSqlQuery()
        if not dipendenti: 
            return False

        query.prepare("""INSERT INTO public.servizi
                        (tempo_stimato, descrizione, data_servizio, ora, idofficina, idcliente, nomeTipo, targa)
                        VALUES(:time, :desc, :date, :hour, :idworkshop, :idclient, :idtype, :idvehicle)
                        RETURNING idservizio
                    """)
        query.bindValue(":time", tempo)
        query.bindValue(":desc", descrizione)
        query.bindValue(":date", data.toString("yyyy-MM-dd"))
        query.bindValue(":hour", ora.time().toString("hh:mm"))
        query.bindValue(":idworkshop", self._workshop)
        query.bindValue(":idclient", idcliente)
        query.bindValue(":idtype", nomeTipo)
        query.bindValue(":idvehicle", targa)

        if query.exec():
            query.next()
            idservizio = query.value(0)
            employeeQuery = QSqlQuery()
            for iddipendente in dipendenti: 
                employeeQuery.prepare("""INSERT INTO public.assegnazioni
                                        (iddipendente, idservizio)
                                    VALUES(:idemployee, :idservice);
                                """)
                employeeQuery.bindValue(":idservice", idservizio)
                employeeQuery.bindValue(":idemployee", iddipendente)
                if not employeeQuery.exec():
                    return False
        else:
            return False
        self.refresh()
        return True

    @pyqtSlot()
    def refresh(self):
        query = QSqlQuery()
        if self._date.isValid():
            query.prepare("""SELECT S.idservizio, S.tempo_stimato, S.descrizione, S.data_servizio, S.ora, TS.nomeTipo as tipo_servizio, V.modello, M.nomeMarchio as marca,
                                    V.anno, C.cognome, C.nome as nome_cliente, coalesce (E.idesito is not null, False) as completato, E.eseguito
                            FROM public.servizi as S
                            JOIN tipo_servizi TS on S.nomeTipo = TS.nomeTipo 
                            JOIN veicoli V on S.targa = V.targa 
                            JOIN clienti C on S.idcliente = C.idcliente
                            JOIN marchi M on V.nomeMarchio = M.nomeMarchio
                            LEFT JOIN esiti E on S.idservizio = E.idservizio 
                            WHERE idofficina = :workshop AND S.data_servizio = :date AND LOWER(S.descrizione) LIKE '%""" + self._filter + """%'
                            """)
            query.bindValue(":workshop", self._workshop)
            query.bindValue(":date", self._date)
        else:
            query.prepare("""SELECT S.idservizio, S.tempo_stimato, S.descrizione, S.data_servizio, S.ora, TS.nomeTipo as tipo_servizio, V.modello, M.nomeMarchio as marca,
                                    V.anno, C.cognome, C.nome as nome_cliente, coalesce (E.idesito is not null, False) as completato, E.eseguito
                            FROM public.servizi as S
                            JOIN tipo_servizi TS on S.nomeTipo = TS.nomeTipo 
                            JOIN veicoli V on S.targa = V.targa 
                            JOIN clienti C on S.idcliente = C.idcliente
                            JOIN marchi M on V.nomeMarchio = M.nomeMarchio
                            LEFT JOIN esiti E on S.idservizio = E.idservizio 
                            WHERE idofficina = :workshop AND LOWER(S.descrizione) LIKE '%""" + self._filter + """%'
                            """)
            query.bindValue(":workshop", self._workshop)
        query.exec()
        self._model.setQuery(query)

class ServicesSlot(QObject):

    workshopChanged = pyqtSignal(int)
    hourChanged = pyqtSignal(QDateTime)
    dateChanged = pyqtSignal(QDateTime)
    estimatedTimeChanged = pyqtSignal(int)
    fullChanged = pyqtSignal(bool)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._workshop = -1
        self._date = QDateTime()
        self._hour = QDateTime()
        self.estimated_time = -1
        self._full = False
        self.dateChanged.connect(self.refresh)
        self.hourChanged.connect(self.refresh)
        self.estimatedTimeChanged.connect(self.refresh)
        self.workshopChanged.connect(self.refresh)

    @pyqtProperty(int, notify=workshopChanged)
    def workshop(self):
        return self._workshop

    @workshop.setter
    def workshop(self, workshop: int):
        self._workshop = workshop
        self.workshopChanged.emit(workshop)

    @pyqtProperty(QDateTime, notify=hourChanged)
    def hour(self):
        return self._hour

    @hour.setter
    def hour(self, hour: QDateTime):
        self._hour = hour
        self.hourChanged.emit(hour)

    @pyqtProperty(QDateTime, notify=dateChanged)
    def date(self):
        return self._date

    @date.setter
    def date(self, date: QDateTime):
        self._date = date
        self.dateChanged.emit(date)

    @pyqtProperty(int, notify=estimatedTimeChanged)
    def estimated_time(self):
        return self._estimated_time

    @estimated_time.setter
    def estimated_time(self, estimated_time: int):
        self._estimated_time = estimated_time
        self.estimatedTimeChanged.emit(estimated_time)

    @pyqtProperty(bool, notify=fullChanged)
    def full(self):
        return self._full

    @pyqtSlot()
    def refresh(self):
        if not self._date.isValid() or not self._hour.isValid() or self._estimated_time == -1:
            return
        query = QSqlQuery()
        query.prepare(""" select count(S.idservizio) < O.max_veicoli as num_veicoli, O.max_veicoli 
                        from public.servizi as S
                        join officine as O on S.idofficina = O.idofficina 
                        where O.idofficina = :idworkshop and S.data_servizio = :data
                            and (:ora + make_interval(hours => :tempo_stimato) > S.ora and :ora + make_interval(hours => :tempo_stimato) <= S.ora + make_interval(hours => S.tempo_stimato)
                                or (:ora > S.ora and :ora < S.ora + make_interval(hours => S.tempo_stimato))
                                or (:ora < S.ora and :ora + make_interval(hours => :tempo_stimato) > S.ora + make_interval(hours => S.tempo_stimato))
                                )
                        group by O.idofficina  
                    """)
        query.bindValue(":idworkshop", self._workshop)
        query.bindValue(":data", self._date.toString("yyyy-MM-dd"))
        query.bindValue(":ora", self._hour.time().toString("hh:mm"))
        query.bindValue(":tempo_stimato", self._estimated_time)
        
        query.exec()
        query.next()

        if query.isValid():
            self._full = not query.value(0)
            self.fullChanged.emit(self._full)
        else:
            self._full = False
            self.fullChanged.emit(self._full)


class ServicesModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(ServicesModel, self).__init__(["idservizio", "tempo_stimato", "descrizione", "data_servizio", "ora", "tipo_servizio",
                                            "modello", "marca", "anno", "cognome", "nome_cliente", "completato", "eseguito"])
        super().setQuery("""SELECT S.idservizio, S.tempo_stimato, S.descrizione, S.data_servizio, S.ora, TS.nomeTipo as tipo_servizio, V.modello, M.nomeMarchio as marca,
                                V.anno, C.cognome, C.nome as nome_cliente, coalesce (E.idesito is not null, False) as completato, E.eseguito
                            FROM public.servizi as S
                            JOIN tipo_servizi TS on S.nomeTipo = TS.nomeTipo 
                            JOIN veicoli V on S.targa = V.targa 
                            JOIN clienti C on S.idcliente = C.idcliente
                            JOIN marchi M on V.nomeMarchio = M.nomeMarchio
                            LEFT JOIN esiti E on S.idservizio = E.idservizio
                        """)

class ServicesTypeModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(ServicesTypeModel, self).__init__(["nomeTipo", "tariffa"])
        super().setQuery("""SELECT nomeTipo, tariffa
                            FROM public.tipo_servizi
                        """)

                    


