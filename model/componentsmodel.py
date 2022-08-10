from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, pyqtSlot
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel



class Components(QObject):

    modelChanged = pyqtSignal(QObject)
    workshopChanged = pyqtSignal(int)
    groupChanged = pyqtSignal(bool)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = ComponentsModel()
        self.workshopChanged.connect(self.refresh)
        self.groupChanged.connect(self.refresh)
        self._workshop = -1
        self._group = False
        self.refresh()

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

    @pyqtProperty(bool, notify=groupChanged)
    def group(self):
        return self._group

    @group.setter
    def group(self, group: bool):
        self._group = group
        self.groupChanged.emit(group)

    @pyqtSlot()
    def refresh(self):
        if self._workshop < 0:
            if self._group:
                self._model.setQuery("""SELECT CC.nome, CC.marca, CC.prezzo, COUNT(C.seriale) as quantita 
                                        FROM public.componenti AS C
                                        JOIN public.classe_componenti AS CC ON C.codiceean = CC.codiceean
                                        WHERE idservizio IS NULL
                                        GROUP BY CC.codiceean       
                                    """)
            else:
                self._model.setQuery("""SELECT C.seriale, CC.nome, CC.marca, CC.prezzo 
                                        FROM public.componenti AS C
                                        JOIN public.classe_componenti AS CC ON C.codiceean = CC.codiceean
                                        WHERE idservizio IS NULL
                                    """)
            return

        query = QSqlQuery()      
        if self._group:
            query.prepare("""SELECT CC.nome, CC.marca, CC.prezzo, COUNT(C.seriale) as quantita 
                            FROM public.componenti AS C
                            JOIN public.classe_componenti AS CC ON C.codiceean = CC.codiceean
                            WHERE idservizio IS NULL AND idofficina = :workshop
                            GROUP BY CC.codiceean       
                        """)
            query.bindValue(":workshop", self._workshop)
        else:
            query.prepare("""SELECT C.seriale, CC.nome, CC.marca, CC.prezzo 
                            FROM public.componenti AS C
                            JOIN public.classe_componenti AS CC ON C.codiceean = CC.codiceean
                            WHERE idservizio IS NULL AND idofficina = :workshop 
                        """)  
            query.bindValue(":workshop", self._workshop)
        query.exec()
        self._model.setQuery(query)
            

class ComponentsModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(ComponentsModel, self).__init__(["seriale", "nome", "marca", "prezzo", "quantita"])