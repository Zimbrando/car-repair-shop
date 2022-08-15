from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel


class Clients(QObject):
    
    filterChanged = pyqtSignal(str)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = ClientsModel()
        self._filter = ""
        self.filterChanged.connect(self.refresh)


    @pyqtProperty(str, notify=filterChanged)
    def filter(self):
        return self._filter

    @filter.setter
    def filter(self, filter: str):
        self._filter = filter
        self.filterChanged.emit(filter)

    @pyqtSlot()
    def refresh(self):
        super().setQuery("""SELECT idcliente, nome, cognome, codice_fiscale 
                            FROM public.clienti
                            WHERE LOWER(nome) LIKE '""" + self._filter + """%' OR LOWER(cognome) LIKE '""" + self._filter + """%'                       
                        """)


class ClientsModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(ClientsModel, self).__init__(["idcliente", "nome", "cognome", "codice_fiscale"])
        super().setQuery("""SELECT idcliente, nome, cognome, codice_fiscale 
                            FROM public.clienti""")

