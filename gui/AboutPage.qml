import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import "./shared"

Item{
    id: root

    ThemedButton{
        id: backAction
        width: height
        height: parent.height *.07
        anchors{

            top: parent.top
            left: parent.left
            topMargin: 2
            leftMargin: anchors.topMargin
        }  
        buttonText: "←"
        actionHandler{
            onClicked:{
                mainStack.pop()
            }
        }
    }
    Item{
        width: root.width * .6
        height: root.height *.55
        anchors{
            centerIn: parent
        }
        Label{
            id: pageTitle
            width: parent.width
            height: parent.height *.1

            anchors{
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
            text: "About"
            background: Rectangle{
                anchors.fill: parent
                color: appPalette.dark
                radius: 10
            }
        }

        Label{
            id: aboutUs
            width: parent.width
            height: parent.height *.9
            text: "This application is part of a database systems project for the University of Bologna<br>Made by Marco Sternini and Tiziano Vuksan<br>2022"
            anchors{
                top: pageTitle.bottom
                topMargin: -15
                horizontalCenter: parent.horizontalCenter
            }
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            font{
                bold: true
                pointSize: 20
            }
            color: appPalette.placeHolderText
            background: Rectangle{
                anchors.fill: parent
                border{
                    color: appPalette.dark
                    width: 2
                }
                radius: 10
                color: "transparent"
            }
        }
    }


    /*ColumnLayout{
        width: parent.width *.5
        height: parent.height *.5
        anchors{
            centerIn: parent
        }
        Repeater{
            id: itemRepeater
            model: 4
            delegate: Item{
                id: itemDelegate
                property var aIndex: index
                Layout.fillWidth: true
                Layout.fillHeight: true
                RowLayout{
                    anchors.fill: parent
                    spacing: 10
                    Label{
                        id: revenueLabel
                        Layout.preferredWidth: contentWidth + 20
                        Layout.fillHeight: true
                        text: {
                            switch(itemDelegate.aIndex){
                                case 0: 
                                return "Gross revenue:"
                                case 1:
                                return "Best worker(s):"
                                case 2:
                                return "Most repaired vehicles brands:"
                                case 3:
                                return "Most requested car parts:"
                            }
                            
                        }
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter
                        font{
                            bold: true
                            pointSize: 20
                        }
                        color: appPalette.text
                    }

                    Label{
                        id: revenueValue
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: {
                            switch(itemDelegate.aIndex){
                                case 0: 
                                return "7897563474465$"
                                case 1:
                                return "Stern e Tiz best workers forever"
                                case 2:
                                return "Audi, Mercedes, Fiat"
                                case 3:
                                return "Olio, Pneumatici, Frizione"
                            }
                            
                        }
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignLeft
                        font{
                            bold: true
                            pointSize: 20
                        }
                        color: appPalette.placeHolderText
                    }
                }
            }
        }
    }*/
}