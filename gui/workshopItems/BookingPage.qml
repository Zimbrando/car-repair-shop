import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.15

import Services 1.0
import Services.ServicesTypeModel 1.0
import Vehicles 1.0
import Clients 1.0
import EmployeesFree 1.0

import "../shared"


Item{
    id: root

    property var stackReference
    property var preselectedDate: undefined
    property var employeesSelected:[]
    property var employeesSelectedLabels:[]

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
            text: "Book an appointment"
            background: Rectangle{
                anchors.fill: parent
                color: appPalette.dark
                radius: 10
            }

        }

        RowLayout{
            id: itemAligner
            width: parent.width *0.9
            height: parent.height *0.75
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: pageTitle.bottom
                topMargin: parent.height *.01
            }
            spacing: 30
            ColumnLayout{
                id: firstColumn
                Layout.fillWidth: true
                Layout.fillHeight: true
                Item{
                    id: namePicker
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: nameLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Name of the client"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }

                        ComboBoxThemed{
                            id: nameSelector
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height *.4

                            popup.onOpened: {
                                clientsData.refresh()
                            }

                            model: clientsData.model
                            Clients{
                                id: clientsData
                            }
                            textRole: "cognome"
                        }

                        // QC1.TextField {
                        //    // id: nameSelector
                        //     Layout.fillWidth: true
                        //     Layout.fillHeight: true
                        //     placeholderText: "Type a name"
                        //     style: TextFieldTheme{}
                        //     onActiveFocusChanged :{
                        //         if(activeFocus){
                        //              names.visible = true
                        //             names.open()   
                        //         }
                        //     }
                        //     font{
                        //         pointSize: 16
                        //     }
                        //     // menu: names
                        //     // Menu {
                        //     //     id: names
                        //     //     title: "Select name"
                        //     //     x: 0
                        //     //     y: (nameSelector.height)
                        //     //     width: nameSelector.width 
                        //     //     delegate: Label{
                        //     //         height: 20
                        //     //         text: itemDelegate.label 
                        //     //         background:Rectangle{
                        //     //             anchors.fill: parent
                        //     //             color: appPalette.dark
                        //     //         }
                        //     //     }
                        //     //     Instantiator {
                        //     //         model: ["marco","tiziano","ciao"]
                        //     //         MenuItem {
                        //     //             text: modelData
                        //     //             onTriggered: {
                        //     //                 nameSelector.text = text
                        //     //                 names.visible = false
                        //     //             }
                        //     //         }
                        //     //         onObjectAdded: names.insertItem(index, object)
                        //     //         onObjectRemoved: names.removeItem(object)
                        //     //     }

                        //     // }
                        // }
                    }
                }


                Item{
                    id: datePicker
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Row{
                        anchors.fill: parent
                        spacing: parent.width *.1
                        ColumnLayout{
                            width: parent.width/2
                            height: parent.height
                            spacing: 10
                            Item{
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Label{
                                    id: dateLabel
                                    anchors.fill: parent
                                    text: "Date"
                                    verticalAlignment: Qt.AlignBottom
                                    horizontalAlignment: Qt.AlignLeft
                                    font{
                                        bold: true
                                        pointSize: 20
                                    }
                                    color: appPalette.text
                                }
                            }
                            Item{
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                QC1.TextField {
                                    id: textDate
                                    width: parent.width *.8
                                    height: parent.height *.8
                                    anchors{
                                        verticalCenter: parent.verticalCenter
                                        left: parent.left
                                    }
                                    placeholderText: "dd/mm/yy"
                                    horizontalAlignment: Qt.horizontalCenter
                                    text: preselectedDate ? Qt.formatDate(preselectedDate, "dd-MM-yyyy") : Qt.formatDate(calendarItem.selectedDate, "dd-MM-yyyy")
                                    style: TextFieldTheme{}
                                    font{
                                        pointSize: 16
                                    }
                                }
                                ThemedButton {
                                    id: button
                                    width: parent.width * .20
                                    height: parent.height *.8
                                    anchors{
                                        verticalCenter: parent.verticalCenter
                                        left: textDate.right
                                        leftMargin: parent.width *0.01
                                    }
                                    buttonText: "▼"
                                    textPointSize: 20
                                    actionHandler{
                                        onClicked:{
                                            if(!calendarPicker.opened)
                                                calendarPicker.open()
                                        }
                                    }
                                }
                            }
                        }

                        ColumnLayout{
                            width: parent.width/2
                            height: parent.height
                            Layout.alignment: Qt.AlignCenter
                            //anchors{
                            //    horizontalCenter: parent.horizontalCenter
                            //    right: parent.right
                            //}
                            spacing: 10
                            Item{
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Label{
                                    id: timeLabel
                                    anchors.fill: parent
                                    text: "Time"
                                    verticalAlignment: Qt.AlignBottom
                                    horizontalAlignment: Qt.AlignLeft
                                    font{
                                        bold: true
                                        pointSize: 20
                                    }
                                    color: appPalette.text
                                }
                            }

                            Item{

                                Layout.preferredWidth: parent.width * .5
                                Layout.fillHeight: true
                                QC1.TextField {
                                    id: timePicker
                                    width: parent.width
                                    height: parent.height *.8
                                    anchors{
                                       centerIn: parent
                                    }
                                    placeholderText: "hh:mm"
                                    inputMask: "99:99;-"
                                    horizontalAlignment: Qt.horizontalCenter
                                    style: TextFieldTheme{}
                                    font{
                                        pointSize: 16
                                    }
                                }
                            }
                        }
                    }
                }
                
                Item{
                    id: employeeItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    ColumnLayout{
                        id: employeeColumn
                        width: parent.width *.7
                        height: parent.height
                        anchors{
                            left: parent.left
                        }
                        spacing: 10
                        
                        Label{
                            id: employeeLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Employees list"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        Label {
                            id: employeeField
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height *.4
                            horizontalAlignment: Qt.horizontalCenter
                            text: employeesSelectedLabels.toString()
                            wrapMode : Text.Wrap 
                            color: appPalette.text
                            font{
                                pointSize: 14
                            }
                            padding: 10
                            background: Rectangle{
                                anchors.fill: parent
                                border{
                                    color: appPalette.midLight
                                    width: 1
                                }
                                color: appPalette.dark
                                radius: 10
                            }
                        }
                        
                    }
                    ThemedButton {
                        id: chooseEmployees
                        width: parent.width *.2
                        height: employeeField.height * 0.8
                        anchors{
                            left: employeeColumn.right
                            bottom: employeeColumn.bottom
                            leftMargin: parent.width *.05
                        }
                        selectedColor: appPalette.limeGreen
                        textColor: appPalette.text
                        buttonText: "Choose"
                        actionHandler{
                            onClicked:{
                                employeesPicker.open()
                            }
                        }
                    }

                    
                }

                Item{
                    id: descriptionItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: descriptionLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Description"
                            verticalAlignment: Qt.AlignBottom
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        QC1.TextField {
                            id: descriptionField
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            placeholderText: "Type a description"
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                }

            }
            ColumnLayout{
                id: secondColumn
                Layout.fillWidth: true
                Layout.fillHeight: true

                 Item{
                    id: newClientButton
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    ThemedButton {
                        id: registerClient
                        width: parent.width *.32
                        height: parent.height *.4
                        anchors{
                            bottom: parent.bottom
                            left: parent.left
                        }
                        selectedColor: appPalette.limeGreen
                        textColor: appPalette.text
                        buttonText: "Register client"
                        actionHandler{
                            onClicked:{
                                stackRef.push(newClientPage)
                            }
                        }
                    }
                }


                Item{
                    id: vehicleItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: vehicleabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Vehicle"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }

                        ComboBoxThemed {
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height *.4
                            model: vehiclesData.model
                            Vehicles {id: vehiclesData}
                            textRole: "targa"
                        }
                        // QC1.TextField {
                        //     Layout.fillWidth: true
                        //     Layout.fillHeight: true

                        //     placeholderText: "Search a vehicle"
                        //     style: TextFieldTheme{}
                        //     font{
                        //         pointSize: 16
                        //     }
                        // }
                    }
                }
                
                Item{
                    id: serviceTypeItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: serviceTypeLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Service Type"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        ComboBoxThemed {
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height *.4
                            model: ServicesTypeModel {}
                            textRole: "nome"
                        }
                    }
                }

                Item{
                    id: estimatedTimeItem
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout{
                        anchors.fill: parent
                        spacing: 10
                        Label{
                            id: estimatedTimeLabel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "Estimated time"
                            verticalAlignment: Qt.AlignBottom
                            horizontalAlignment: Qt.AlignLeft
                            font{
                                bold: true
                                pointSize: 20
                            }
                            color: appPalette.text
                        }
                        QC1.TextField {
                            id: estimatedTIme
                            Layout.preferredWidth: parent.width * .30
                            Layout.fillHeight: true
                            onTextChanged: console.log(text)
                            placeholderText: "hh"
                            style: TextFieldTheme{}
                            font{
                                pointSize: 16
                            }
                        }
                    }
                }

            }
        }
        Popup {
            id: calendarPicker
            width: parent.width * .5
            height: parent.height *.6
            x: (parent.width - width)/2
            y: (parent.height - height)/2
            padding: 0
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            enter: Transition {
                NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 100}
                NumberAnimation { property: "scale"; from: 0.0; to: 1.0; duration: 100}
            }

            exit: Transition {
                NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 100}
                NumberAnimation { property: "scale"; from: 1.0; to: 0.0; duration: 100}
            }
            QC1.Calendar{
                id:calendarItem
                anchors.fill: parent
                visible: true
                minimumDate: new Date(2022, 5, 1)
                maximumDate: new Date(2032, 5, 1)
                style: CalendarTheme{
                }
                selectedDate: new Date()
                onClicked:  {
                    textDate.text=Qt.formatDate(calendarItem.selectedDate, "dd-MM-yyyy");
                    calendarPicker.close()
                }
            
            }
        }

        Popup {
            id: employeesPicker
            width: parent.width * .3
            height: parent.height *.75
            x: (parent.width - width)/2
            y: (parent.height - height)/2
            padding: 0
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            enter: Transition {
                NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 100}
                NumberAnimation { property: "scale"; from: 0.7; to: 1.0; duration: 100}
            }

            exit: Transition {
                NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 100}
                NumberAnimation { property: "scale"; from: 1.0; to: 0.7; duration: 100}
            }
            contentItem: Item{
                anchors.fill: parent
                Rectangle{
                    anchors.fill: parent
                    color: appPalette.dark
                }
                clip: true
                ListView{
                    id: employeesView
                    anchors.fill: parent
                    model: employeesData.model
                    ScrollBar.vertical: ScrollBar {
                        active: true
                        policy: ScrollBar.AsNeeded
                    }
                    delegate: Item {
                        id: employeesDelegate
                        width: employeesView.width 
                        height: employeesView.height *.1 
                        property var aIndex: model.iddipendente
                        property var checked: employeeCheckBox.checked
                        onCheckedChanged:{
                            if(checked){
                                if( root.employeesSelected.includes(aIndex))
                                    return
                                root.employeesSelected.push(aIndex)
                                root.employeesSelectedLabels.push(model.nome + " " + model.cognome)
                            }else{
                                if(root.employeesSelected.includes(aIndex)){
                                    for(var i = 0; i < root.employeesSelected.length; i++){ 
                                        if (root.employeesSelected[i] === aIndex) { 
                                            root.employeesSelected.splice(i, 1); 
                                            break
                                        }
                                    }
                                    for(var i = 0; i < root.employeesSelectedLabels.length; i++){ 
                                        if (root.employeesSelectedLabels[i] === model.nome + " " + model.cognome) { 
                                            root.employeesSelectedLabels.splice(i, 1); 
                                            break
                                        }
                                    }
                                } 
                            }
                            employeesSelected = employeesSelected
                            employeesSelectedLabels = employeesSelectedLabels
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
                            id: employeeCheckBox
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
                            id: workShopName
                            width: parent.width *.75
                            height: parent.height
                            anchors{
                                left: employeeCheckBox.right
                                leftMargin: 20
                                verticalCenter: parent.verticalCenter
                            }
                            Layout.alignment: Qt.AlignCenter
                            text: model.nome + " " + model.cognome + " - " + model.codice_fiscale
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

        }

        ThemedButton{
            id: confirmBooking
            width: parent.width * .2
            height: parent.height * .05
            anchors{
                top: itemAligner.bottom
                topMargin: parent.height * .05
                right: itemAligner.right
            }  
            buttonText: "Book service →"
            textColor: appPalette.text
            selectedColor: appPalette.limeGreen
            actionHandler{
                onClicked:{
                    data.addService(1, descriptionField.text, textDate.text)
                    //stackRef.pop()
                }
            }
        }

        Rectangle{
            id: pageFrame
            color: calendarPicker.opened || employeesPicker.opened ? appPalette.window : "transparent"
            opacity: 0.7
            anchors.fill: parent
            border{
                color: appPalette.midLight
            }
            radius: 10 
        }
    }

    Services {
        id: data

        workshop: workShopIndex 
    }

    EmployeesFree {
        id: employeesData
        workshop: workShopIndex
        hour: Date.fromLocaleTimeString(Qt.locale(), timePicker.text, "hh:mm")
        date: Date.fromLocaleString(Qt.locale(), textDate.text, "dd-MM-yyyy")
        estimated_time: parseInt(estimatedTIme.text) //Replace me
    }
}