
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot
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

    @pyqtSlot()
    def refresh(self):
        if self._brand == -1:
            self._model.setQuery("SELECT targa from tvehicles")
            return
            
        self._model.setQuery("SELECT targa from tvehicles WHERE kmarca=" +
            str(self._brand))


class VehiclesModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(VehiclesModel, self).__init__(["targa"])
        super().setQuery("SELECT targa from tvehicles")


class BrandsModel(BaseModel):
    
    def __init__(self, parent:QObject=None) -> None:
        super(BrandsModel, self).__init__(["id", "nome"])
        super().setQuery("SELECT id, nome FROM tbrands")

