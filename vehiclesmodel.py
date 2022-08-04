
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot, Qt, QByteArray
from PyQt5.QtSql import QSqlQueryModel

class Vehicles(QObject):

    modelChanged = pyqtSignal(QObject)
    brandChanged = pyqtSignal(int)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = VehiclesModel()
        self.brandChanged.connect(self.refresh)
        self._brand = -1
        self._model.setQuery("SELECT * from tvehicles")

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


class VehiclesModel(QSqlQueryModel):

    def __init__(self, parent:QObject=None) -> None:
        super(VehiclesModel, self).__init__()

    def roleNames(self):
        roles = {}
        roles[Qt.UserRole + 1] = QByteArray("targa".encode())
        return roles

    def data(self, index, role):
        if role < Qt.UserRole:
            return super(VehiclesModel, self).data(index, role)

        return super(VehiclesModel, self).data(self.index(index.row(), role - Qt.UserRole -1), Qt.DisplayRole)


class BrandsModel(QSqlQueryModel):
    
    def __init__(self, parent:QObject=None) -> None:
        super(BrandsModel, self).__init__()
        super().setQuery("SELECT id, nome FROM tbrands")
    
    def roleNames(self):
        roles = {}
        roles[Qt.UserRole + 1] = QByteArray("id".encode())
        roles[Qt.UserRole + 2] = QByteArray("nome".encode())
        return roles

    def data(self, index, role):
        if role < Qt.UserRole:
            return super(BrandsModel, self).data(index, role)

        return super(BrandsModel, self).data(self.index(index.row(), role - Qt.UserRole -1), Qt.DisplayRole)

