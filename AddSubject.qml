import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

import "Custom"

ApplicationWindow {

    id:window
    visible: false

    title: "Add Subject"


    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    onClosing: {
        subjectName.text = ""
    }

    Column{
    id:mainColumn
    width: window.width*0.9
    height: window.height*0.9


    spacing: window.height*0.05
    x: (window.width - mainColumn.width)/2
    y: (window.height - mainColumn.height)/2

            TextField{
                y:(window.height- subjectName.height + parent.height*0.10 + submitButton.height)/6
                width: parent.width - section.width - parent.width*0.05
                id:subjectName
                placeholderText: "Subject Name"
                maximumLength: 20
            }

            Custom_ComboBox{
                id:section
                anchors.top: subjectName.top
                anchors.left: subjectName.right
                anchors.leftMargin: parent.width*0.05
                editable: true
                items: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
                capital: true
                maxChar: 1
            }


        Row{
            id:rowButton
            width: parent.width
            spacing: (rowButton.width - submitButton.width - cancelButton.width)/3
            anchors.top: subjectName.bottom
            anchors.topMargin: parent.height*0.10
            x:(((window.width - mainColumn.width)/2) + ((rowButton.width - submitButton.width - cancelButton.width)/3))/1.25

            Button {

                id:submitButton
                text: "Submit"

                onClicked: {

                    if(subjectName===""){
                        dialog.title ="Warning"
                        dialog.text="Please enter a subject name."
                        dialog.standardButtons = StandardButton.Ok
                        dialog.open()
                    }

                    else if(!section.verification){
                        dialog.title ="Warning"
                        dialog.text="Please enter a valid section name."
                        dialog.standardButtons = StandardButton.Ok
                        dialog.open()
                    }

                    else{
                        dialog.standardButtons = StandardButton.No | StandardButton.Yes
                        dialog.title= "Proceed?"
                        dialog.text = "You are about to create a new Subject with name: <i>" + subjectName.text + "</i>. Proceed in creating the room?"
                        dialog.open()
                    }
                }

            }

            Button{
                id:cancelButton
                text: "Cancel"

                onClicked: {
                    window.close()
                }
            }
        }

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


    BusyIndicator{
        id:indicator
        anchors.centerIn: parent
        running:false
    }


    function post(){


        console.log("Adding subject")
        indicator.running = true

        var xhr = new XMLHttpRequest()
        xhr.open("POST",Handler.getSubjectsAPI(),true);
        xhr.setRequestHeader("Content-Type", "application/json")
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){
                indicator.running =false
                var answer = JSON.parse(xhr.responseText)
                console.log("From NumberPad: " + xhr.responseText)

                if(answer.errorMessage!==undefined){
                    console.log("Adding Classroom Failed: " + answer.errorMessage)
                    dialog.title ="Failed"
                    dialog.standardButtons = StandardButton.Ok
                    dialog.text=answer.errorMessage
                    dialog.open()

                }
                else{
                    console.log("Adding Classroom Successful: " + answer.successMessage)
                    subjectName.text = ""
                    dialog.title ="Success"
                    dialog.text=answer.successMessage
                    dialog.standardButtons = StandardButton.Ok
                    dialog.open()
                    Handler.emitGlobalRefresh()
                }

            }
        }
        xhr.send(JSON.stringify({

            "name": subjectName.text


        }));


    }

}
