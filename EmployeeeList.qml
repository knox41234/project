import QtQuick 2.9
import QtQuick.Controls 2.2

Item {

    id: root
    property var employeeList: ({})
//    property var classroomStatusList: ({})
    property string searchBarText

    Component.onCompleted: {
        getemployeeList()


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

                Row{
                    id:itemTextRow
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: parent.height*0.65

                    Text{
                        width: listcomponentitem.width/7
                        text:'Prof. ' + employeeList[index].lastName + ', ' + employeeList[index].firstName + ' ' + employeeList[index].middleInitial +'.'
                    }

                    Text{
                        width: listcomponentitem.width/7
                        text: employeeList[index].departmentName
                    }

                    Text{
                        width: listcomponentitem.width/7
                        text: employeeList[index].type
                    }
                    Text{
                        width: listcomponentitem.width/7
                        text: employeeList[index].position
                    }
                    Text{
                        width: listcomponentitem.width/7
                        text: "Schedules " + employeeList[index].schedule.length
                    }


                }

                MouseArea{

                    hoverEnabled: true

                    height: parent.height
                    width: parent.width/3

                    anchors.right: parent.right

                    onPressed: {
                        mainItemRect.color = "lightgrey"
                    }

                    onReleased: {
                        mainItemRect.color = "grey"
                    }

                    onEntered: {
                        itemButtonRow.visible = true
                    }

                    onExited: {
                        itemButtonRow.visible = false
                    }
                    onClicked: {

                        if(listcomponentitem.height === root.height/5){
                            listview2.visible=false
                            listcomponentitem.height= (root.height/10)
                        }

                        else if(listcomponentitem.height === (root.height/10)){
                            listview2.visible=true
                            listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*employeeList[index].schedule.length)
                            console.log(((root.height/20)+root.height*0.004)*employeeList[index].schedule.length )
                        }

                        else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*employeeList[index].schedule.length) ){
                            listview2.visible=false
                            listcomponentitem.height= (root.height/10)
                        }
                    }


                }

                MouseArea{
                    height: parent.height
                    width: (parent.width*2)/3
                    anchors.left: parent.left

                    onPressed: {
                        mainItemRect.color = "lightgrey"
                    }

                    onReleased: {
                        mainItemRect.color = "grey"
                    }

                    onClicked: {
                        if(listcomponentitem.height === root.height/5){
                            listview2.visible=false
                            listcomponentitem.height= (root.height/10)
                        }

                        else if(listcomponentitem.height === (root.height/10)){
                            listview2.visible=true
                            listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*employeeList[index].schedule.length)
                            console.log(((root.height/20)+root.height*0.004)*employeeList[index].schedule.length )
                        }

                        else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*employeeList[index].schedule.length) ){
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
                        text:"schedule"

                        onClicked: {

                            if(listcomponentitem.height === root.height/5){
                                listview2.visible=false
                                listcomponentitem.height= (root.height/10)

                            }

                            else if(listcomponentitem.height === (root.height/10)){
                                listview2.visible=true
                                listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*employeeList[index].schedule.length)
                                console.log(((root.height/20)+root.height*0.004)*employeeList[index].schedule.length )
                            }

                            else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*employeeList[index].schedule.length) ){
                                listview2.visible=false
                                listcomponentitem.height= (root.height/10)
                            }

                        }
                    }

                    RoundButton{
                        id: historyButton
                        text:"history"

                        onClicked: {

                            subWindow.title = employeeList[index].name + " - Classroom History"
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
                height: ((root.height/20) + root.height*0.004) * employeeList[index].schedule.length

                spacing: root.height*0.004

                model: employeeList[index].schedule.length

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
                                            text: employeeList[listview2.parentIndex].schedule[index].startTime + ' - ' + employeeList[listview2.parentIndex].schedule[index].endTime
                                        }

                                        Text{
                                            width: parent.width/5
                                            text: employeeList[listview2.parentIndex].schedule[index].day
                                        }


                                        Text{
                                            width: parent.width/6
                                            text: employeeList[listview2.parentIndex].schedule[index].subjectName
                                        }

                                        Text{
                                            width: parent.width/5
                                            text: employeeList[listview2.parentIndex].schedule[index].section
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

                model: employeeList[subWindow.listIndex].log.length

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
                                    text: employeeList[subWindow.listIndex].history[index].subjectName
                                }

                                Text{
                                    width: parent.width/4
                                    text: employeeList[subWindow.listIndex].history[index].section
                                }

                                Text{
                                    width: parent.width*0.20
                                    text: employeeList[subWindow.listIndex].history[index].date.substring(0,10)
                                }

                                Text{
                                    width: parent.width/4
                                    text: employeeList[subWindow.listIndex].history[index].startTime + ' - ' + employeeList[subWindow.listIndex].history[index].endTime
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

            model: employeeList.length

            clip: true

            delegate: listcomponent
        }
    }


    BusyIndicator{
        id:bussyIndicator
        anchors.centerIn: parent
        running: flase
    }

    function getemployeeList(){

        console.log("EmployeeList.qml: " + "fetching")
        bussyIndicator.running = true
        var xhr = new XMLHttpRequest();
        xhr.open("GET",Handler.getEmployeeAPI(), true);
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){

                bussyIndicator.running = false
                employeeList = JSON.parse(xhr.responseText)

                console.log("EmployeeList.qml: Finished Fetching with LIST LENGTH: " + employeeList.length )
            }
        }
        xhr.send();

    }



}
