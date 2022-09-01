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

    QC1.TextField {
        id: nameFilter
        height: parent.height *.05
        width: parent.width * .5
        anchors{
            top: parent.top
            left: parent.left
            topMargin: parent.height *.05
            leftMargin: anchors.topMargin
        }
        font{   
            pointSize: 16
        }
        placeholderText: "Find employee by name or surname"
        style: TextFieldTheme{}
    }

    Rectangle{
        id: emtpyList
        color: appPalette.dark
        visible: employeesTable.rowCount === 0
        anchors.fill: employeesTable
        radius: 10 
        Label{
            id: emtpyListLabel
            width: contentWidth
            height: contentHeight
            text: "No employees"
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            anchors{
                centerIn: parent
            }
            font{
                pointSize: 20
            }
            color: appPalette.placeHolderText
        }
    }

    QC1.TableView {
        id: employeesTable
        height: parent.height *.8
        width: parent.width * .95
        anchors{
            top: nameFilter.bottom
            topMargin: parent.height *.05
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