import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4


import WorkshopsModel 1.0


Item{
    id: root
    
    /////////////////////////APPLICATION TITLE/////////////////////////

    Label{
        id: mainTitle
        width: contentWidth
        height: parent.height *.05
        anchors{
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        font{
            pointSize: 20
            bold: true
            family: "Helvetica"
        }
        color: "#32951C"
        text: "CAR WORKSHOP MANAGER"

    }

    /////////////////////////WORKSHOPS LIST/////////////////////////

    ColumnLayout{
        id: workShopsView

        width: parent.width *.4
        height: parent.height *.9

        spacing: 10
        anchors{ 
            centerIn: parent
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
                            color: "#292929"
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
                            color: "#2c2c2c"
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
                }

                ColumnLayout{
                    id: textAligner
                    anchors{
                        fill:parent 
                    }
                    Label{
                        id: workShopName
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: model.via
                        color: "white"
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        font{
                            pointSize: 16
                        }
                        
                    }
                    Label{
                        id: workShopAddress
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: model.citta
                        color: "white"
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignTop
                        font{
                            pointSize: 12
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