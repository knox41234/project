import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id:window
    title: "Add Classroom"

    visible: false

    height: 500
    width: 500

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width



    Column{
    id:mainColumn
    width: window.width*0.9
    height: window.height*0.9

    spacing: window.height*0.05
    x: (window.width - mainColumn.width)/2
    y:window.height*0.05

        TextField{
            width: parent.width
            id:roomName
            placeholderText: "Room Name"
            maximumLength: 10
        }
        TextField{
            width: parent.width
            id:deviceName
            placeholderText: "Device Name"
            maximumLength: 10
        }
        Row{
            id:rowInput
            width: parent.width
            spacing:  ((rowInput.width)-((ipAddress1.width*4) + (dot.width*4)))/5
            TextField{
                width: parent.width*0.22
                id:ipAddress1
                maximumLength: 3
                placeholderText: "255"
                validator: IntValidator{bottom: 0; top: 255;}
                onTextEdited: {
                    if(ipAddress1.length === 3)
                        ipAddress2.focus = true
                }
            }

            Text{
                id:dot
                text:'.'
                font.bold: true
                y:(ipAddress1.y+ipAddress1.height)/2
            }

            TextField{
                width: parent.width*0.22
                id:ipAddress2
                maximumLength: 3
                placeholderText: "255"
                validator: IntValidator{bottom: 0; top: 255;}
                onTextEdited: {
                    if(ipAddress2.length === 3)
                        ipAddress3.focus = true
                }
            }

            Text{
                text:'.'
                font.bold: true
                y:(ipAddress1.y+ipAddress1.height)/2

            }

            TextField{
                width: parent.width*0.22
                id:ipAddress3
                maximumLength: 3
                placeholderText: "255"
                validator: IntValidator{bottom: 0; top: 255;}
                onTextEdited: {
                    if(ipAddress3.length === 3)
                        ipAddress4.focus = true
                }
            }

            Text{
                text:'.'
                font.bold: true
                y:(ipAddress1.y+ipAddress1.height)/2

            }

            TextField{
                width: parent.width*0.22
                id:ipAddress4
                maximumLength: 3
                placeholderText: "255"
                validator: IntValidator{bottom: 0; top: 255;}

            }
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

                    if(roomName.text === ""){
                        dialog.title ="Warning"
                        dialog.standardButtons = StandardButton.Ok
                        dialog.text="Please enter a room name."
                        dialog.open()
                    }

                    else if(deviceName.text===""){
                        dialog.title ="Warning"
                        dialog.standardButtons = StandardButton.Ok
                        dialog.text="Please enter a device name of the Pi."
                        dialog.open()
                    }

                    else if(ipAddress1.text==="" | ipAddress2.text ==="" | ipAddress3.text ==="" | ipAddress4.text === ""){
                        dialog.title ="warning"
                        dialog.standardButtons = StandardButton.Ok
                        dialog.text="Please enter a valid IPv4 address."
                        dialog.open()
                    }
                    else{
                        dialog.title= "Proceed?"
                        dialog.text = "You are about to create a new room with name: <i>" + roomName.text + "</i> and IPv4 address: <i>" + (ipAddress1.text + '.' + ipAddress2.text + '.' + ipAddress3.text + '.' + ipAddress4.text) + "</i>. Proceed in creating the room?"
                        dialog.open()
                    }
                }

            }

            Button{
                id:cancelButton
                text: "Cancel"

                onClicked: {
                    roomName.text = ''
                    deviceName.text = ''
                    ipAddress1.text = ''
                    ipAddress2.text = ''
                    ipAddress3.text = ''
                    ipAddress4.text = ''

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


        console.log("Adding Classroom")
        indicator.running = true

        var xhr = new XMLHttpRequest()
        xhr.open("POST",Handler.getAddRoomsAPI(),true);
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
                    roomName.text = ''
                    deviceName.text = ''
                    ipAddress1.text = ''
                    ipAddress2.text = ''
                    ipAddress3.text = ''
                    ipAddress4.text = ''
                    dialog.title ="Success"
                    dialog.text=answer.successMessage
                    dialog.standardButtons = StandardButton.Ok
                    dialog.open()
                    Handler.emitGlobalRefresh()
                }

            }
        }
        xhr.send(JSON.stringify({

            "roomName": roomName.text,
            "deviceName": deviceName.text,
            "ipaddr": ipAddress1 + '.' + ipAddress2 + '.' + ipAddress3 + '.' + ipAddress4


        }));


    }
}
