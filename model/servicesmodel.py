from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, pyqtSlot, QDateTime
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel
from datetime import date

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

    @pyqtSlot()
    def refresh(self):
        query = QSqlQuery()
        if self._date.isValid():
            query.prepare("""SELECT S.idservizio, S.tempo_stimato, S.descrizione, S.data_servizio, S.ora, TS.nome as tipo_servizio, V.modello, M.nome as marca,
                                    V.anno, C.cognome, C.nome as nome_cliente, coalesce (E.idesito is not null, False) as completato
                            FROM public.servizi as S
                            JOIN tipo_servizi TS on S.idtipo = TS.idtipo 
                            JOIN veicoli V on S.idveicolo = V.idveicolo 
                            JOIN clienti C on S.idcliente = C.idcliente
                            JOIN marchi M on V.idmarchio = M.idmarchio
                            LEFT JOIN esiti E on S.idservizio = E.idservizio 
                            WHERE idofficina = :workshop AND S.data_servizio = :date
                            """)
            query.bindValue(":workshop", self._workshop)
            query.bindValue(":date", self._date)
        else:
            query.prepare("""SELECT S.idservizio, S.tempo_stimato, S.descrizione, S.data_servizio, S.ora, TS.nome as tipo_servizio, V.modello, M.nome as marca,
                                    V.anno, C.cognome, C.nome as nome_cliente, coalesce (E.idesito is not null, False) as completato
                            FROM public.servizi as S
                            JOIN tipo_servizi TS on S.idtipo = TS.idtipo 
                            JOIN veicoli V on S.idveicolo = V.idveicolo 
                            JOIN clienti C on S.idcliente = C.idcliente
                            JOIN marchi M on V.idmarchio = M.idmarchio
                            LEFT JOIN esiti E on S.idservizio = E.idservizio 
                            WHERE idofficina = :workshop
                            """)
            query.bindValue(":workshop", self._workshop)
        query.exec()
        self._model.setQuery(query)

class ServicesModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(ServicesModel, self).__init__(["idservizio", "tempo_stimato", "descrizione", "data_servizio", "ora", "tipo_servizio",
                                            "modello", "marca", "anno", "cognome", "nome_cliente", "completato"])
        super().setQuery("""SELECT S.idservizio, S.tempo_stimato, S.descrizione, S.data_servizio, S.ora, TS.nome as tipo_servizio, V.modello, M.nome as marca,
                                V.anno, C.cognome, C.nome as nome_cliente, coalesce (E.idesito is not null, False) as completato
                            FROM public.servizi as S
                            JOIN tipo_servizi TS on S.idtipo = TS.idtipo 
                            JOIN veicoli V on S.idveicolo = V.idveicolo 
                            JOIN clienti C on S.idcliente = C.idcliente
                            JOIN marchi M on V.idmarchio = M.idmarchio
                            LEFT JOIN esiti E on S.idservizio = E.idservizio
                        """)

                    

