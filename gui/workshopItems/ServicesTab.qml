import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Vehicles 1.0
import Vehicles.BrandsModel 1.0

import "../shared"

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
        id: serviceTable
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
            tableRef: serviceTable
        }

        QC1.TableViewColumn {
            title: "ID"
            role: "id"
            movable: false
            resizable: false
            width: serviceTable.width / serviceTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Name"
            role: "name"
            movable: false
            resizable: false
            width: serviceTable.width / serviceTable.columnCount 
        }
    }
}