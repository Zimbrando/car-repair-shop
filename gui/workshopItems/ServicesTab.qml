import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Services 1.0
import "../shared"

Item{
    id: root
    property var appPalette: undefined
    property int workShopIndex: undefined

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
        id: servicesTable
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
        frameVisible: false
        sortIndicatorVisible: false

        style: TableViewTheme{
            tableRef: servicesTable
        }

        QC1.TableViewColumn {
            title: "Completed"
            role: "completato"
            movable: false
            resizable: false
            width: servicesTable.width / servicesTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Time"
            role: "data_servizio"
            delegate: Text{
                text: model.data_servizio ? model.data_servizio.toLocaleDateString() : ""
                color: "white"
            }
            movable: false
            resizable: false
            width: servicesTable.width / servicesTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Brand"
            role: "marca"
            movable: false
            resizable: false
            width: servicesTable.width / servicesTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Year"
            role: "anno"
            movable: false
            resizable: false
            width: servicesTable.width / servicesTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Model"
            role: "modello"
            movable: false
            resizable: false
            width: servicesTable.width / servicesTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Name"
            role: "nome_cliente"
            movable: false
            resizable: false
            width: servicesTable.width / servicesTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Surname"
            role: "cognome"
            movable: false
            resizable: false
            width: servicesTable.width / servicesTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Description"
            role: "descrizione"
            movable: false
            resizable: false
            width: servicesTable.width / servicesTable.columnCount 
        }
    }

    Services {
        id: dataServices
        workshop: root.workShopIndex
    }
}