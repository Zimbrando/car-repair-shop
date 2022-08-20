import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

Item{
    id: root
    property int workShopIndex: -1
    property string workShopAddress: ""
    anchors.fill: parent

    Label{
        id: pageTitle
        width: root.width * .5
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
        text: workShopAddress
        background: Rectangle{
            anchors.fill: parent
            color: appPalette.dark
            radius: 10
        }

    }


    ColumnLayout{
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
    }
}