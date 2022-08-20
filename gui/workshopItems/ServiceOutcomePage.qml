import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.15

import Clients 1.0

import "../shared"


Item{
    id: root

    property var stackReference
    property var preselectedDate: undefined
    property int selectedServiceId: undefined

    ThemedButton{
        id: backAction
        width: height
        height: view.height *.07
        anchors{

            top: parent.top
            left: parent.left
            topMargin: 2
            leftMargin: anchors.topMargin
        }  
        buttonText: "←"
        actionHandler{
            onClicked:{
                stackRef.pop()
            }
        }
    }

    Item {
        id: mainContainer
        anchors{
            top: parent.top
            right: parent.right
            left: backAction.right
            leftMargin: parent.width *.01
            bottom: parent.bottom
        }


        Label{
            id: pageTitle
            width: root.width * .85
            height: root.height *.05
            anchors{
                top: parent.top
                topMargin: parent.height *.05
                horizontalCenter: parent.horizontalCenter
            }
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            font{
                pointSize: 20
                bold: true
                family: "Ubuntu"
            }
            color: appPalette.text
            text: "Service outcome"
            background: Rectangle{
                anchors.fill: parent
                color: appPalette.dark
                radius: 10
            }

        }

        RowLayout{
            id: itemAligner
            width: parent.width *0.5
            height: parent.height *0.75
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: pageTitle.bottom
                topMargin: parent.height *.01
            }
            spacing: 30
            ColumnLayout{
                id: firstColumn
                Layout.fillWidth: true
                Layout.fillHeight: true

                Item{
                    id: datePicker
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Item{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Label{
                                id: dateLabel
                                anchors.fill: parent
                                text: "Date"
                                verticalAlignment: Qt.AlignBottom
                                horizontalAlignment: Qt.AlignLeft
                                font{
                                    bold: true
                                    pointSize: 20
                                }
                                color: appPalette.text
                            }
                        }
                        Item{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            QC1.TextField {
                                id: textDate
                                width: parent.width *.8
                                height: parent.height *.8
                                anchors{
                                    verticalCenter: parent.verticalCenter
                                    left: parent.left
                                }
                                placeholderText: "dd/mm/yy"
                                horizontalAlignment: Qt.horizontalCenter
                                text: preselectedDate ? Qt.formatDate(preselectedDate, "dd-MM-yyyy") : Qt.formatDate(calendarItem.selectedDate, "dd-MM-yyyy")
                                style: TextFieldTheme{}
                                font{
                                    pointSize: 16
                                }
                            }
                            ThemedButton {
                                id: button
                                width: parent.width * .20
                                height: parent.height *.8
                                anchors{
                                    verticalCenter: parent.verticalCenter
                                    left: textDate.right
                                    leftMargin: parent.width *0.01
                                }
                                buttonText: "▼"
                                textPointSize: 20
                                actionHandler{
                                    onClicked:{
                                        if(!calendarPicker.opened)
                                            calendarPicker.open()
                                    }
                                }
                            }
                        }
                    }
                }

                Item{
                    id: descriptionItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: descriptionLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Description"
                            verticalAlignment: Qt.AlignBottom
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        QC1.TextField {
                            id: descriptionField
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            placeholderText: "Type a description"
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                }              

                Item{
                    id: amountItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: amountLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Amount to pay"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        QC1.TextField {
                            id: amount
                            Layout.preferredWidth: parent.width * .30
                            Layout.fillHeight: true

                            placeholderText: "hh:mm"
                            inputMask: "9999,99;0"
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                } 

                Item{
                    id: outComeStatusItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: outComeStatusLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Status"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        CheckBox {
                            id: outComeStatusCheckBox
                            checked: false
                            text: "<font color='"+appPalette.text+"'>Service completed</font>"
                            font{
                                pointSize: 16
                            }
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }
                }
            }

        }

        ThemedButton{
            id: registerClient
            width: parent.width * .2
            height: parent.height * .05
            anchors{
                top: itemAligner.bottom
                topMargin: parent.height * .05
                right: itemAligner.right
            }  
            buttonText: "Register →"
            textColor: appPalette.text
            selectedColor: appPalette.limeGreen
            actionHandler{
                onClicked:{
                    //data.addClient(nameField.text, surnameField.text, taxCodeField.text, outComeStatusField.text, emailField.text)
                    stackRef.pop()
                }
            }
        }

        Rectangle{
            id: pageFrame
            color: calendarPicker.opened ? appPalette.window : "transparent"
            opacity: 0.7
            anchors.fill: parent
            border{
                color: appPalette.midLight
            }
            radius: 10 
        }
    }

    
    Popup {
        id: calendarPicker
        width: parent.width * .5
        height: parent.height *.6
        x: (parent.width - width)/2
        y: (parent.height - height)/2
        padding: 0
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        enter: Transition {
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 100}
            NumberAnimation { property: "scale"; from: 0.9; to: 1.0; duration: 150}
        }

        exit: Transition {
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 100}
            NumberAnimation { property: "scale"; from: 1.0; to: 0.9; duration: 150}
        }
        
        QC1.Calendar{
            id:calendarItem
            anchors.fill: parent
            visible: true
            minimumDate: new Date(2022, 5, 1)
            maximumDate: new Date(2032, 5, 1)
            style: CalendarTheme{
            }
            selectedDate: new Date()
            onClicked:  {
                textDate.text=Qt.formatDate(calendarItem.selectedDate, "dd-MM-yyyy");
                calendarPicker.close()
            }
        
        }
    }
}