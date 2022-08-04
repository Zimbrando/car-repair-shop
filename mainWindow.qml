import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1

import Workshops 1.0
import Vehicles 1.0
import Vehicles.BrandsModel 1.0


ApplicationWindow {
    id: mainWindow
    visible: true
    
    height: 800
    width: 1200

    title: "Car repair shop"
    //color: "#2c2c2c"
    color: "grey" //only to show the SwipeView indicator

    SwipeView {
        id: view

        currentIndex: 0
        anchors.fill: parent

        Item {
            id: firstPage

            TextField {
                id: nameFilter
                height: 25
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 15
                placeholderText: "Filter by name"
            }

            QC1.TableView {
                width: 300
                height: 300
                anchors.centerIn: parent
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

        Item {
            id: secondPage

            ComboBox {
                id: brandFilters
                height: 25
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 15
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
                width: 300
                height: 300
                anchors.centerIn: parent
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

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
   
}