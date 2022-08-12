import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Services 1.0

import "../shared"

Item{
    id: root
    property int workShopIndex: undefined

    RowLayout{
        id: itemsAligner
        width: parent.width *.98
        height: parent.height *.96
        anchors{
            centerIn: parent
        }
        Item{
            Layout.preferredWidth: parent.width *.30
            Layout.fillHeight: true
            QC1.Calendar {
                id: reservationsCalendar
                width: parent.width
                height: parent.height *.6
                anchors.centerIn: parent
                minimumDate: new Date(2022, 5, 1)
                maximumDate: new Date(2032, 5, 1)
                style: CalendarTheme{
                }
            }  

            ThemedButton{
                id: bookButton
                width: reservationsCalendar.width/2
                height: reservationsCalendar.height *.1
                anchors{
                    top: reservationsCalendar.bottom
                    topMargin: 5
                    horizontalCenter: parent.horizontalCenter
                }
                buttonText: "Book"
                selectedColor: "forestgreen"
                unselectedColor: appPalette.limeGreen
                textColor: appPalette.text
                actionHandler{
                    onClicked:{
                        stackRef.push(bookingPage)
                    }
                }
            }
        }
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            border{
                color: appPalette.midLight
                width: 1
            }
            radius: 10
            color: "transparent"

            Label{
                id: selectedDateLabel
                width: parent.width *.98
                height: parent.height *.05
                anchors{
                    top: parent.top
                    topMargin: parent.height *.02
                    horizontalCenter: parent.horizontalCenter
                }
                
                color: appPalette.text


                font{
                    pointSize: 16
                }
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: reservationsCalendar.selectedDate.toLocaleDateString();
                background: Rectangle{
                    anchors.fill: parent
                    color: appPalette.midLight
                    radius: 10
                }

            }

            QC1.TableView {
                id: reservationsTable
                height: parent.height - selectedDateLabel.height - parent.height *.05
                width: parent.width *.98
                anchors{
                    top: selectedDateLabel.bottom
                    topMargin: parent.height *.01
                    horizontalCenter: parent.horizontalCenter
                }
                model: data.model
                backgroundVisible: false
                alternatingRowColors: false
                frameVisible: false
                sortIndicatorVisible: false

                style: TableViewTheme{
                    tableRef: reservationsTable
                }

                QC1.TableViewColumn {
                    title: ""
                    role: "completato"
                    delegate:Item {
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
                                if(model.completato){
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
                    movable: false
                    resizable: false
                    width: (reservationsTable.width / reservationsTable.columnCount ) / 2
                }

                QC1.TableViewColumn {
                    title: "Type"
                    role: "tipo_servizio"
                    movable: false
                    resizable: false
                    width: (reservationsTable.width / reservationsTable.columnCount ) * 1.5
                }

                QC1.TableViewColumn {
                    title: "ETC"
                    role: "tempo_stimato"
                    delegate: Item {
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
                            color: !model.ora ?  "red" : appPalette.text
                            elide: Text.ElideRight
                            text: model.tempo_stimato ? model.tempo_stimato + "h" : ""
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

                            MouseArea{
                                id: toolTipTrigger
                                anchors.fill: parent
                                hoverEnabled: true
                            }

                            ToolTip {
                                id: control

                                x: toolTipTrigger.mouseX
                                y: toolTipTrigger.mouseY

                                implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                                        contentWidth + leftPadding + rightPadding)
                                implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                                        contentHeight + topPadding + bottomPadding)
                                margins: 6
                                padding: 6

                                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent | Popup.CloseOnReleaseOutsideParent
                                text: model.ora ? model.ora.getHours()+":"+model.ora.getMinutes() : "Not available"
                                delay: 1000
                                visible: toolTipTrigger.containsMouse
                                contentItem: Text {
                                    text: control.text
                                    font: control.font
                                    color: "white"
                                }
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "#222222"
                                    border.color: "#80000000"
                                    border.width: 2
                                }
                            }
                        }
                    }
                    movable: false
                    resizable: false
                    width: (reservationsTable.width / reservationsTable.columnCount ) / 2
                }

                QC1.TableViewColumn {
                    title: "Time"
                    role: "ora"
                    delegate: Item {
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
                            color: !model.ora ?  "red" : appPalette.text
                            elide: Text.ElideRight
                            text: model.ora ? model.ora.getHours()+":"+(model.ora.getMinutes() === 0 ? "00" : model.ora.getMinutes()) : ""
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

                            MouseArea{
                                id: toolTipTrigger
                                anchors.fill: parent
                                hoverEnabled: true
                            }

                            ToolTip {
                                id: control

                                x: toolTipTrigger.mouseX
                                y: toolTipTrigger.mouseY

                                implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                                        contentWidth + leftPadding + rightPadding)
                                implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                                        contentHeight + topPadding + bottomPadding)
                                margins: 6
                                padding: 6

                                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent | Popup.CloseOnReleaseOutsideParent
                                text: model.ora ? model.ora.getHours()+":"+model.ora.getMinutes() : "Not available"
                                delay: 1000
                                visible: toolTipTrigger.containsMouse
                                contentItem: Text {
                                    text: control.text
                                    font: control.font
                                    color: "white"
                                }
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "#222222"
                                    border.color: "#80000000"
                                    border.width: 2
                                }
                            }
                        }
                    }
                    movable: false
                    resizable: false
                    width: reservationsTable.width / reservationsTable.columnCount 
                }

                QC1.TableViewColumn {
                    title: "Brand"
                    role: "marca"
                    movable: false
                    resizable: false
                    width: reservationsTable.width / reservationsTable.columnCount 
                }

                QC1.TableViewColumn {
                    title: "Year"
                    role: "anno"
                    movable: false
                    resizable: false
                    width: reservationsTable.width / reservationsTable.columnCount 
                }

                QC1.TableViewColumn {
                    title: "Model"
                    role: "modello"
                    movable: false
                    resizable: false
                    width: reservationsTable.width / reservationsTable.columnCount 
                }

                QC1.TableViewColumn {
                    title: "Name"
                    role: "nome_cliente"
                    movable: false
                    resizable: false
                    width: reservationsTable.width / reservationsTable.columnCount 
                }

                QC1.TableViewColumn {
                    title: "Surname"
                    role: "cognome"
                    movable: false
                    resizable: false
                    width: reservationsTable.width / reservationsTable.columnCount 
                }

                QC1.TableViewColumn {
                    title: "Description"
                    role: "descrizione"
                    movable: false
                    resizable: false
                    width: (reservationsTable.width / reservationsTable.columnCount ) * 1.5
                }
            }
        }

    }

    Component{
        id: bookingPage
        BookingPage{
            id: bookingPageContent
            stackReference: stackRef
        }

    }


    Services {
        id: data
        date: reservationsCalendar.selectedDate
        workshop: workShopIndex
    }
}