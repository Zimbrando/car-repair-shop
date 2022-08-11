import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import "./shared"

import WorkshopsModel 1.0
import Vehicles 1.0
import Vehicles.BrandsModel 1.0


ApplicationWindow {
    id: mainWindow

    property alias appPalette: applicationPalette
    
    visible: true
    
    height: 1080
    width: 1920

    title: "CAR REPAIR SHOP"


    GuiPalette{
        id: applicationPalette
    }


    Item{

        id: mainRoot

        //TODO remove this
        property int selectedWorkShop: -1
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
        
        /////////////////////////APPLOCATION BACKGROUND/////////////////////////

        Rectangle{
            
            id: background
            anchors.fill: parent
            color: appPalette.window
        }


        /////////////////////////STACK STRUCTURE FOR PAGES/////////////////////////

        StackView {
            id: mainStack
            property bool opened: state === "expanded"
            property var lastPushed

            anchors {
                fill: parent
                margins: 5
            }

            initialItem : mainPage

            pushEnter: Transition {
                XAnimator {
                    from: (mainStack.mirrored ? -1 : 1) * mainStack.width
                    to: 0
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

            popExit: Transition {
                XAnimator {
                    from: 0
                    to: (mainStack.mirrored ? -1 : 1) * mainStack.width
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

        }

        /////////////////////////MAIN CAR WORKSHOP LIST/////////////////////////

        Component{
            id: mainPage 
            WorkshopsView{ 
                appPalette: mainWindow.appPalette
            }
        }
        
        /////////////////////////WORKSHOP PAGE/////////////////////////

        Component{
            id: workshopDetails 
            WorkshopPage{ 
                workShopIndex: mainRoot.selectedWorkShop
                stackRef: mainStack
                appPalette: mainWindow.appPalette
            }
        }

    }
   
}