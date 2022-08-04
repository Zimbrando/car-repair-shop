
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot, Qt, QByteArray
from PyQt5.QtSql import QSqlQueryModel

class Workshops(QObject):

    modelChanged = pyqtSignal(QObject)
    nameChanged = pyqtSignal("QString")

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = WorkshopsModel()
        self.nameChanged.connect(self.refresh)
        self._name = ""
        self._model.setQuery("SELECT * from tworkshops")

    @pyqtProperty(QObject, notify=modelChanged)
    def model(self):
        return self._model

    @pyqtProperty("QString", notify=nameChanged)
    def name(self):
        return self._name

    @name.setter
    def name(self, newName: str):
        self._name = newName
        self.nameChanged.emit(newName)

    @pyqtSlot()
    def refresh(self):
        self._model.setQuery("SELECT id, name from tworkshops WHERE name LIKE '" +
            self._name + "%'")


class WorkshopsModel(QSqlQueryModel):

    def __init__(self, parent:QObject=None) -> None:
        super(WorkshopsModel, self).__init__()

    def roleNames(self):
        roles = {}
        roles[Qt.UserRole + 1] = QByteArray("id".encode())
        roles[Qt.UserRole + 2] = QByteArray("name".encode())
        return roles

    def data(self, index, role):
        if role < Qt.UserRole:
            return super(WorkshopsModel, self).data(index, role)

        return super(WorkshopsModel, self).data(self.index(index.row(), role - Qt.UserRole -1), Qt.DisplayRole)

