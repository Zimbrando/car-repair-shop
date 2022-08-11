import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Services 1.0

Item{
    anchors.fill: parent

    TextField {
        id: nameFilter
        height: parent.height *.1
        width: parent.width * .8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15
        placeholderText: "Find service"
    }

    QC1.TableView {
        height: parent.height *.7
        width: parent.width * .8
        anchors{
            top: nameFilter.bottom
            topMargin: parent.height *.1
            horizontalCenter: parent.horizontalCenter
        }
        model: dataServices.model
        backgroundVisible: false
        alternatingRowColors: false

        headerDelegate: Rectangle {
            color: "transparent"
        }

        rowDelegate: Rectangle{
            color: "transparent"
        }

        QC1.TableViewColumn {
            title: "Completato"
            role: "completato"
            width: 40
        }

        QC1.TableViewColumn {
            title: "Ora"
            role: "data_servizio"
            delegate: Text{
                text: model.data_servizio ? model.data_servizio.toLocaleDateString() : ""
                color: "white"
            }
            width: 150
        }

        QC1.TableViewColumn {
            title: "Marca"
            role: "marca"
            width: 60
        }

        QC1.TableViewColumn {
            title: "Anno"
            role: "anno"
            width: 40
        }

        QC1.TableViewColumn {
            title: "Modello"
            role: "modello"
            width: 50
        }

        QC1.TableViewColumn {
            title: "Nome"
            role: "nome_cliente"
            width: 80
        }

        QC1.TableViewColumn {
            title: "Cognome"
            role: "cognome"
            width: 80
        }

        QC1.TableViewColumn {
            title: "Descrizione"
            role: "descrizione"
        }
    }

    Services {
        id: dataServices
        workshop: 1
    }
}