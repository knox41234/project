import QtQuick 2.9


Rectangle {

    property bool activate

    color: "transparent"
Image {
   id: rect
   source:  "/Images/Denied"
   opacity: 1
   anchors.fill:parent


    states: State {
        name: "mouse-over"; when: activate
        PropertyChanges { target: rect; scale: 0.8; opacity: 0}
        PropertyChanges { target: rect2; scale: 0.8; opacity: 1}
    }

    transitions: Transition {
        NumberAnimation { properties: "scale, opacity"; easing.type: Easing.InOutQuad; duration: 500  }
    }
}

Image {
   id: rect2
   source:  "/Images/Verified"
   opacity: 0
   anchors.fill: rect

  }
}
