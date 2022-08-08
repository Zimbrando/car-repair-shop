import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Workshops 1.0
import Vehicles 1.0
import Vehicles.BrandsModel 1.0


ApplicationWindow {
    id: mainWindow

    visible: true
    
    height: 800
    width: 1200

    title: "CAR REPAIR SHOP"

    Item{

        id: root

        property var worskShopsModel:[
            {
                name: "Workshop 1",
                address: "Via Travaglini 25"
            },
            {
                name: "Workshop 2",
                address: "Via Brombeis 69"
            },
            {
                name: "Workshop 3",
                address: "Via Zara 42"
            },
            {
                name: "Workshop 4",
                address: "Via Filippo Re 15A"
            },
            {
                name: "Workshop 5",
                address: "Via Giovanni Storti 73"
            }

            
        ]

        anchors{
            fill: parent
        }
        
        Rectangle{
            
            id: background
            anchors.fill: parent
            color: "#1F1F1F"
        }

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

        /////////////////////////MAIN CAR WORKSHOP LIST/////////////////////////

        StackView {
            id: mainStack
            property bool opened: state === "expanded"
            property var lastPushed

            anchors {
                top: mainTitle.bottom
                bottom: parent.bottom
                right: parent.right
                left: parent.left
            }

            initialItem : mainPage

            pushEnter: Transition {
                XAnimator {
                    from: (mainStack.mirrored ? -1 : 1) * mainStack.width
                    to: 0
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }

            popExit: Transition {
                XAnimator {
                    from: 0
                    to: (mainStack.mirrored ? -1 : 1) * mainStack.width
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }

        }

        Item{
            id: mainPage
            width: parent.width
            height: parent.height
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
                    model: root.worskShopsModel
                    
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
                                text: modelData.name
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
                                text: modelData.address
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
        
        Component{
            id: workshopDetails 
            Item{
                id: workshopDetails
                width: root.width
                height: root.height

                Item {
                    id: backAction
                    width: parent.width *.05
                    height: width
                    anchors{

                        top: parent.top
                        left: parent.left
                        topMargin: parent.height *.01
                        leftMargin: anchors.topMargin
                    }  
   
                    Rectangle{
                        id: backRectangle
                        anchors.fill: parent
                        radius: 10
                        state: "unselected"
                        states:[
                            State{
                                name: "unselected"
                                PropertyChanges {
                                    target: backRectangle
                                    color: "#292929"
                                    scale: 1
                                }
                            },
                            State{
                                name: "selected" 
                                PropertyChanges {
                                    target: backRectangle
                                    color: "#2c2c2c"
                                }
                            }
                        ]  
                    }  

                    Label{
                        id: backIndicator
                         anchors{

                            fill: parent
                        }
                        text: "←"
                        color: "gray"
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
                        onClicked:{
                                mainStack.pop()

                        }

                    }
                }

                QC1.TabView {
                    id: view
                    anchors{
                        top: parent.top
                        right: parent.right
                        left: backAction.right
                        leftMargin: parent.width *.01
                        bottom: parent.bottom
                    }

                    QC1.Tab {
                        id: firstPage
                        title: "Workshops"
                        active: true
                        Item{
                            anchors.fill: parent
                            TextField {
                                id: nameFilter
                                height: parent.height *.1
                                width: parent.width * .8
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 15
                                placeholderText: "Filter by name"
                            }

                            QC1.TableView {
                                height: parent.height *.7
                                width: parent.width * .8
                                anchors{
                                    top: nameFilter.bottom
                                    topMargin: parent.height *.1
                                    horizontalCenter: parent.horizontalCenter
                                }
                                model: data.model
                                backgroundVisible: false
                                alternatingRowColors: false

                                headerDelegate: Rectangle {
                                    color: "transparent"
                                }

                                rowDelegate: Rectangle{
                                    color: "transparent"
                                }

                                QC1.TableViewColumn {
                                    title: "ID"
                                    role: "id"
                                }

                                QC1.TableViewColumn {
                                    title: "name"
                                    role: "name"
                                }
                            }
                            Workshops {
                                id: data

                                name: nameFilter.text
                            }
                        }

                        
                    }

                    QC1.Tab {
                        id: secondPage
                        title: "Vehicles"
                        Item{
                            anchors.fill: parent

                            ComboBox {
                                id: brandFilters
                                height: parent.height *.1
                                width: parent.width * .8
                                anchors{
                                    horizontalCenter: parent.horizontalCenter
                                    top: parent.top
                                    topMargin: 15
                                }
                                currentIndex: -1

                                model: BrandsModel {}

                                //Returns the ID of the brand selected (not the currentIndex that may differ)
                                property int brandSelected: {
                                    if (currentIndex < 0 || currentIndex > brandFilters.count) 
                                        return -1
                                    
                                    return delegateModel.items.get(currentIndex).model.id
                                }

                                textRole: "nome"
                            }

                            QC1.TableView {
                                height: parent.height *.7
                                width: parent.width * .8
                                anchors.top: brandFilters.bottom
                                anchors.topMargin: parent.height *.1
                                anchors.horizontalCenter: parent.horizontalCenter
                                model: vehiclesData.model
                                backgroundVisible: false
                                alternatingRowColors: false

                                headerDelegate: Rectangle {
                                    color: "transparent"
                                }

                                rowDelegate: Rectangle{
                                    color: "transparent"
                                }

                                QC1.TableViewColumn {
                                    role: "targa"
                                }
                            }

                            Vehicles {
                                id: vehiclesData

                                brand: brandFilters.brandSelected
                            }
                        }
                    }

                    style: TabViewStyle{
                        frameOverlap: -5
                        frame: Rectangle{
                            color: "transparent"
                            implicitWidth: view.width
                            implicitHeight: view.height
                            border.color: "#2c2c2c"
                            radius: 10
                        }
                        tab: Rectangle{
                            id:tabBackground
                            color:  "#2e2e2e"
                            border{
                                color: styleData.selected ? "limegreen" : "#2c2c2c"
                                
                            }
                            Layout.fillWidth: true
                            implicitWidth: view.width / view.count
                            implicitHeight: view.height *.07
                            radius: 5
                            clip: true

                            state: !styleData.selected ? "unselected": "selected"

                            states:[
                                State{
                                    name: "unselected"
                                    PropertyChanges {
                                        target: tabBackground
                                        color: "#292929"
                                    }
                                    PropertyChanges {
                                        target: tabBackground
                                        scale: 0.98
                                    }
                                },
                                State{
                                    name: "selected" 
                                    PropertyChanges {
                                        target: tabBackground
                                        color: "#2c2c2c"
                                    }
                                    PropertyChanges {
                                        target: tabBackground
                                        scale: 1
                                    }
                                }
                            ]

                            Label {
                                id: textLabel
                                color: styleData.selected ?  "limegreen" :  "white"
                                anchors.centerIn: parent
                                text: styleData.title
                                minimumPointSize: 1
                                font{
                                    bold: true
                                    pointSize: 13
                                }

                                style: Text.Raised
                            }
                        }
                    }
                }

                //PageIndicator {
                //    id: indicator
                //
                //    count: view.count
                //    currentIndex: view.currentIndex
                //
                //    anchors.bottom: view.bottom
                //    anchors.horizontalCenter: parent.horizontalCenter
                //
                //    delegate: Component{
                //        Rectangle{
                //            color: "white"
                //            width: 100
                //            height: width
                //            radius: height/2
                //        }
                //    }
                //}
            } 
        }

    }
   
}