import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {

    id:window
    visible: false

    title: "Add Department"

    height: 500
    width: 500

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    Column{
    id:mainColumn
    width: window.width*0.9
    height: departmentName.height + window.height*0.05 + rowButton.height

    spacing: window.height*0.05
    x: (window.width - mainColumn.width)/2
    y: (window.height - mainColumn.height)/2

        TextField{
            width: parent.width
            id:departmentName
            placeholderText: "Department Name"
            maximumLength: 20
        }

        Row{
            id:rowButton
            width: parent.width
            spacing: (rowButton.width - submitButton.width - cancelButton.width)/3

            x:(((window.width - mainColumn.width)/2) + ((rowButton.width - submitButton.width - cancelButton.width)/3))/2

            Button {

                id:submitButton
                text: "Submit"

                onClicked: {
                    if(departmentName.text===""){
                        dialog.title ="Warning"
                        dialog.text="Please enter a department name."
                        dialog.standardButtons = StandardButton.Ok
                        dialog.open()
                    }
                    else{
                    dialog.standardButtons = StandardButton.No | StandardButton.Yes
                    dialog.title= "Proceed?"
                    dialog.text = "You are about to create a new Department with name: <i>" + departmentName.text + "</i>. Proceed in creating the room?"
                    dialog.open()
                    }
                }

            }

            Button{
                id:cancelButton
                text: "Cancel"

                onClicked: {
                    departmentName.text = ""
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


        console.log("Adding Department")
        indicator.running = true

        var xhr = new XMLHttpRequest()
        xhr.open("POST",Handler.getAddDepartmentAPI(),true);
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
                    departmentName.text = ""
                    dialog.title ="Success"
                    dialog.text=answer.successMessage
                    dialog.standardButtons = StandardButton.Ok
                    dialog.open()
                    Handler.emitGlobalRefresh()
                }

            }
        }
        xhr.send(JSON.stringify({

            "name": departmentName.text


        }));


    }

}
