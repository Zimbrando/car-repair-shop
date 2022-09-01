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
        placeholderText: "Find service"
        style: TextFieldTheme{}
    }

    Rectangle{
        id: emtpyList
        color: appPalette.dark
        visible: servicesTable.rowCount === 0
        anchors.fill: servicesTable
        radius: 10 
        Label{
            id: emtpyListLabel
            width: contentWidth
            height: contentHeight
            text: "No services"
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
        id: servicesTable
        height: parent.height *.8
        width: parent.width * .95
        anchors{
            top: nameFilter.bottom
            topMargin: parent.height *.05
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
            title: "Status"
            role: "completato"
            movable: false
            resizable: false
            width: (servicesTable.width / servicesTable.columnCount ) / 2
            delegate: 
            Item {
                width: parent.width
                height: parent.height

                 Rectangle{
                    id: completedStatus
                    width: height
                    height: parent.height *.5
                    anchors{
                        centerIn: parent
                    }
                    radius: width/2
                    color:{
                        if(model && model.completato){
                            if (model.eseguito) {
                                return appPalette.okStatus
                            } else {
                                return appPalette.errorStatus
                            }
                        }else {
                            return appPalette.openStatus
                        }
                    }
                    border.color: appPalette.light
                }
            }
        }

        QC1.TableViewColumn {
            title: "Time"
            role: "data_servizio"
            delegate: 
            Item {
                width: parent.width
                height: parent.height
                Label {
                    width: parent.width *.96
                    height: parent.height *.8

                    anchors{
                        centerIn: parent
                    }

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: model && !model.data_servizio ?  "red" : appPalette.text
                    elide: Text.ElideRight
                    text: model && model.data_servizio  ? model.data_servizio.toLocaleDateString() : ""
                    font.pointSize: 15
                    background:Rectangle{
                        width: parent.width 
                        height: parent.height *.95
                        radius: 10
                        
                        color: appPalette.light
                        anchors{
                            centerIn: parent
                        }
                    }
                }
            }
            
            movable: false
            resizable: false
            width: (servicesTable.width / servicesTable.columnCount) * 1.5
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
            width: (servicesTable.width / servicesTable.columnCount) /2
        }

        QC1.TableViewColumn {
            title: "Model"
            role: "modello"
            movable: false
            resizable: false
            width: (servicesTable.width / servicesTable.columnCount ) / 2
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
            width: (servicesTable.width / servicesTable.columnCount) * 2
        }
    }

    Services {
        id: dataServices
        workshop: root.workShopIndex
        filter: nameFilter.text
    }
}