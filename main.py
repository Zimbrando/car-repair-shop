from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType
from PyQt5.QtSql import QSqlDatabase

from model.workshopsmodel import WorkshopsModel
from model.vehiclesmodel import Vehicles, BrandsModel
from model.componentsmodel import Components, ClassesModel
from model.employeesmodel import Employees
from config import Config

import sys
import logging


def init_connection():
    db = QSqlDatabase.addDatabase("QPSQL")
    db.setHostName(Config["HOSTNAME"])
    db.setDatabaseName(Config["DATABASE_NAME"])
    db.setUserName(Config["USERNAME"])
    db.setPassword(Config["PASSWORD"])

    ok = db.open()

    if not ok:
        logging.error("Can not open the connection, check the config file")
        sys.exit(-1)


def init_logging():
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s [%(levelname)s] %(message)s",
        handlers=[
            logging.StreamHandler(sys.stdout)
        ]
    )   


if __name__ == '__main__':

    app = QGuiApplication(sys.argv)

    init_logging()

    init_connection()

    #Workshops
    qmlRegisterType(WorkshopsModel, 'WorkshopsModel', 1, 0, 'WorkshopsModel')
    #Vehicles
    qmlRegisterType(Vehicles, 'Vehicles', 1, 0, 'Vehicles')
    qmlRegisterType(BrandsModel, 'Vehicles.BrandsModel', 1, 0, 'BrandsModel')
    #Components
    qmlRegisterType(Components, 'Components', 1, 0, 'Components')
    qmlRegisterType(ClassesModel, 'Components.ClassesModel', 1, 0, 'ClassesModel')
    #Employees
    qmlRegisterType(Employees, 'Employees', 1, 0, 'Employees')
    
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.load("./gui/mainWindow.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
