import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

import "Custom"

ApplicationWindow {
    id:window
    title: "New Schedule"

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    Component.onCompleted: {

        getSubjects()
        getRoom()
        getTeachers()
    }

    onClosing: {
        mymodel.clear()
        mymodel.append({
            "idSubject" : null ,
            "idRoom": null,
            "idEmployee": null,
            "day": null,
            "startTime": null,
            "endTime" : null

        })
    }

    property var timeArray: ["6:00","6:30","7:00","7:30","8:00","8:30","9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00"]

    property var dateArray: ["MON", "TUE", "WED", "THU",  "FR", "SAT", "SUN" ]

    property var subjects : ({})
    property var editedSubjects: ({})

    property var rooms : ({})
    property var editedRooms: ({})

    property var teachers : ({})
    property var editedTeachers: ({})

    header: ToolBar{


            Label{
                id:label1
                anchors.left: parent.left
                anchors.leftMargin: window.width*0.085
                anchors.verticalCenter: parent.verticalCenter
                text:"Subject Name"
            }
            Label{
                id:label2
                anchors.left: label1.right
                anchors.leftMargin: window.width*0.122
                anchors.verticalCenter: parent.verticalCenter
                text:"Room"
            }

            Label{
                id:label3
                anchors.left: label2.right
                anchors.leftMargin: window.width*0.077
                anchors.verticalCenter: parent.verticalCenter
                text:"Start time"
            }

            Label{
                id:label4
                anchors.left: label3.right
                anchors.leftMargin: window.width*0.067
                anchors.verticalCenter: parent.verticalCenter
                text:"End time"
            }

            Label{
                id:label5
                anchors.left: label4.right
                anchors.leftMargin: window.width*0.082
                anchors.verticalCenter: parent.verticalCenter
                text:"Day"
            }

            Label{
                id:label6
                anchors.left: label5.right
                anchors.leftMargin: window.width*0.125
                anchors.verticalCenter: parent.verticalCenter
                text:"Teacher"
            }

    }

    ScrollView {
        id:scrollview
        anchors.fill: parent


        ListView {
            id:listview

            anchors.fill: parent

            spacing: window.height*0.005

            model: mymodel

            clip: true

            delegate: listcomponent
        }
    }

    ListModel{
        id:mymodel

        Component.onCompleted: {
            mymodel.append({
                "idSubject" : null,
                "idRoom": null,
                "idEmployee": null,
                "day": null,
                "startTime": null,
                "endTime" : null

            })
        }
    }

    Component{
        id:listcomponent

        Item{
            id:item
            width: window.width
            height:window.height*0.95/8
            visible: true
            enabled: true
            Rectangle{
                id:rec
                anchors.fill: parent
                color: "grey"
                radius: parent.height

                Row{

                    anchors.centerIn: parent
                    width: parent.width*0.95
                    spacing: parent.width*0.02

                    Custom_ComboBox{
                        width: parent.width/5
                        id:subjectBox
                        editable: true
                        items: editedSubjects
                        maxChar: 45
                        capital: true
                        popupHeight: window.height/2

                        onTexFieldTextChanged: {
                            if(arrayIndex!==-1)
                                mymodel.set(index,{"idSubject": subjects[arrayIndex].idSubject })
                            else
                                mymodel.set(index,{"idSubject": null })
                        }
                    }
                    Custom_ComboBox{
                        id:room
                        maxChar: 10
                        editable: true
                        items:editedRooms
                        capital: true
                        popupHeight: window.height/2

                        onTexFieldTextChanged: {
                            if(arrayIndex!==-1)
                                mymodel.set(index,{"idRoom": rooms[arrayIndex].idRoom })
                            else
                                mymodel.set(index,{"idRoom": null })
                        }
                    }
                    Custom_ComboBox{
                        id:startTime
                        editable: false
                        items:timeArray
                        capital: true
                        popupHeight: window.height/2

                        onTexFieldTextChanged: {
                            if(arrayIndex!==-1)
                                mymodel.set(index,{"startTime": timeArray[arrayIndex] })
                            else
                                mymodel.set(index,{"startTime": null })
                        }
                    }
                    Custom_ComboBox{
                        id:endTime
                        editable: false
                        items:timeArray
                        capital: true
                        popupHeight: window.height/2

                        onTexFieldTextChanged: {
                            if(arrayIndex!==-1)
                                mymodel.set(index,{"endTime": timeArray[arrayIndex] })
                            else
                                mymodel.set(index,{"endTime": null })
                        }
                    }
                    Custom_ComboBox{
                        id:day
                        maxChar: 3
                        editable: true
                        items:dateArray
                        capital: true
                        popupHeight: window.height/2

                        onTexFieldTextChanged: {
                            if(arrayIndex!==-1)
                                mymodel.set(index,{"day": arrayIndex+1 })
                            else
                                mymodel.set(index,{"day": null })
                        }
                    }
                    Custom_ComboBox{
                        width: parent.width/5
                        maxChar: 45
                        id:teacher
                        editable: true
                        items:editedTeachers
                        capital: true
                        popupHeight: window.height/2

                        onTexFieldTextChanged: {
                            if(arrayIndex!==-1)
                                mymodel.set(index,{"idEmployee": teachers[arrayIndex].idEmployee })
                            else
                                mymodel.set(index,{"idEmployee": null })
                        }

                    }

                    Text{
                        id:verificationText
                        width: parent.width/8
                        anchors.verticalCenter: parent.verticalCenter
                        text:{
                            if(subjectBox.verification && room.verification && startTime.verification && endTime.verification && day.verification && teacher.verification){
                                verificationText.text = "Clear"
                                verificationText.color = "lightgreen"
                            }
                            else{
                                verificationText.text = "Fill required fields"
                                verificationText.font.color = "lightred"
                            }
                        }
                    }
                }

            }
        }
    }

    RoundButton{
        id:addButton
        text: "+"
        width: window.width*0.05
        height: window.width*0.05

        x:(window.width-(addButton.width*1.5))
        y:(window.height-(addButton.height*2.5))
        onClicked: {
            mymodel.append({
                "idSubject" : null ,
                "idRoom": null,
                "idEmployee": null,
                "day": null,
                "startTime": null,
                "endTime" : null
            })
        }


    }

    RoundButton{
        id:submitButton
        text: "Go"
        width: window.width*0.05
        height: window.width*0.05

        anchors.horizontalCenter: addButton.horizontalCenter
        anchors.top: addButton.bottom
        anchors.topMargin: submitButton.height/3

        onClicked: {

            console.log("no. of Schedule to post: " + mymodel.count)

            console.log(mymodel.get(0).idSubject + ' + ' + mymodel.get(0).idRoom + ' + ' + mymodel.get(0).idEmployee +' + '+ mymodel.get(0).day + ' + '+ mymodel.get(0).startTime + ' + '+mymodel.get(0).endTime)

            for(var i=0; i<mymodel.count;i++){
                if(mymodel.get(i).idSubject !== undefined &&  mymodel.get(i).idRoom !== undefined && mymodel.get(i).idEmployee !== undefined && mymodel.get(i).day !== undefined && mymodel.get(i).startTime !== undefined && mymodel.get(i).endTime !== undefined){
                    post(mymodel.get(i))
                }
                else{
                    dialog.title ="Failed"
                    dialog.standardButtons = StandardButton.Ok
                    dialog.text="Please Enter all fields"
                    dialog.open()
                  return
                }


            }

        }
    }


    Connections{
        target: Handler
        onGlobalRefresh:{
            console.log("Global Refresh")

            getSubjects()
            getRoom()
            getTeachers()

        }

    }


    BusyIndicator{
        id:bussyIndicator
        anchors.centerIn: parent
        running: false
    }

    function getSubjects(){

        bussyIndicator.running=true
        console.log("ADD schedule.qml: " + "fetching")
        var xhr = new XMLHttpRequest();
        xhr.open("GET",Handler.getSubjectsAPI(), true);
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){

                bussyIndicator.running=false
                subjects = JSON.parse(xhr.responseText)
                editedSubjects = []

                for(var i =0; i<subjects.length; i++){
                    editedSubjects.push(subjects[i].subjectName + "   " + subjects[i].section)
                }

//                console.log("ADD schedule: Finished Fetching with LIST LENGTH: " + editedSubjects )
            }
        }
        xhr.send();

    }

    function getRoom(){

        bussyIndicator.running=true
        console.log("ADD schedule.qml: " + "fetching")
        var xhr = new XMLHttpRequest();
        xhr.open("GET",Handler.getAddRoomsAPI(), true);
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){

                bussyIndicator.running=false
                rooms = JSON.parse(xhr.responseText)
                editedRooms = []

                for(var i =0; i<rooms.length; i++){
                    editedRooms.push(rooms[i].roomName)
                }

//                console.log("ADD schedule: Finished Fetching with LIST LENGTH: " + editedRooms )
            }
        }
        xhr.send();

    }

    function getTeachers(){

        bussyIndicator.running=true
        console.log("ADD schedule.qml: " + "fetching")
        var xhr = new XMLHttpRequest();
        xhr.open("GET",Handler.getTeachersOnlyAPI(), true);
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){

                bussyIndicator.running=false
                teachers = JSON.parse(xhr.responseText)
                editedTeachers = []

                for(var i =0; i<teachers.length; i++){
                    var temp = new String
                    temp =teachers[i].lastName + ", " + teachers[i].firstName + ' ' +teachers[i].middleInitial
                    editedTeachers.push(temp.toLocaleString())
                }

//                console.log("ADD schedule: Finished Fetching with LIST LENGTH: " + editedTeachers )
            }
        }
        xhr.send();

    }



    MessageDialog{
        id:dialog
        text:""
        icon: StandardIcon.Warning
        standardButtons: StandardButton.No | StandardButton.Yes

        onYes: post()
        onNo: dialog.close()
        onAccepted: {

        }

    }

    function post(data){


        console.log("Adding Schedule")
        bussyIndicator.running = true

        var xhr = new XMLHttpRequest()
        xhr.open("POST",Handler.getAddScheduleAPI(),true);
        xhr.setRequestHeader("Content-Type", "application/json")
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){
                bussyIndicator.running =false
                var answer = JSON.parse(xhr.responseText)
                console.log("From Schedule: " + xhr.responseText)

                if(answer.errorMessage!==undefined){
                    console.log("Adding Schedule Failed: " + answer.errorMessage)
                    dialog.title ="Failed"
                    dialog.standardButtons = StandardButton.Ok
                    dialog.text=answer.errorMessage
                    dialog.open()

                }
                else{
                    console.log("Adding Schedule Successful: " + answer.successMessage)
                    departmentName.text = ""
                    dialog.title ="Success"
                    dialog.text=answer.successMessage
                    dialog.standardButtons = StandardButton.Ok
                    dialog.open()
                    Handler.emitGlobalRefresh()
                }

            }
        }
        xhr.send(JSON.stringify(data));


    }

}
