import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.15

import Services 1.0

import "../shared"


Item{
    id: root

    property var stackReference
    property var preselectedDate: undefined

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
            text: "Register a client"
            background: Rectangle{
                anchors.fill: parent
                color: appPalette.dark
                radius: 10
            }

        }

        RowLayout{
            id: itemAligner
            width: parent.width *0.9
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
                    id: namePicker
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: nameLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Name"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }

                        QC1.TextField {
                            id:  nameField
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            placeholderText: ""
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                }

                Item{
                    id: datePicker
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: surnameLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Surname"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }

                        QC1.TextField {
                            id: surnameField
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            placeholderText: ""
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                }
                
                Item{
                    id: employeeItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: taxCodeLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Tax Code"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                         QC1.TextField {
                            id: taxCodeField
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            placeholderText: ""
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                }

                

            }
            ColumnLayout{
                id: secondColumn
                Layout.fillWidth: true
                Layout.fillHeight: true

                Item{
                    id: emailItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: emailLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Email"
                            verticalAlignment: Qt.AlignBottom
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        QC1.TextField {
                            id: emailField
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            placeholderText: "example@hotmail.com"
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                }
                
                Item{
                    id:  phoneNumberItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: phoneNumberLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Phone Number"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        QC1.TextField {
                            id: phoneNumberField
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            inputMask:"9999999999"
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                }

                Item{
                    id: companyNameItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: companyNameLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Company Name"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        QC1.TextField {
                            id: companyNameField
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
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
                    //stackRef.pop()
                }
            }
        }

        Rectangle{
            id: pageFrame
            color: "transparent"
            opacity: 0.7
            anchors.fill: parent
            border{
                color: appPalette.midLight
            }
            radius: 10 
        }
    }
}