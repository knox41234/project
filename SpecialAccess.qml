import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4 as QQC1

Item {

    id:root

    property var minDate: ({})
    property var maxDate: ({})

    Component.onCompleted: {
        getDateLimits()

    }

    Button{
        anchors.centerIn: parent
        onClicked: {
            calendar.visible=true
        }
    }

    QQC1.Calendar{
        id:calendar
        anchors.centerIn: parent
        visible: false

        onClicked: {
            console.log(selectedDate)
        }
    }

    BusyIndicator{
        id:indicator
        anchors.centerIn: parent
        running:false
    }

    function getDateLimits(){
        indicator.running=true
        console.log("SpecialAccess.qml: " + "fetching")
        var xhr = new XMLHttpRequest();
        xhr.open("GET",Handler.getDateTimeAPI(), true);
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){

                indicator.running=false
                var temp = JSON.parse(xhr.responseText)
                calendar.maximumDate = Date.fromLocaleString(Qt.locale(), temp.maxDate, "yyyy-MM-dd")
                calendar.minimumDate = Date.fromLocaleString(Qt.locale(), temp.currentDate, "yyyy-MM-dd")

                console.log("SpecialAccess.qml: " + "Finished Fetching dates " + Date.fromLocaleString(Qt.locale(), temp.currentDate, "yyyy-MM-dd"))
            }
        }
        xhr.send();


    }
}
