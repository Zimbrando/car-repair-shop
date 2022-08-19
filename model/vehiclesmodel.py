
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtSql import QSqlQuery
from .basemodel import BaseModel

class Vehicles(QObject):

    modelChanged = pyqtSignal(QObject)
    brandChanged = pyqtSignal(int)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = VehiclesModel()
        self.brandChanged.connect(self.refresh)
        self._brand = -1

    @pyqtProperty(QObject, notify=modelChanged)
    def model(self):
        return self._model

    @pyqtProperty(int, notify=brandChanged)
    def brand(self):
        return self._brand

    @brand.setter
    def brand(self, brand: int):
        self._brand = brand
        self.brandChanged.emit(brand)

    @pyqtSlot(str, int, str, int, int)
    def addVehicle(self, targa :str, anno: int, modello: str, tipo: int, idmarchio: int):
        query = QSqlQuery()
        query.prepare("""INSERT INTO public.veicoli
                                (targa, anno, modello, tipo, idmarchio)
                        VALUES(:plate, :year, :model, :type, :idbrand)
                    """)
        query.bindValue(":plate", targa)
        query.bindValue(":year", anno)
        query.bindValue(":model", modello)
        query.bindValue(":type", tipo)
        query.bindValue(":idbrand", idmarchio)

        return query.exec()

    @pyqtSlot()
    def refresh(self):
        if self._brand == -1:
            self._model.setQuery("SELECT idveicolo, targa, anno, modello, tipo from public.veicoli")
            return
            
        self._model.setQuery("SELECT idveicolo, targa, anno, modello, tipo from public.veicoli WHERE idmarchio=" +
            str(self._brand))


class VehiclesModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(VehiclesModel, self).__init__(["idveicolo", "targa", "anno", "modello", "tipo"])
        super().setQuery("SELECT idveicolo, targa, anno, modello, tipo from public.veicoli")


class BrandsModel(BaseModel):
    
    def __init__(self, parent:QObject=None) -> None:
        super(BrandsModel, self).__init__(["idmarchio", "nome"])
        super().setQuery("SELECT idmarchio, nome FROM public.marchi")

