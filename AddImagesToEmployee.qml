import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {

    title:"Upload Training Set"

    FileDialog{

        property var fileNameList: ({})

        id:filedialog
        title:"Choose you want to add the images"
        nameFilters: [ "Image files (*.jpg *.png)"]
        selectMultiple: true
        folder: shortcuts.desktop
        onAccepted: {

            fileNameList = []
            for(var i=0;i<fileUrls.length;i++)
                fileNameList.push(Handler.getFileNameFromPath(fileUrls[i]))

        }
        onRejected: {
            filedialog.close()
        }
    }



    Button{
        id:open
        onClicked: {
            filedialog.open()
        }

    }


    Button{
        id:send
        anchors.left: open.right
        onClicked: {
             console.log(filedialog.fileUrls)
            var hand = filedialog.fileUrls
             Handler.postImages(hand)
        }

    }



}
