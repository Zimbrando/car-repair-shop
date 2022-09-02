
from datetime import date
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot, QDateTime
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel

class Outcomes(QObject):

    serviceChanged = pyqtSignal(int)
    priceChanged = pyqtSignal(float)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._service = -1
        self._price = -1
        self.serviceChanged.connect(self.refresh)

     
    @pyqtProperty(int, notify=serviceChanged)
    def service(self):
        return self._service

    @service.setter
    def service(self, service: int):
        self._service = service
        self.serviceChanged.emit(service)

    @pyqtProperty(float, notify=priceChanged)
    def price(self):
        return self._price

    @pyqtSlot(str, QDateTime, float, bool, result=bool)
    def addOutcome(self, descrizione: str, data: date, importo: float, eseguito: bool):
        query = QSqlQuery()

        if eseguito:
            query.prepare("""INSERT INTO public.esiti
                            (idservizio, eseguito, data_chiusura, descrizione, importo)
                            VALUES (:idservice, :executed, :date, :description, :amount)
                        """)

            query.bindValue(":idservice", self._service)
            query.bindValue(":executed", eseguito)
            query.bindValue(":date", data.toString("yyyy-MM-dd"))
            query.bindValue(":description", descrizione)
            query.bindValue(":amount", importo)

            return query.exec()
        else:
            query.prepare("""INSERT INTO public.esiti
                            (idservizio, eseguito, data_chiusura, descrizione)
                            VALUES (:idservice, :executed, :date, :description)
                        """)

            query.bindValue(":idservice", self._service)
            query.bindValue(":executed", eseguito)
            query.bindValue(":date", data.toString("yyyy-MM-dd"))
            query.bindValue(":description", descrizione)

            return query.exec()


    @pyqtSlot()
    def refresh(self):
        query = QSqlQuery()
        query.prepare("""select sum(coalesce (CC.prezzo, 0)) + TS.tariffa * S.tempo_stimato as importo_finale
                        from public.servizi S
                        join public.tipo_servizi TS on S.nomeTipo = TS.nomeTipo 
                        left join public.componenti C on S.idservizio = C.idservizio
                        left join public.classe_componenti CC on C.codiceean = CC.codiceean 
                        where S.idservizio = :idservizio
                        group by S.idservizio, TS.nomeTipo
                    """)

        query.bindValue(":idservizio", self._service)
        
        if query.exec():
            query.next()
            self._price = query.value(0)
            self.priceChanged.emit(self._price)
