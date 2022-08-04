
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, Qt, QByteArray
from PyQt5.QtSql import QSqlQueryModel

class Workshops(QObject):

    modelChanged = pyqtSignal(QObject)

    def __init__(self, parent: QObject=None) -> None:
        super().__init__(parent)
        self._model = WorkshopsModel()
        self._model.setQuery("SELECT * from tworkshops")

    @pyqtProperty(QObject, notify=modelChanged)
    def model(self):
        return self._model


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

