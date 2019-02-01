import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4


MenuBar {
        id:menuBar

        property int pageIndex: 0


        Component.onCompleted: {
            addclassroom.width=Handler.getWindowHeight() *0.30
            addclassroom.height=Handler.getWindowWidth() * 0.15

            addschedule.width=Handler.getWindowWidth() *0.70
            addschedule.height=Handler.getWindowWidth() * 0.30


            addemployee.width=Handler.getWindowHeight() *0.60
            addemployee.height=Handler.getWindowWidth() * 0.40

            adddepartment.width=Handler.getWindowHeight() *0.40
            adddepartment.height=Handler.getWindowWidth() * 0.12

            addsubject.width=Handler.getWindowHeight() *0.60
            addsubject.height=Handler.getWindowWidth() * 0.10
        }

        Menu {

            title: qsTr("&File")

            Action { text: qsTr("&New...") }
            Action { text: qsTr("&Open...") }
            Action { text: qsTr("&Save") }
            Action { text: qsTr("Save &As...") }
            MenuSeparator { }
            Action { text: qsTr("&Quit") }
        }
        Menu {
            title: qsTr("&Edit")
            Action { text: qsTr("Cu&t") }
            Action { text: qsTr("&Copy") }
            Action { text: qsTr("&Paste") }
        }


        Menu {
            title: qsTr("&Tools")

            Action {
                shortcut: "Ctrl+C"
                text:"Add &Classroom"

                onTriggered: {
                    addclassroom.visible=true
                }
            }

            Action {
                shortcut: "Ctrl+E"
                text: "Add &Employee"
                onTriggered: {
                    addemployee.visible=true
                }
            }

            Action {
                shortcut: "Ctrl+S"
                text: "Add &Schedule"
                onTriggered: {
                    addschedule.visible=true
                }
            }

            Action {
                shortcut: "Ctrl+D"
                text: "Add &Department"
                onTriggered: {
                    adddepartment.visible=true
                }
            }

            Action {
                shortcut: "Ctrl+U"
                text: "Add S&ubject"
                onTriggered: {
                   addsubject.visible=true
                }
            }

        }
        Menu {
            title: qsTr("&Window")
            Action {
                text: qsTr("&Refresh")
                shortcut: StandardKey.Refresh
                icon.name: "view-refresh"

                onTriggered: {
                    Handler.emitGlobalRefresh()
                }
            }
        }
        Menu {
            title: qsTr("&Setup")
            Action { text: qsTr("&About") }
        }
        Menu {
            title: qsTr("&Help")
            Action { text: qsTr("&About") }
        }



        AddClassRoomPage{
            id:addclassroom
            visible: false
        }

        AddClassSchedule{
            id:addschedule
            visible: false
        }

        AddEmployee{
            id:addemployee
            visible: false
        }


        AddDepartment{
            id:adddepartment
            visible: false
        }

        AddSubject{
            id:addsubject
            visible: false
        }

    }
