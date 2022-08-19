import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Shapes 1.15

CalendarStyle{
    id: root

    gridVisible: false
    gridColor: appPalette.midLight

    background: Rectangle {
        implicitWidth: 250
        implicitHeight: 250
        color: Qt.rgba(appPalette.dark.r, appPalette.dark.g, appPalette.dark.b, 0.7)

    }

    dayOfWeekDelegate:  Rectangle {
        color: Qt.rgba(appPalette.limeGreen.r, appPalette.limeGreen.g, appPalette.limeGreen.b, 0.4)
        implicitHeight: 50
        Label {
            text: control.locale.dayName(styleData.dayOfWeek, control.dayOfWeekFormat)
            anchors.centerIn: parent
            color: appPalette.text
            font.pointSize: 14
        }
    }

    dayDelegate: Rectangle {
        gradient: Gradient {
            GradientStop {
                position: 0.00
                color: styleData.selected ? appPalette.dark : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");
            }
            GradientStop {
                position: 1.00
                color: styleData.selected ? appPalette.limeGreen : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
            }
            GradientStop {
                position: 1.00
                color: styleData.selected ? appPalette.limeGreen : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
            }
        }
        Label {
            text: styleData.date.getDate()
            anchors.centerIn: parent
            color: styleData.valid ? appPalette.text : appPalette.light
            font.pointSize: 15
        }

        Rectangle {
            width: parent.width
            height: 1
            color: appPalette.limeGreen
            anchors.bottom: parent.bottom
        }

        Rectangle {
            width: 1
            height: parent.height
            color: appPalette.limeGreen
            anchors.right: parent.right
        }
    }

    navigationBar: Rectangle {
        color: Qt.rgba(appPalette.limeGreen.r, appPalette.limeGreen.g, appPalette.limeGreen.b, 0.4)
        border. color: Qt.rgba(appPalette.dark.r, appPalette.dark.g, appPalette.dark.b, 0.7)
        border.width: 2
        implicitHeight: 100

        ThemedButton{
            id: previousMonth
            width: height
            height: parent.height *0.9
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 5
            }
            buttonText: "←"
            actionHandler{
                onClicked:{
                    control.showPreviousMonth()
                }
            }
        }


        Label {
            id: dateText
            text: styleData.title
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: previousMonth.right
            anchors.leftMargin: 2
            anchors.right: nextMonth.left
            anchors.rightMargin: 2
            color: appPalette.text
        }


        ThemedButton{
            id: nextMonth
            width: height
            height: parent.height *0.9
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 5
            }
            buttonText: "→"
            actionHandler{
                onClicked:{
                    control.showNextMonth()
                }
            }
        }

    }
}