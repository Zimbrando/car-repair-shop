import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Services 1.0

Item{
    id: root

    Rectangle{
        anchors.fill: parent
        border{
            color: "red"
            width: 2
        }
        color: "transparent"
    }

    RowLayout{
        id: itemsAligner
        width: parent.width *.98
        height: parent.height *.96
        anchors{
            centerIn: parent
        }
        QC1.Calendar {
            id: reservationsCalendar
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height *.8
            minimumDate: new Date(2022, 5, 1)
            maximumDate: new Date(2032, 5, 1)

            style: CalendarStyle {
                gridVisible: false
                background: Rectangle {
                    
                }
                dayDelegate: Rectangle {

                    gradient: Gradient {
                        GradientStop {
                            position: 0.00
                            color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");
                        }
                        GradientStop {
                            position: 1.00
                            color: styleData.selected ? "#444" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                        }
                        GradientStop {
                            position: 1.00
                            color: styleData.selected ? "#777" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                        }
                    }

                    Label {
                        text: styleData.date.getDate()
                        anchors.centerIn: parent
                        color: styleData.valid ? "white" : "grey"
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#555"
                        anchors.bottom: parent.bottom
                    }

                    Rectangle {
                        width: 1
                        height: parent.height
                        color: "#555"
                        anchors.right: parent.right
                    }
                }
            }

        }  
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            border{
                color: "red"
                width: 2
            }
            color: "transparent"

            Label{
                id: selectedDateLabel
                width: parent.width
                height: parent.height *.05
                color: appPalette.text
                font{
                    pointSize: 16
                }
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: reservationsCalendar.selectedDate.toLocaleDateString();
                background: Rectangle{
                            anchors.fill: parent
                            color: appPalette.light
                            radius: 10
                }

            }

            QC1.TableView {
                height: parent.height *.7
                width: parent.width * .8
                anchors{
                    top: selectedDateLabel.bottom
                    topMargin: selectedDateLabel.height *.1
                    horizontalCenter: parent.horizontalCenter
                }
                model: data.model
                backgroundVisible: true
                alternatingRowColors: true

            //    //headerDelegate: Rectangle {
            //    //    color: "transparent"
            //    //}

            //    //rowDelegate: Rectangle{
            //    //    color: "transparent"
            //    //}

                QC1.TableViewColumn {
                    title: "Completato"
                    role: "completato"
                    width: 40
                }

                QC1.TableViewColumn {
                    title: "Ora"
                    role: "ora"
                    delegate: Text{
                        text: model.ora ? model.ora.toLocaleTimeString() : ""
                    }
                    width: 70
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
        }

    }

    Services {
        id: data
        date: reservationsCalendar.selectedDate
        workshop: 1
    }
}