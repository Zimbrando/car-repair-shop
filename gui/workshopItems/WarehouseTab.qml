import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Components 1.0

import "../shared"

Item{
    anchors.fill: parent

    property int workshopId: 1

    TextField {
        id: nameFilter
        height: parent.height *.1
        width: parent.width * .8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15
        placeholderText: "Find component"
    }

    QC1.TableView {
        id: warehouseTable
        height: parent.height *.7
        width: parent.width * .8
        anchors{
            top: nameFilter.bottom
            topMargin: parent.height *.1
            horizontalCenter: parent.horizontalCenter
        }
        model: data.model
        backgroundVisible: false
        alternatingRowColors: false
        frameVisible: false
        sortIndicatorVisible: false

        style: TableViewTheme{
            tableRef: warehouseTable
        }

        QC1.TableViewColumn {
            title: "Serial #"
            role: "seriale"
            movable: false
            resizable: false
            width: warehouseTable.width / warehouseTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Name"
            role: "nome"
            movable: false
            resizable: false
            width: warehouseTable.width / warehouseTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Brand"
            role: "marca"
            movable: false
            resizable: false
            width: warehouseTable.width / warehouseTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Price"
            role: "prezzo"
            movable: false
            resizable: false
            width: warehouseTable.width / warehouseTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Quantity"
            role: "quantita"
            movable: false
            resizable: false
            width: warehouseTable.width / warehouseTable.columnCount 
        }
    }

    Components {
        id: data
        workshop: workshopId
        group: true
    }
}