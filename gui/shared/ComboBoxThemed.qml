import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Material 2.12

T.ComboBox {
    property var themeUI
    property string color: appPalette.text
    property string prefix: ""
    property alias backgroundRectGradient: backgroundRect.gradient
    id: control

    font.pointSize: 16


    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    topInset: 0
    bottomInset: 0

    leftPadding: padding + (!control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    rightPadding: padding + (control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)


    delegate: ItemDelegate {
        id:delegateItem
        width: control.width
        height: control.height * 0.8
        highlighted: control.highlighedIndex === index
        contentItem: Rectangle{
            anchors.fill: parent
            border.color: appPalette.midLight
            border.width: 1
            color: "transparent"
            Label {
                id: textDelegate
                text: {
                    if(control.textRole) {
                        if(Array.isArray(control.model)){
                            return modelData[control.textRole]
                        }
                        else{
                            if(model[control.textRole] !== undefined) {
                                return model[control.textRole]
                            }
                            else {
                               return modelData[control.textRole]
                            }
                        }
                    }
                    else {
                        return modelData
                    }
                }

                width: parent.width * 0.9
                height: parent.height
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                anchors{
                    centerIn: parent
                }
                font{
                    pointSize: 16
                }
                color: control.color
            }  
        }
    }

    indicator: ColorImage {
        x: control.mirrored ? control.padding : control.width - width - control.padding
        y: control.topPadding + (control.availableHeight - height) / 2
        color: control.enabled ?  control.color : appPalette.brightText
        source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/Material/images/drop-indicator.png"
        rotation: control.popup.visible ? 180 : 0
    }

    contentItem: T.TextField {
        padding: 1
        leftPadding: control.editable ? 2 : control.mirrored ? 0 : 6
        rightPadding: control.editable ? 2 : control.mirrored ? 6 : 0

        text: control.editable ? control.editText : prefix + control.displayText

        enabled: control.editable
        autoScroll: control.editable
        selectByMouse: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator

        font: control.font
        color: control.enabled ?  control.color : appPalette.text
        selectionColor: appPalette.limeGreen
        selectedTextColor:  appPalette.text
        verticalAlignment: Text.AlignVCenter

    }
    background: Rectangle {
        id: backgroundRect

        implicitWidth: 120
        implicitHeight: control.Material.buttonHeight
        radius: 2
        border.color: appPalette.midLight
        gradient: Gradient {
            GradientStop { position: 0; color: appPalette.light}
            GradientStop { position: 0.5; color: appPalette.dark}
        }

        Rectangle {
            visible: control.editable
            y: parent.y + control.baselineOffset
            width: parent.width
            height: control.activeFocus ? 2 : 1
            color: control.editable && control.activeFocus ? appPalette.highlight : control.Material.hintTextColor
        }
    }
    popup: T.Popup {
        y: control.height - 1
        width: control.width
        height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
        transformOrigin: Item.Top
        topMargin: 12
        bottomMargin: 12


        enter: Transition {
            NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        exit: Transition {
            NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0
            highlight: Rectangle {
                color: appPalette.limeGreen
                opacity: 0.7
            }
            T.ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            radius: 1
            color:  appPalette.dark

        }
    }
}
