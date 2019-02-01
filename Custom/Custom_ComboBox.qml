import QtQuick 2.9
import QtQuick.Controls 2.2

ComboBox {
    id: control
    editable: true

    property var items: ({})
    property var filteredItems:({})

    property int popupHeight

    property bool verification : false
    property bool capital : false

    property int maxChar : 1

    property int selectedIndex : -1


    signal texFieldTextChanged(var arrayIndex)

    property string successBorderColor: "lightgrey"
    property string failBorderColor: "red"


    property bool textfieldEnable: true

    Component.onCompleted: {

        filteredItems=items
        textinput.text=''
    }

    model: filteredItems

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            id:delegateText
            text: modelData
//            color: "#21be2b"
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
        onClicked: {
            textinput.text=delegateText.text
            texFieldTextChanged(index)
        }
    }

    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 10
        height: 8
        contextType: "2d"

        Connections {
            target: control
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = 'grey'
            context.fill();
        }
    }

    contentItem: TextInput {
        id:textinput
        leftPadding: 5
        enabled: textfieldEnable
        rightPadding: control.indicator.width + control.spacing
        maximumLength: maxChar
        text: control.displayText
        font: control.font
        verticalAlignment: Text.AlignVCenter
        onTextEdited: {

            capital ? textinput.text=textinput.text.toUpperCase() : null

            if(textinput.text !== ""){
            control.popup.visible = true
                selectedIndex =-1
            }

            filter()

            for(var i=0; i<items.length; i++){
                if(textinput.text.toUpperCase===items[i].toUpperCase()){
                    verification =true
                    selectedIndex = i
                    texFieldTextChanged(i)
                    rect.border.color= successBorderColor
                    return
                }

            }

            verification=false
            selectedIndex = -1
            texFieldTextChanged(-1)
            rect.border.color = failBorderColor
            return

        }
    }

    background: Rectangle {
        id:rect
        implicitWidth: 120
        implicitHeight: 40
        radius: 2
        border.color: successBorderColor
    }

    popup: Popup {
        id:popupt
        y: control.height - 1
        width: control.width
        height: popupHeight
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: successBorderColor
            radius: 2
        }
    }

       function filter(){

        console.log(textinput.text)
        filteredItems = items.sort()

        if(textinput.text === ""){
            console.log("empty box exiting")
            filteredItems=items
            console.log(filteredItems.length)
            return
        }



        var temp = []


           for(var i=0; i<filteredItems.length; i++){
               if(filteredItems[i].search(textinput.text.toUpperCase()) === 0)
                   temp.push(filteredItems[i])
           }

           filteredItems=temp
           console.log(filteredItems.length)
       }
}
