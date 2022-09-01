
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel

class Vehicles(QObject):

    modelChanged = pyqtSignal(QObject)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = VehiclesModel()
     
    @pyqtProperty(QObject, notify=modelChanged)
    def model(self):
        return self._model

    @pyqtSlot(str, int, str, int, str)
    def addVehicle(self, targa :str, anno: int, modello: str, tipo: int, nomeMarchio: str):
        query = QSqlQuery()
        query.prepare("""INSERT INTO public.veicoli
                                (targa, anno, modello, tipo, nomeMarchio)
                        VALUES(:plate, :year, :model, :type, :idbrand)
                    """)
        query.bindValue(":plate", targa)
        query.bindValue(":year", anno)
        query.bindValue(":model", modello)
        query.bindValue(":type", tipo)
        query.bindValue(":idbrand", nomeMarchio)

        return query.exec()

    @pyqtSlot()
    def refresh(self):
        if self._brand == -1:
            self._model.setQuery("SELECT targa, anno, modello, tipo from public.veicoli")
            return
            
        self._model.setQuery("SELECT targa, anno, modello, tipo from public.veicoli WHERE nomeMarchio=" +
            str(self._brand))


class VehiclesModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(VehiclesModel, self).__init__(["targa", "anno", "modello", "tipo"])
        super().setQuery("SELECT targa, anno, modello, tipo from public.veicoli")


class BrandsModel(BaseModel):
    
    def __init__(self, parent:QObject=None) -> None:
        super(BrandsModel, self).__init__(["nomeMarchio"])
        super().setQuery("SELECT nomeMarchio FROM public.marchi")

