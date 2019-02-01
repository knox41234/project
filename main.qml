import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3


ApplicationWindow {
    id: window
    visible: true
    width: 420
    height: 680
    title: qsTr("Stack")



    Component.onCompleted: {
        window.showMaximized()
        console.log ("QML Screen Height: " + window.height + " Screen Width: " + window.width)
        leftToolBar.height = window.height - (menuBarToolBar.height + toolBar.height)
        leftToolBar.width  = window.width/5


        stackView.width = window.width*0.80
        stackView.height = window.height - (menuBarToolBar.height + toolBar.height)

        Handler.setWindowHeight(window.height)
        Handler.setWindowWidth(window.width)



    }

    menuBar: MenuBarToolBar{
        id:menuBarToolBar
    }

    header: ToolBar {

        id:toolBar

        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: "hello"
            anchors.centerIn: parent
        }


    }

    LeftToolBar{
        id:leftToolBar

        onButtonIndex: {

            menuBarToolBar.pageIndex = index

            page1.visible = false
            page2.visible = false
            page3.visible = false
            page4.visible = false

            switch(index){

                case 1:
                    page1.visible=true
                    break

                case 2:
                    page2.visible=true
                    break


                case 3:
                    page3.visible=true
                    break

                case 4:
                    page4.visible=true
                    break
            }

        }
    }

    Item {
        id:stackView

        property int currentIndex

        anchors.left: leftToolBar.right

        ClassroomStatus {
            id: page1
            visible: true
            anchors.fill: parent
//            searchBarText: searchBar.text

        }

        EmployeeeList {
            id: page2
            visible: false
            anchors.fill: parent
//            searchBarText: searchBar.text

        }

        SubjectsList {
            id: page3
            visible: false
            anchors.fill: parent
//            searchBarText: searchBar.text

        }

        SpecialAccess{
            id: page4
            visible: false
            anchors.fill: parent
        }


    }

    Connections{
        target: Handler
        onGlobalRefresh:{
            console.log("Global Refresh")

            page1.getClassroomList()
            page2.getemployeeList()
            page3.getsubjectsList()
            page4.getDateLimits()


        }

    }




}
