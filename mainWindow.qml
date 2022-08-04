import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1

import Workshops 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    
    height: 800
    width: 1200

    title: "Car repair shop"
    color: "#2c2c2c"

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

        onClicked: {
            console.log("Selected ", row)
        }
    }

    Workshops {
        id: data
    }
}