import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4


import WorkshopsModel 1.0


Item{
    id: root
    property var appPalette: undefined

    //Rectangle{
    //    id: titleBar
    //    width: parent.width * 1.1
    //    height: parent.height *.06
    //    anchors{
    //        top: parent.top
    //        topMargin: -5
    //        horizontalCenter: parent.horizontalCenter
    //    }
//
    //    color: appPalette.light
    //}


    /////////////////////////APPLICATION TITLE/////////////////////////
    Label{
        id: mainTitle
        width: root.width * .35
        height: root.height *.05
        anchors{
            verticalCenter: titleBar.verticalCenter
            left: parent.left
        }
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        font{
            pointSize: 20
            bold: true
            family: "Ubuntu"
        }
        color: root.appPalette.limeGreen
        text: "CAR WORKSHOP MANAGER"
        background: Rectangle{
            anchors.fill: parent
            color: appPalette.dark
            radius: 10
        }

    }

    /////////////////////////WORKSHOPS LIST/////////////////////////

    ColumnLayout{
        id: workShopsView

        width: parent.width *.4
        height: parent.height *.9

        spacing: 10
        anchors{ 
            top: mainTitle.bottom
            topMargin: parent.height *.03
            horizontalCenter: parent.horizontalCenter
        }

        Repeater{
            id: workShopsRepeater
            model: WorkshopsModel { }
            
            delegate: Item {
                id: workShopDelegate
                Layout.fillWidth: true
                Layout.fillHeight: true

                state: "unselected"

                states:[
                    State{
                        name: "unselected"
                        PropertyChanges {
                            target: backGroundLabel
                            color: root.appPalette.dark
                        }
                        PropertyChanges {
                            target: workShopDelegate
                            scale: 1
                        }
                    },
                    State{
                        name: "selected" 
                        PropertyChanges {
                            target: backGroundLabel
                            color: root.appPalette.midLight
                        }
                        PropertyChanges {
                            target: workShopDelegate
                            scale: 1.1
                        }
                    }
                ]

                Behavior on scale {
                    NumberAnimation { duration: 100 }
                }

                Rectangle{
                    id: backGroundLabel
                    anchors.fill: parent
                    radius: 10
                    border{
                        color: root.appPalette.light

                    }
                }

                ColumnLayout{
                    id: textAligner
                    width: parent.width
                    height: parent.height *.5
                    anchors{
                        centerIn: parent
                    }
                    Label{
                        id: workShopName
                        Layout.preferredWidth: contentWidth +10
                        Layout.preferredHeight: contentHeight +10
                        Layout.alignment: Qt.AlignCenter
                        text: model.via
                        color: appPalette.text
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        font{
                            pointSize: 16
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: appPalette.light
                            radius: 10
                        }
                        
                    }
                    Label{
                        id: workShopAddress
                        Layout.preferredWidth: contentWidth + 10
                        Layout.preferredHeight: contentHeight + 10
                        Layout.alignment: Qt.AlignCenter
                        text: model.citta
                        color: appPalette.text
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        font{
                            pointSize: 12
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: appPalette.light
                            radius: 10
                        }
                    }
                }
                MouseArea{
                    id: clickHandler
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    anchors{

                        fill: parent
                    }
                    onEntered:{
                        workShopDelegate.state = "selected"
                    }
                    onExited:{
                        workShopDelegate.state = "unselected"
                    }
                    onClicked:{
                            mainStack.push(workshopDetails)
                    }

                }
            }
        }
    }

    
}