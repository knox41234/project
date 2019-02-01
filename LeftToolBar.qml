import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id:root

    signal buttonIndex(var index)

        Column{

           Button{
               text:"Classrooms"
               width: root.width
               height: root.height/5

               onClicked: {
                   buttonIndex(1)
               }
           }

           Button{
               text:"Employee"
               width: root.width
               height: root.height/5

               onClicked: {
                   buttonIndex(2)
               }
           }

           Button{
               text:"Subjects and Schedule"
               width: root.width
               height: root.height/5

               onClicked: {
                   buttonIndex(3)
               }
           }

           Button{
               text:"Special Code"
               width: root.width
               height: root.height/5

               onClicked: {
                   buttonIndex(4)
               }
           }

           Button{
               text:"Button5"
               width: root.width
               height: root.height/5

               onClicked: {
                   buttonIndex(5)
               }
           }
        }


}
