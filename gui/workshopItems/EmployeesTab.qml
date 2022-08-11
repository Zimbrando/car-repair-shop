import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Employees 1.0
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
        placeholderText: "Find employee"
    }

    QC1.TableView {
        id: employeesTable
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
            tableRef: employeesTable
        }
        

        QC1.TableViewColumn {
            title: "Name"
            role: "nome"
            movable: false
            resizable: false
            width: employeesTable.width / employeesTable.columnCount 

        }

        QC1.TableViewColumn {
            title: "Surname"
            role: "cognome"
            movable: false
            resizable: false
            width: employeesTable.width / employeesTable.columnCount 
        }
        
        QC1.TableViewColumn {
            title: "Tax Code"
            role: "codice_fiscale"
            movable: false
            resizable: false
            width: employeesTable.width / employeesTable.columnCount
        }
        
        QC1.TableViewColumn {
            title: "Email"
            role: "email"
            movable: false
            resizable: false
            width: employeesTable.width / employeesTable.columnCount
        }
    }

    Employees {
        id: data
        workshop: root.workShopIndex
        filter: nameFilter.text
    }
}