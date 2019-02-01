import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import "Custom"

ApplicationWindow {
    id:root
    title:"Add new Employee"


    property var department : ({})

    property var editedDepartment :({})

    Component.onCompleted: {
        getDepartment()
    }

    onClosing: {
        firstName.text =''
        middleInitial.text =''
        lastName.text = ''
        type.currentIndex = -1

    }

    FileDialog{

        property var fileNameList: ({})

        id:filedialog
        title:"Choose you want to add the images"
        nameFilters: [ "Image files (*.jpg *.png)"]
        selectMultiple: true
        folder: shortcuts.desktop
        onAccepted: {


            if(fileUrls.length !== 30){
                dialog.title ="Error"
                dialog.text ="Requires 30 Images."
                dialog.standardButtons = StandardButton.Ok
                dialog.open()

            }
            else{
            scrollview.visible = true
            rec.visible=false
            fileNameList = []
            for(var i=0;i<fileUrls.length;i++)
                fileNameList.push(Handler.getFileNameFromPath(fileUrls[i]))
            }

        }
        onRejected: {
            filedialog.close()
        }
    }




         TextField{
            id:firstName
            x:root.width*0.10
            y:root.height*0.08
            width: root.width*0.30
            placeholderText: "Firstname"
            maximumLength: 45

         }

         TextField{
            id:middleInitial
            width: root.width*0.08
            anchors.left: firstName.right
            anchors.leftMargin: root.width*0.02
            anchors.top: firstName.top
            placeholderText: "M.I."
            maximumLength: 1
         }

         TextField{
            id:lastName
            width: root.width*0.40
            anchors.left: middleInitial.right
            anchors.leftMargin: root.width*0.02
            anchors.top: middleInitial.top
            placeholderText: "Lastname"
            maximumLength: 45
         }



         ComboBox{
             id:type
             x:root.width*0.13
             anchors.top: firstName.bottom
             anchors.topMargin: root.height*0.01
             anchors.leftMargin: root.width*0.03
             model: ["Faculty", "Staff"]
             currentIndex: -1
             editable: false
         }

         ComboBox{
             id:position
             anchors.top: type.top
             anchors.left: type.right
             anchors.leftMargin: root.width*0.03
             enabled: type.displayText === '' ? false : true
             model: {
                 if(type.displayText==='Faculty')
                     return ['Teacher']
                 if(type.displayText==='Staff')
                     return ['College Secretary','Office Assistant','Janitor']
             }
         }

         ComboBox{
             anchors.top: position.top
             anchors.left: position.right
             anchors.leftMargin: root.width*0.03
             id:departmentbox
             model:[]
             currentIndex: -1

         }




         ScrollView {
            id:scrollview

            visible: false
            anchors.top: type.bottom
            anchors.topMargin: root.height*0.075

            x: (root.width/2)- (scrollview.width/2)

            width: parent.width*0.90
            height: parent.height*0.40



             ListView {
                 id:listview

                 anchors.fill: parent

                 spacing: root.height*0.005

                 model: filedialog.fileUrls.length

                 clip: true

                 delegate: Component{
                     Item{
                         width: scrollview.width
                         height: scrollview.height/10
                         Rectangle{
                                anchors.fill:parent
                                color: 'lightgrey'
                                radius: parent.height
                             Text{
                                 anchors.verticalCenter: parent.verticalCenter
                                 text:filedialog.fileUrls[index]
                                 anchors.left: parent.left
                                 anchors.leftMargin: parent.width*0.05
                             }
                         }
                     }
                 }
             }
         }

         Rectangle{
             id:rec


             anchors.fill: scrollview
             anchors.centerIn: scrollview

             color:"lightgrey"

             Column{

                 x:(rec.width)/2 - (textImages.width/2) + (rec.x*2)
                 anchors.verticalCenter: parent.verticalCenter
                 spacing: parent.height*0.05

                 Button{
                     id:openButton
                     text:'Open'
                     onClicked: {
                         filedialog.open()
                     }
                 }

                 Text{
                     id:textImages
                     anchors.horizontalCenter: openButton.horizontalCenter
                     text: 'Add 30 Images as Training Sets for this Employee'
                 }
             }
         }


         Button{
             anchors.top:scrollview.bottom
             anchors.topMargin: parent.height*0.1
             x:(parent.width/3)-(open.width/2)
             id:open
             text:"cancel"
             onClicked: {
                 root.close()
             }
         }

         Button{
             id:send
             anchors.top:scrollview.bottom
             anchors.topMargin: parent.height*0.1
             x:(parent.width*2/3)-(send.width/2)
             text: "submit"
             onClicked: {
                if(firstName !== '' && middleInitial !== '' && lastName !== '' && type.displayText !== '' && departmentbox.displayText !== ''){

                    if(filedialog.fileNameList.length === 30 )
                        post()
                    else{
                        dialog.title ="Missing Photos"
                        dialog.standardButtons = StandardButton.Ok
                        dialog.text="Please Enter Employee photos"
                        dialog.open()
                    }
                }
                else{
                    dialog.title ="Missing Field"
                    dialog.standardButtons = StandardButton.Ok
                    dialog.text="Please fill up missing field"
                    dialog.open()
                }

             }

         }







    Connections{
         target: Handler
         onGlobalRefresh:{
             console.log("Global Refresh")
             getDepartment()

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


    function getDepartment(){

        indicator.running=true
        console.log("ADD Employee.qml: " + "fetching")
        var xhr = new XMLHttpRequest();
        xhr.open("GET",Handler.getDepartmentAPI(), true);
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){

                indicator.running=false
                department = JSON.parse(xhr.responseText)
                editedDepartment = []

                for(var i =0; i<department.length; i++){
                    editedDepartment.push(department[i].name)
                }

                departmentbox.model=editedDepartment

               console.log("ADD employee department: Finished Fetching with LIST LENGTH: " + editedDepartment )
            }
        }
        xhr.send();

    }

    function post(){


        console.log("Adding Employee ")
        indicator.running = true

        var xhr = new XMLHttpRequest()
        xhr.open("POST",Handler.getAddEmployeeAPI(),true);
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
                    departmentbox.currentIndex=0
                    firstName.text=''
                    middleInitial.text=''
                    lastName.text=''
                    type.currentIndex=-1
                    dialog.title ="Success"
                    dialog.text=answer.successMessage
                    dialog.standardButtons = StandardButton.Ok
                    dialog.open()

                    console.log("Employee Added sending images")
                    Handler.postImages(filedialog.fileUrls)
                    Handler.emitGlobalRefresh()
                }

            }
        }
        xhr.send(JSON.stringify({

            "firstName"     : firstName.text,
            "middleInitial" : middleInitial.text,
            "lastName"      : lastName.text,
            "type"          : type.displayText,
            "position"      : position.displayText,
            "idDepartment"  : department[departmentbox.currentIndex].idDepartment

        }));


    }


}
