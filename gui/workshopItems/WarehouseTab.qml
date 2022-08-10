import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as QC1
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import Vehicles 1.0
import Vehicles.BrandsModel 1.0

Item{
    anchors.fill: parent

    //ComboBox {
    //    id: brandFilters
    //    height: parent.height *.1
    //    width: parent.width * .8
    //    anchors{
    //        horizontalCenter: parent.horizontalCenter
    //        top: parent.top
    //        topMargin: 15
    //    }
    //    currentIndex: -1
    //
    //    model: BrandsModel {}
    //
    //    //Returns the ID of the brand selected (not the currentIndex that may differ)
    //    property int brandSelected: {
    //        if (currentIndex < 0 || currentIndex > brandFilters.count) 
    //            return -1
    //        
    //        return delegateModel.items.get(currentIndex).model.id
    //    }
    //
    //    textRole: "nome"
    //}

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

        //brand: brandFilters.brandSelected
    }
}