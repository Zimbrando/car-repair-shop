import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Shapes 1.15

TableViewStyle {
    id: root

    property var tableRef: undefined

    corner:Item {
        implicitWidth: 20
        implicitHeight: 20
        Rectangle{
            color: appPalette.dark
            anchors.fill: parent
        }
    }

    handle: Rectangle {
        implicitWidth: 20
        implicitHeight: 20
        radius: 10
        color: appPalette.midLight
    }
    scrollBarBackground: Rectangle {
        implicitWidth: 20
        implicitHeight: 20
        opacity: 0.7
        color: appPalette.light
    }

    frame: Rectangle{

        anchors.fill: tableRef
        color: "transparent"
        border{ 
            color: appPalette.dark
            width: 1
        }
        radius: 5

    }

    decrementControl: Item {
        id: decrementStyle
        property var sData: styleData

        implicitWidth: 20
        implicitHeight: 20

        Rectangle{
            color: appPalette.dark
            anchors.fill: parent
            Shape {
                anchors{
                    fill: parent
                }
                visible: !decrementStyle.sData.horizontal
                ShapePath {
                    strokeWidth: 1
                    strokeColor: appPalette.light
                    fillColor: decrementStyle.sData.pressed ? appPalette.light : appPalette.text
                    strokeStyle: ShapePath.SolidLine
                    startX: 0; startY: height
                    PathLine { x: width/2; y: 0}
                    PathLine { x: width; y: height}
                    PathLine { x: 0; y: height }
                }
            }

            Shape {
                anchors.fill: parent
                visible: decrementStyle.sData.horizontal
                ShapePath {
                    strokeWidth: 1
                    strokeColor: appPalette.light
                    fillColor: decrementStyle.sData.pressed ? appPalette.light : appPalette.text
                    strokeStyle: ShapePath.SolidLine
                    startX: width; startY: 0
                    PathLine { x: 0; y: height/2}
                    PathLine { x: width; y: height}
                    PathLine { x: width; y: 0}
                }
            }
        }
    }
    incrementControl: Item {
        id: incrementStyle
        property var sData: styleData

        implicitWidth: 20
        implicitHeight: 20

        Rectangle{
            color: appPalette.dark
            anchors.fill: parent


            Shape {
                anchors{
                    fill: parent
                }
                visible: !incrementStyle.sData.horizontal
                ShapePath {
                    strokeWidth: 1
                    strokeColor: appPalette.light
                    fillColor: incrementStyle.sData.pressed ? appPalette.light : appPalette.text
                    strokeStyle: ShapePath.SolidLine
                    startX: 0; startY: 0
                    PathLine { x: width/2; y: height}
                    PathLine { x: width; y: 0}
                    PathLine { x: 0; y: 0 }
                }
            }

            Shape {
                anchors.fill: parent
                visible: incrementStyle.sData.horizontal
                ShapePath {
                    strokeWidth: 1
                    strokeColor: appPalette.light
                    fillColor: incrementStyle.sData.pressed ? appPalette.light : appPalette.text
                    strokeStyle: ShapePath.SolidLine
                    startX: 0; startY: 0
                    PathLine { x: width; y: height/2}
                    PathLine { x: 0; y: height}
                    PathLine { x: 0; y: 1}
                }
            }
        }
    }

    textColor: appPalette.text

    headerDelegate: Item {
        width: tableRef.width
        height: tableRef.height *.1
        Rectangle{
            color: appPalette.window
            anchors{
                fill: parent
            }
        }
        RowLayout{

            anchors{
                fill: parent
            }
            Rectangle{
                id: columnItem
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: appPalette.dark
                radius: 0
                Label {

                    id: textItem

                    width: parent.width *.78
                    height: parent.height

                    anchors{
                        centerIn: parent
                    }

                    // Rectangle{
                    //    color: "transparent"
                    //    border.width: 2
                    //    border.color: Qt.rgba(Math.random(),Math.random(),Math.random(),1);
                    //    anchors.fill: parent
                    // }

                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter

                    text: styleData.value
                    color: appPalette.text
                    font.bold: true
                    font.pointSize: 15
                }

                // Label {
                //     id: columnSortIndicator
                //     anchors{
                //         verticalCenter: parent.verticalCenter
                //         left: textItem.right
                //         right: parent.right
                //     }

                //     Rectangle{
                //        color: "transparent"
                //        border.width: 2
                //        border.color: Qt.rgba(Math.random(),Math.random(),Math.random(),1);
                //        anchors.fill: parent
                //     }

                //     width: 50
                //     height: parent.height
                //     font.pointSize: {
                //         if(tableView.sortIndicatorColumn === styleData.column) {
                //             12
                //         }
                //         else 10
                //     }
                //     style: {
                //         if(tableView.sortIndicatorColumn === styleData.column) {
                //             Text.Normal
                //         }
                //         else Text.Outline
                //     }
                //     styleColor: GUIStyle.palette.text
                //     text: {
                //         //&& enabledColumn.count >= styleData.column && enabledColumn.get(styleData.column).selected
                //         if(styleData.column >= 0 ) {
                //             if(tableView.sortIndicatorOrder === Qt.DescendingOrder && tableView.sortIndicatorColumn === styleData.column) {
                //                 "▲"
                //             }
                //             else if(tableView.sortIndicatorColumn === styleData.column){
                //                 "▼"
                //             }
                //             else "▼"
                //         }
                //         else ""
                //     }
                //     color: {
                //         if(tableView.sortIndicatorColumn === styleData.column) {
                //             GUIStyle.palette.text
                //         }
                //         else "transparent"
                //     }
                // }

            }
        }
    }

    itemDelegate: Item {
        width: parent.width //tableView.viewport.width / tableView.columnCount
        height: parent.height
        Label {
            width: parent.width *.96
            height: parent.height *.8

            anchors{
                centerIn: parent
            }

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: text === "N/A" ?  "red" : appPalette.text
            elide: Text.ElideRight
            text: {
                if(!styleData) return "N/A"
                if(styleData.value === undefined || styleData.value === null ) return "N/A"
                if(styleData.value === "") return "N/A"
                return styleData.value 

            }
            font.pointSize: 15
            background:Rectangle{
                width: parent.width 
                height: parent.height *.95
                radius: 10
                //border{
                //    width: 1
                //    color: GUIStyle.palette.buttonText
                //}
                color: appPalette.light
                anchors{
                    centerIn: parent
                }
            }
        }
    }

    rowDelegate: Rectangle{
        id: rowgradient
        height: 60
        color: "transparent"
        Rectangle {

            color: appPalette.dark
            anchors{
                fill: parent
                bottomMargin: 5
            }
            //x: tableView.viewport.width / tableView.columnCount + modelData * tableView.viewport.width / tableView.columnCount
        }


    }
}