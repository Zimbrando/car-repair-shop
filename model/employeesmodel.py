from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, pyqtSlot, QDateTime, QTime
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel

class Employees(QObject):

    modelChanged = pyqtSignal(QObject)
    filterChanged = pyqtSignal(str)
    workshopChanged = pyqtSignal(int)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = EmployeesModel()
        self._filter = ""
        self._workshop = -1
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

    @pyqtSlot()
    def refresh(self):
        if self._workshop == -1:
            self._model.setQuery("""SELECT D.iddipendente, D.cognome, D.nome, D.codice_fiscale, D.telefono, D.email
                                    FROM public.dipendenti as D
                                    WHERE (LOWER(D.cognome) like '""" + self._filter + """%' OR LOWER(D.nome) like '""" + self._filter + """%') 
                                """)
            return
        self._model.setQuery("""SELECT D.iddipendente, D.cognome, D.nome, D.codice_fiscale, D.telefono, D.email
                        FROM public.dipendenti as D
                        JOIN public.lavori as L on D.iddipendente = L.iddipendente  
                        WHERE L.idofficina= """ + str(self._workshop) + """ AND (LOWER(D.cognome) like '""" + self._filter + """%' OR LOWER(D.nome) like '""" + self._filter + """%') 
                        """)


class EmployeesModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(EmployeesModel, self).__init__(["iddipendente", "cognome", "nome", "codice_fiscale", "telefono", "email"])
        super().setQuery("SELECT iddipendente, cognome, nome, codice_fiscale, telefono, email FROM public.dipendenti")



class EmployeesFree(QObject):
    
    modelChanged = pyqtSignal(QObject)
    workshopChanged = pyqtSignal(int)
    hourChanged = pyqtSignal(QDateTime)
    dateChanged = pyqtSignal(QDateTime)
    estimatedTimeChanged = pyqtSignal(int)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = EmployeesModel()
        self._hour = QDateTime()
        self._date = QDateTime()
        self._estimated_time = -1
        self._workshop = -1
        self.workshopChanged.connect(self.refresh)
        self.hourChanged.connect(self.refresh)
        self.dateChanged.connect(self.refresh)
        self.estimatedTimeChanged.connect(self.refresh)

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

    @pyqtSlot()
    def refresh(self):
        query = QSqlQuery()
        query.prepare("""select D.iddipendente, nome, cognome, codice_fiscale
                            from public.dipendenti D
                            join public.lavori L on L.iddipendente = D.iddipendente 
                            where L.idofficina = :idworkshop except (select D.iddipendente, D.nome, D.cognome, D.codice_fiscale
                            						from public.dipendenti D 
                            						left join public.assegnazioni A on D.iddipendente = A.iddipendente 
                            						left join public.servizi S on A.idservizio = S.idservizio 
                            						join public.lavori L on L.iddipendente = D.iddipendente 
                            						where L.idofficina = :idworkshop and :data = S.data_servizio 
                            							and (:ora + make_interval(hours => :tempo_stimato) > S.ora and  :ora + make_interval(hours => :tempo_stimato) <= S.ora + make_interval(hours => S.tempo_stimato)
                            								or (:ora > S.ora and :ora < S.ora + make_interval(hours => S.tempo_stimato))
                            								or (:ora < S.ora and :ora + make_interval(hours => :tempo_stimato) > S.ora + make_interval(hours => S.tempo_stimato))
                            								)
                            						group by D.iddipendente) """)
        query.bindValue(":idworkshop", self._workshop)
        query.bindValue(":data", self._date.toString("yyyy-MM-dd"))
        query.bindValue(":ora", self._hour.time().toString("hh:mm"))
        query.bindValue(":tempo_stimato", self._estimated_time)
        query.exec()
        self._model.setQuery(query)

