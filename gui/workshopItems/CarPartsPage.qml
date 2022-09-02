import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.15

import Components 1.0

import "../shared"


Item{
    id: root

    property var stackReference
    property var preselectedDate: undefined
    property int selectedServiceId: undefined
    property var carPartsSelected: []
    property int workshopIndex

    ThemedButton{
        id: backAction
        width: height
        height: view.height *.07
        anchors{

            top: parent.top
            left: parent.left
            topMargin: 2
            leftMargin: anchors.topMargin
        }  
        buttonText: "←"
        actionHandler{
            onClicked:{
                stackRef.pop()
            }
        }
    }

    Item {
        id: mainContainer
        anchors{
            top: parent.top
            right: parent.right
            left: backAction.right
            leftMargin: parent.width *.01
            bottom: parent.bottom
        }


        Label{
            id: pageTitle
            width: root.width * .85
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
            text: "Car parts"
            background: Rectangle{
                anchors.fill: parent
                color: appPalette.dark
                radius: 10
            }

        }

         Rectangle{
            id: emtpyList
            color: appPalette.dark
            visible: carPartsView.count === 0
            anchors.fill: carPartsList
            radius: 10 
            Label{
                id: emtpyListLabel
                width: contentWidth
                height: contentHeight
                text: "No parts"
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                anchors{
                    centerIn: parent
                }
                font{
                    pointSize: 20
                }
                color: appPalette.placeHolderText
            }
        }

        Item{
            id: carPartsList
            anchors{
                top: pageTitle.bottom
                topMargin: parent.height *.05
                horizontalCenter: parent.horizontalCenter
            }
            width: pageTitle.width *.8
            height: parent.height *.7
            clip: true
            ListView{
                id: carPartsView
                anchors.fill: parent
                model: data.model
                ScrollBar.vertical: ScrollBar {
                    active: true
                    policy: ScrollBar.AsNeeded
                }
                delegate: Item {
                    id: carPartDelegate
                    width: carPartsView.width 
                    height: carPartsView.height *.1 
                    property var aIndex: model.idcomponente
                    property var checked: carPartCheckBox.checked
                    onCheckedChanged:{
                        if(checked){
                            if( root.carPartsSelected.includes(aIndex))
                                return
                            root.carPartsSelected.push(aIndex)
                        }else{
                            if(root.carPartsSelected.includes(aIndex)){
                                for(var i = 0; i < root.carPartsSelected.length; i++){ 
                                    if (root.carPartsSelected[i] === aIndex) { 
                                        root.carPartsSelected.splice(i, 1); 
                                        break
                                    }
                                }

                            } 
                        }
                        carPartsSelected = carPartsSelected
                    }

                    Rectangle{
                        id: backGroundLabel
                        anchors{
                            fill: parent
                            margins: 10
                        }
                        radius: 10
                        color: appPalette.light
                    }

                    
                    CheckBox {
                        id: carPartCheckBox
                        checked: false
                        width: parent.width *.15
                        height: parent.height *.5
                        anchors{
                            left: parent.left
                            leftMargin: 20
                            verticalCenter: parent.verticalCenter
                        }
                    }
                    Label{
                        id: carPartName
                        width: parent.width *.75
                        height: parent.height
                        anchors{
                            left: carPartCheckBox.right
                            leftMargin: 20
                            verticalCenter: parent.verticalCenter
                        }
                        Layout.alignment: Qt.AlignCenter
                        text: model.seriale + " " + model.nome + " " + model.marca + " " + model.prezzo + "€"
                        color: appPalette.text
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                        font{
                            pointSize: 16
                        }
                        background: Rectangle{
                            anchors.fill: parent
                            color: "transparent"//appPalette.light
                            radius: 10
                        }
                        
                    }
                    
                }
            }
        }

        ThemedButton{
            id: confirmParts
            width: parent.width * .5
            height: parent.height * .05
            anchors{
                top: carPartsList.bottom
                topMargin: parent.height * .05
                horizontalCenter: parent.horizontalCenter
            }  
            buttonText: "Confirm →" //slotData.full ? "Not available" : "Confirm →"
            textColor: appPalette.text
            selectedColor:  appPalette.limeGreen //slotData.full ? appPalette.errorStatus : appPalette.limeGreen
            actionHandler{
                onClicked: {
                    let check = true
                    root.carPartsSelected.forEach(id => {
                        if (check)
                            check = data.assignComponentTo(id, selectedServiceId)
                    });
                    if (check)
                        stackRef.pop()
                    else data.refresh()
                }
            }
        }
    }

    Components {
        id: data
        workshop: workshopIndex
        group: false
    }
}