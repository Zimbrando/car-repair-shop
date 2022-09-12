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
}