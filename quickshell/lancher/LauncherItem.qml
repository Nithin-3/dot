import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: root

    required property var entry
    property bool highlighted: false
    signal clicked()

    implicitWidth: 84
    implicitHeight: 100

    transformOrigin: Item.Center

    Rectangle {
        id: iconBg
        anchors.centerIn: parent
        width: 68
        height: 68
        radius: 34
        color: highlighted ? "#2600ff44" : "#8000140a"
        border.color: highlighted ? "#00ff44" : "#004422"
        border.width: highlighted ? 3 : 2
        Behavior on border.width { NumberAnimation { duration: 150 } }
        Behavior on color { ColorAnimation { duration: 150 } }

        Text {
            anchors.centerIn: parent
            text: root.entry ? root.entry.name.charAt(0).toUpperCase() : "?"
            color: "#00ff44"
            font.pixelSize: 20
            font.family: "monospace"
            visible: icon.status === Image.Error
        }
        IconImage {
            id: icon
            anchors.centerIn: parent
            width: 44
            height: 44
            source: root.entry ? Quickshell.iconPath(root.entry.icon) : ""
            visible: status !== Image.Error
        }
    }

    Rectangle {
        anchors.centerIn: iconBg
        width: 76
        height: 76
        radius: 38
        color: "transparent"
        border.color: "#00ff44"
        border.width: 2
        opacity: root.highlighted ? 0.6 : 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    Text {
        anchors {
            top: iconBg.bottom
            topMargin: 4
            horizontalCenter: parent.horizontalCenter
        }
        text: root.entry ? root.entry.name : ""
        color: "#00ff44"
        font.pixelSize: 10
        font.family: "monospace"
        horizontalAlignment: Text.AlignHCenter
        visible: root.highlighted
        width: 80
        elide: Text.ElideRight
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
