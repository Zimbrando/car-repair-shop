from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel


class Clients(QObject):
    
    modelChanged = pyqtSignal(QObject)
    filterChanged = pyqtSignal(str)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = ClientsModel()
        self._filter = ""
        self.filterChanged.connect(self.refresh)

    @pyqtProperty(QObject, notify=modelChanged)
    def model(self):
        return self._model

    @pyqtProperty(str, notify=filterChanged)
    def filter(self):
        return self._filter

    @filter.setter
    def filter(self, filter: str):
        self._filter = filter
        self.filterChanged.emit(filter)

    @pyqtSlot()
    def refresh(self):
        self._model.setQuery("""SELECT idcliente, nome, cognome, codice_fiscale 
                            FROM public.clienti
                            WHERE LOWER(nome) LIKE '""" + self._filter + """%' OR LOWER(cognome) LIKE '""" + self._filter + """%'                       
                        """)

    @pyqtSlot(str, str, str, str, str)
    def addClient(self, name: str, surname: str, taxcode: str, cellnum: str, email: str):
        query = QSqlQuery()
        query.prepare("""INSERT INTO public.clienti
                        (cognome, nome, codice_fiscale, telefono, email)
                        VALUES(:surname, :name, :taxcode, :cellnum, :email)
                    """)

        query.bindValue(":surname", surname)
        query.bindValue(":name", name)
        query.bindValue(":taxcode", taxcode)
        query.bindValue(":cellnum", cellnum)
        query.bindValue(":email", email)

        done = query.exec()
        return done

    @pyqtSlot(str, str, str, str, str, str)
    def addClientComp(self, name: str, surname: str, taxcode: str, cellnum: str, email: str, companyName: str):
        query = QSqlQuery()
        query.prepare("""INSERT INTO public.clienti
                        (cognome, nome, codice_fiscale, telefono, email, nome_azienda)
                        VALUES(:surname, :name, :taxcode, :cellnum, :email, :company)
                    """)
                    
        query.bindValue(":surname", surname)
        query.bindValue(":name", name)
        query.bindValue(":taxcode", taxcode)
        query.bindValue(":cellnum", cellnum)
        query.bindValue(":email", email)
        query.bindValue(":company", companyName)

        done = query.exec()
        return done
    

class ClientsModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(ClientsModel, self).__init__(["idcliente", "nome", "cognome", "codice_fiscale"])
        super().setQuery("""SELECT idcliente, nome, cognome, codice_fiscale 
                            FROM public.clienti""")

