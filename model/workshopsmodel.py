
from PyQt5.QtCore import QObject
from .basemodel import BaseModel

class WorkshopsModel(BaseModel):

    def __init__(self, parent:QObject=None) -> None:
        super(WorkshopsModel, self).__init__(["idofficina", "via", "citta", "cap", "civico", "max_veicoli"])
        super().setQuery("SELECT idofficina, via, citta, cap, civico, max_veicoli FROM public.officine")

