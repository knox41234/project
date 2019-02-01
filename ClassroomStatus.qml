import QtQuick 2.9
import QtQuick.Controls 2.2

import "Custom"
Item {

    id: root
    property var classroomList: ({})

    property string searchBarText

//    property var classroomStatusList: ({})


    Component.onCompleted: {
        getClassroomList()


    }


    Component{
        id:listcomponent

        Item{
            id:listcomponentitem

            height : root.height/10
            width : root.width

            Rectangle{
                id:mainItemRect
                height : root.height/10
                width : root.width

                color:"grey"
                radius: parent.height


                SequentialAnimation on color {
                    id:animation
                    running: false
                    ColorAnimation { from: "grey"; to: "lightgrey"; duration: 125 }
                    ColorAnimation { from: "lightgrey"; to: "grey"; duration: 125 }
                }


                Row{
                    id:itemTextRow
                    width:parent.width
                    height: parent.height

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: parent.height*0.65

                    Text{
                        id:roomID
                        anchors.verticalCenter: parent.verticalCenter
                        width: listcomponentitem.width/7
                        text:classroomList[index].roomName
                    }

                    Text{
                        id:roomSubject
                        anchors.verticalCenter: parent.verticalCenter
                        width: listcomponentitem.width/7
                        text:{

                            for(var i;i<classroomList[index].history.length;i++){
                                if(classroomList[index].history[i].state===1)
                                    return  classroomList[index].history[i].subjectName
                             }

                            return "...."
                        }
                    }

                    Text{
                        id:roomTeacher
                        anchors.verticalCenter: parent.verticalCenter
                        width: listcomponentitem.width/7
                        text:{

                            for(var i;i<classroomList[index].history.length;i++){
                                if(classroomList[index].history[i].state===1)
                                    return "Prof. " + classroomList[index].history[i].lastName + ', ' + classroomList[index].history[i].firstName
                             }

                            return "..."
                        }
                    }
                    Text{
                        id:roomSchedule
                        anchors.verticalCenter: parent.verticalCenter
                        width: listcomponentitem.width/7
                        text:{

                            for(var i;i<classroomList[index].history.length;i++){
                                if(classroomList[index].history[i].state===1)
                                    return classroomList[index].history[i].startTime + ' - ' + classroomList[index].history[i].endTime
                            }

                            return ".."
                        }
                    }

                    ImageTransistion{
                        id:image
                        anchors.verticalCenter: parent.verticalCenter
                        width: listcomponentitem.width/7
                        height: parent.height

                        Text{
                            id:roomStatus
                            width: listcomponentitem.width/8
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.centerIn: parent
                            text: {

                                for(var i;i<classroomList[index].history.length;i++){
                                    if(classroomList[index].history[i].state===1)
                                        image.activate = true
                                        return "Class Ongoing"
                                }

                                image.activate = false
                                return "Locked"
                            }
                        }

                    }



                    Text{
                        id:numberofClass
                        anchors.verticalCenter: parent.verticalCenter
                        width: listcomponentitem.width/7
                        text: "Scheduled: " + classroomList[index].classes.length
                    }

                }



                MouseArea{

                    hoverEnabled: true

                    height: parent.height
                    width: parent.width/3

                    anchors.right: parent.right


                    onEntered: {
                        itemButtonRow.visible = true
                    }

                    onExited: {
                        itemButtonRow.visible = false
                    }
                    onClicked: {

                        animation.start()

                        if(listcomponentitem.height === root.height/5){
                            listview2.visible=false
                            listcomponentitem.height= (root.height/10)
                        }

                        else if(listcomponentitem.height === (root.height/10)){
                            listview2.visible=true
                            listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*classroomList[index].classes.length)
                            console.log(((root.height/20)+root.height*0.004)*classroomList[index].classes.length )
                        }

                        else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*classroomList[index].classes.length) ){
                            listview2.visible=false
                            listcomponentitem.height= (root.height/10)
                        }
                    }


                }

                MouseArea{
                    height: parent.height
                    width: (parent.width*2)/3
                    anchors.left: parent.left

                    onClicked: {

                        animation.start()

                        if(listcomponentitem.height === root.height/5){
                            listview2.visible=false
                            listcomponentitem.height= (root.height/10)
                        }

                        else if(listcomponentitem.height === (root.height/10)){
                            listview2.visible=true
                            listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*classroomList[index].classes.length)
                        }

                        else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*classroomList[index].classes.length) ){
                            listview2.visible=false
                            listcomponentitem.height= (root.height/10)
                        }
                    }
                }

                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: parent.height*0.75
                    id:itemButtonRow
                    visible: false
                    spacing: parent.height/3

                    RoundButton{
                        id: classesButton
                        text:"classes"

                        onClicked: {

                            if(listcomponentitem.height === root.height/5){
                                listview2.visible=false
                                listcomponentitem.height= (root.height/10)

                            }

                            else if(listcomponentitem.height === (root.height/10)){
                                listview2.visible=true
                                listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*classroomList[index].classes.length)
                                console.log(((root.height/20)+root.height*0.004)*classroomList[index].classes.length )
                            }

                            else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*classroomList[index].classes.length) ){
                                listview2.visible=false
                                listcomponentitem.height= (root.height/10)
                            }

                        }
                    }

                    RoundButton{
                        id: historyButton
                        text:"history"

                        onClicked: {

                            subWindow.title = classroomList[index].name + " - Classroom History"
                            subWindow.listIndex = index
                            subWindow.visible = true
                        }
                    }
                }

            }

            ListView {

                property int parentIndex : index

                visible: false

                id:listview2

                anchors.top: mainItemRect.bottom
                anchors.topMargin: root.height*0.004

                width: parent.width
                height: ((root.height/20) + root.height*0.004) * classroomList[index].classes.length

                spacing: root.height*0.004

                model: classroomList[index].classes.length

                clip: true

                delegate:Component{

                            id:listcomponent2
                            Item {
                                id:listcomponentitem2

                                height : root.height/20
                                width : root.width

                                Rectangle{
                                    anchors.left: parent.left
                                    anchors.leftMargin: parent.height*2
                                    anchors.right: parent.right
                                    anchors.rightMargin: parent.height*0.3

                                    id:mainItemRect2
                                    radius: parent.height
                                    anchors.fill: parent
                                    color:"grey"

                                    Row{
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: parent.height

                                        width: parent.width

                                        Text{
                                            width: parent.width/5
                                            text: classroomList[listview2.parentIndex].classes[index].startTime + ' - ' + classroomList[listview2.parentIndex].classes[index].endTime
                                        }

                                        Text{
                                            width: parent.width/5
                                            text: classroomList[listview2.parentIndex].classes[index].subjectName
                                        }

                                        Text{
                                            width: parent.width/5
                                            text: "Prof. " + classroomList[listview2.parentIndex].classes[index].lastName + ', ' + classroomList[listview2.parentIndex].classes[index].firstName
                                        }
                                    }
                                }
                            }
                        }
            }





        }
    }


    ApplicationWindow{

        property int listIndex : 0

        id:subWindow

        height: root.height/2
        width: root.width*0.40

        visible: false

        maximumHeight: height
        maximumWidth: width

        minimumHeight: height
        minimumWidth: width

        ScrollView {
            id:scrollview3

            height: parent.height*0.95
            width: parent.width*0.95
            anchors.centerIn: parent



            ListView {
                id:listview3

                anchors.fill: parent

                spacing: root.height*0.005

//                model: 25
                model: classroomList[subWindow.listIndex].history.length

                clip: true

                delegate: Component {
                    Item {

                        height : subWindow.height/10
                        width : subWindow.width

                        Rectangle{
                            height : subWindow.height/10
                            width : subWindow.width

                            Row{
                                anchors.fill: parent

                                Text{
                                    width: parent.width*0.20
                                    text: classroomList[subWindow.listIndex].history[index].subjectName
                                }

                                Text{
                                    width: parent.width/4
                                    text: "Prof. " + classroomList[subWindow.listIndex].history[index].lastName + ', ' + classroomList[subWindow.listIndex].history[index].firstName
                                }

                                Text{
                                    width: parent.width*0.20
                                    text: classroomList[subWindow.listIndex].history[index].date.substring(0,10)
                                }

                                Text{
                                    width: parent.width/4
                                    text: classroomList[subWindow.listIndex].history[index].startTime + ' - ' + classroomList[subWindow.listIndex].history[index].endTime
                                }
                            }
                        }
                    }
                }
            }
        }

    }

    ScrollView {
        id:scrollview


        anchors.fill: parent


        ListView {
            id:listview

            anchors.fill: parent

            spacing: root.height*0.005

            model: classroomList.length

            clip: true

            delegate: listcomponent
        }
    }

    BusyIndicator{
        id:bussyIndicator
        anchors.centerIn: parent
        running: flase
    }

    function getClassroomList(){

        bussyIndicator.running=true
        console.log("ClassroomStatus.qml: " + "fetching")
        var xhr = new XMLHttpRequest();
        xhr.open("GET",Handler.getRoomsWithStatusAPI(), true);
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){

                bussyIndicator.running=false
                classroomList = JSON.parse(xhr.responseText)

                console.log("ClassroomStatus.qml: Finished Fetching with LIST LENGTH: " + classroomList.length )
            }
        }
        xhr.send();

    }



}
