
from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal, pyqtSlot, Qt, QByteArray
from basemodel import BaseModel

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


class WorkshopsModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(WorkshopsModel, self).__init__(["id", "name"])

