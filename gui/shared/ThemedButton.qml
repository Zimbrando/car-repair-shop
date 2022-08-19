import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

Item {
    id: root

    property alias buttonText: controlText.text
    property alias textColor: controlText.color
    property alias textPointSize: controlText.font.pointSize
    property alias actionHandler: backHandler
    property alias selectedColor: backRectangle.selectedColor
    property alias unselectedColor: backRectangle.unselectedColor

    Rectangle{
        id: backRectangle
        property color selectedColor: appPalette.midLight
        property color unselectedColor: appPalette.dark

        anchors.fill: parent
        radius: 10
        state: "unselected"
        states:[
            State{
                name: "unselected"
                PropertyChanges {
                    target: backRectangle
                    color: unselectedColor
                }
            },
            State{
                name: "selected" 
                PropertyChanges {
                    target: backRectangle
                    color: selectedColor
                }
            }
        ]  
    }  

    Label{
        id: controlText
            anchors{
            fill: parent
        }
        text: ""
        color: appPalette.placeHolderText
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        font{
            pointSize: 20
        }

        
    }
    
    MouseArea{
        id: backHandler
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        anchors{

            fill: parent
        }
        onEntered:{
            backRectangle.state = "selected"
        }
        onExited:{
            backRectangle.state = "unselected"
        }
        onPressed:{

            backRectangle.scale = 0.95
        }

        onReleased:{

            backRectangle.scale = 1
        }

    }
}