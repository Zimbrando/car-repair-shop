import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import "./workshopItems"
import "./shared"

import Vehicles 1.0
import Vehicles.BrandsModel 1.0


Item{
    id: root

    property var stackRef: undefined
    property var appPalette: undefined
    property int workShopIndex: undefined

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
            id: calendarPage
            title: "Calendar"
            active: true

            CalendarTab{
                anchors.fill: parent
            }

            
        }

        QC1.Tab {
            id: warehousePage
            title: "Warehouse"
            WarehouseTab{
                anchors.fill: parent
                appPalette: root.appPalette
                workShopIndex: root.workShopIndex
            }
            
        }

        QC1.Tab {
            id: servicesPage
            title: "Services"
            ServicesTab{
                anchors.fill: parent
                appPalette: root.appPalette
                workShopIndex: root.workShopIndex
            }
            
        }

        QC1.Tab {
            id: employeesPage
            title: "Employees"
            EmployeesTab{
                anchors.fill: parent
                appPalette: root.appPalette
                workShopIndex: root.workShopIndex
            }
            
        }

        QC1.Tab {
            id: statsPage
            title: "Statistics"
            StatsTab{


            }
        }

        style: TabViewStyle{
            frameOverlap: -5
            frame: Rectangle{
                color: "transparent"
                implicitWidth: view.width
                implicitHeight: view.height
                border.color: appPalette.midLight
                radius: 10
            }
            tab: Rectangle{
                id:tabBackground
                color: appPalette.light
                border{
                    color: styleData.selected ? appPalette.limeGreen : appPalette.midLight
                    width: 2
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
                            color: appPalette.dark
                        }
                        PropertyChanges {
                            target: tabBackground
                            scale: 0.95
                        }
                    },
                    State{
                        name: "selected" 
                        PropertyChanges {
                            target: tabBackground
                            color: appPalette.midLight
                        }
                        PropertyChanges {
                            target: tabBackground
                            scale: 0.97
                        }
                    }
                ]

                Label {
                    id: textLabel
                    color: styleData.selected ?  appPalette.limeGreen :  appPalette.text
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