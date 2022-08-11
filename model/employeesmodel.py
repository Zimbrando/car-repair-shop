from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, pyqtSlot
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

