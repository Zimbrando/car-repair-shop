import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Components 1.0

import "../shared"

Item{
    id: root
    anchors.fill: parent
    property var appPalette: undefined
    property int workShopIndex: undefined

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
        placeholderText: "Find component"
        style: TextFieldTheme{}
    }

    Rectangle{
        id: emtpyList
        color: appPalette.dark
        visible: warehouseTable.rowCount === 0
        anchors.fill: warehouseTable
        radius: 10 
        Label{
            id: emtpyListLabel
            width: contentWidth
            height: contentHeight
            text: "No components"
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
        id: warehouseTable
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
            tableRef: warehouseTable
        }

        QC1.TableViewColumn {
            title: "Serial #"
            role: "seriale"
            movable: false
            resizable: false
            //visible: !data.group
            width: warehouseTable.width / warehouseTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Name"
            role:  "nome" 
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
            role:  "prezzo" 
            movable: false
            resizable: false
            width: warehouseTable.width / warehouseTable.columnCount 
        }

        QC1.TableViewColumn {
            title: "Quantity"
            role:  "quantita" 
            movable: false
            resizable: false
            //visible: data.group
            width: warehouseTable.width / warehouseTable.columnCount 
        }
    }

    Components {
        id: data
        workshop: root.workShopIndex
        group: false
        filter: nameFilter.text
    }
}