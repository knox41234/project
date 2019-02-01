import QtQuick 2.9
import QtQuick.Controls 2.2

Item {


    id: root

    property var subjectsList: ({})

        property string searchBarText

    visible: false


    Component.onCompleted: {
        getsubjectsList()


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
                        text: subjectsList[index].subjectName
                    }

                    Text{
                        width: listcomponentitem.width/7
                        text: subjectsList[index].section
                    }

                    Text{
                        width: listcomponentitem.width/7
                        text: subjectsList[index].name
                    }

                    Text{
                        width: listcomponentitem.width/7
                        text: subjectsList[index].startTime + ' - ' + subjectsList[index].endTime
                    }

                    Text{
                        width: listcomponentitem.width/7
                        text: {

                        switch(subjectsList[index].day){
                        case 1:
                            return "M"
                        case 2:
                            return "T"
                        case 3:
                            return "W"
                        case 4:
                            return "TH"
                        case 5:
                            return "F"
                        case 6:
                            return "S"
                        case 7:
                            return "SUN"

                        }

                        }
                    }

                    Text{
                        width: listcomponentitem.width/7
                        text: "Prof. " + subjectsList[index].lastName + ', ' + subjectsList[index].FirstName + ' ' + subjectsList[index].middleInitial
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
                            listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length)
                            console.log(((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length )
                        }

                        else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length) ){
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
                            listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length)
                            console.log(((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length )
                        }

                        else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length) ){
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
                                listcomponentitem.height= (root.height/10) + (((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length)
                                console.log(((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length )
                            }

                            else if(listcomponentitem.height === (root.height/10) + (((root.height/20)+root.height*0.004)*subjectsList[index].schedule.length) ){
                                listview2.visible=false
                                listcomponentitem.height= (root.height/10)
                            }

                        }
                    }

                    RoundButton{
                        id: historyButton
                        text:"history"

                        onClicked: {

                            subWindow.title = subjectsList[index].name + " - Classroom History"
                            subWindow.listIndex = index
                            subWindow.visible = true
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

            model: subjectsList.length

            clip: true

            delegate: listcomponent
        }
    }


    BusyIndicator{
        id:indicator
        anchors.centerIn: parent
        running:false
    }

    function getsubjectsList(){

        indicator.running=true
        console.log("Subjects.qml: " + "fetching")
        var xhr = new XMLHttpRequest();
        xhr.open("GET",Handler.getSubjectsDataAPI(), true);
        xhr.onreadystatechange = function (){
            if(xhr.readyState === XMLHttpRequest.DONE){

                indicator.running=false
                subjectsList = JSON.parse(xhr.responseText)

                console.log("Subjects.qml: Finished Fetching with LIST LENGTH: " + subjectsList.length )
            }
        }
        xhr.send();

    }

}
