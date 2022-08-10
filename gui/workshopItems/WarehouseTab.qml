import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Components 1.0

Item{
    anchors.fill: parent

    property int workshopId: 1

    TextField {
        id: nameFilter
        height: parent.height *.1
        width: parent.width * .8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15
        placeholderText: "Find component"
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
            role: "seriale"
        }

        QC1.TableViewColumn {
            role: "nome"
        }

        QC1.TableViewColumn {
            role: "marca"
        }

        QC1.TableViewColumn {
            role: "prezzo"
        }

        QC1.TableViewColumn {
            role: "quantita"
        }
    }

    Components {
        id: data
        workshop: workshopId
        group: true
    }
}