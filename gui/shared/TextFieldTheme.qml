import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Shapes 1.15

TextFieldStyle {
    id: root
    textColor: appPalette.text
    placeholderTextColor : appPalette.placeHolderText
    selectedTextColor: appPalette.text
    selectionColor: appPalette.limeGreen
    background:  Rectangle {
        implicitWidth: 100
        implicitHeight: font.pointSize * 2
        width: control.width
        height: control.height
        border.color:  appPalette.light
        border.width: 1
        radius: 4
        smooth: true
        gradient: Gradient{
            GradientStop { position: 1 ; color: appPalette.midLight}
            GradientStop { position: 0 ; color: appPalette.window }
        }
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            cursorShape: Qt.IBeamCursor
            hoverEnabled: true
        }
    }

}