import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    exclusionMode: ExclusionMode.Ignore
    aboveWindows: true
    focusable: true
    color: "#0d000000"

    property var allEntries: []
    property var filteredEntries: []

    Shortcut {
        sequence: "Escape"
        onActivated: Qt.quit()
    }

    function refreshEntries() {
        const apps = DesktopEntries.applications.values
        allEntries = []
        for (let i = 0; i < apps.length; i++) {
            allEntries.push(apps[i])
        }
        filteredEntries = allEntries
        resultsList.currentIndex = 0
    }

    Component.onCompleted: searchField.forceActiveFocus()

    Timer {
        id: loadTimer
        interval: 100
        repeat: true
        running: true
        onTriggered: {
            const apps = DesktopEntries.applications.values
            if (apps.length > 0 || loadTimer.count > 50) {
                root.refreshEntries()
                running = false
            }
        }
    }

    Connections {
        target: DesktopEntries
        function onApplicationsChanged() {
            root.refreshEntries()
        }
    }



    function updateFilter(text) {
        if (text === "") {
            filteredEntries = allEntries
        } else {
            const q = text.toLowerCase()
            const result = []
            for (let i = 0; i < allEntries.length; i++) {
                const e = allEntries[i]
                if (e.name.toLowerCase().includes(q)) {
                    result.push(e)
                } else if (e.genericName && e.genericName.toLowerCase().includes(q)) {
                    result.push(e)
                } else if (e.comment && e.comment.toLowerCase().includes(q)) {
                    result.push(e)
                } else if (e.keywords && e.keywords.some(function(k) {
                    return k.toLowerCase().includes(q)
                })) {
                    result.push(e)
                }
            }
            filteredEntries = result
        }
    }

    function launchSelected() {
        if (resultsList.currentIndex >= 0 && resultsList.currentIndex < filteredEntries.length) {
            filteredEntries[resultsList.currentIndex].execute()
        }
        Qt.quit()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()
    }

    Item {
        id: centerDisplay
        x: (root.width / 2) - 50
        y: ((root.height - 88) * 0.42) - 50
        width: 100
        height: 130
        z: 50
        visible: filteredEntries.length > 0

        Rectangle {
            anchors.centerIn: parent
            width: 100
            height: 100
            radius: 50
            color: "#1a00ff44"
            border.color: "#00ff44"
            border.width: 2

            IconImage {
                anchors.centerIn: parent
                width: 60
                height: 60
                source: filteredEntries.length > 0 && resultsList.currentIndex >= 0 && resultsList.currentIndex < filteredEntries.length
                    ? Quickshell.iconPath(filteredEntries[resultsList.currentIndex].icon)
                    : ""
                asynchronous: true
            }
        }

        Text {
            anchors {
                top: parent.top
                topMargin: 112
                horizontalCenter: parent.horizontalCenter
            }
            text: filteredEntries.length > 0 && resultsList.currentIndex >= 0 && resultsList.currentIndex < filteredEntries.length
                ? filteredEntries[resultsList.currentIndex].name
                : ""
            color: "#00ff44"
            font.pixelSize: 12
            font.family: "monospace"
            horizontalAlignment: Text.AlignHCenter
            width: 140
            elide: Text.ElideRight
        }
    }

    PathView {
        id: resultsList
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: searchContainer.top
        }

        model: root.filteredEntries
        pathItemCount: 20
        interactive: false

        delegate: Item {
            id: delegateRoot
            width: 84
            height: 100
            transformOrigin: Item.Center

            required property var modelData

            scale: 1.0
            opacity: 1.0

            LauncherItem {
                anchors.centerIn: parent
                entry: delegateRoot.modelData
                highlighted: PathView.isCurrentItem

                onClicked: {
                    if (entry) entry.execute()
                    Qt.quit()
                }
            }
        }

        path: Path {
            id: circlePath
            property real cx: resultsList.width / 2
            property real cy: resultsList.height * 0.42
            property real r: Math.min(resultsList.width, resultsList.height) * 0.28

            startX: circlePath.cx
            startY: circlePath.cy - circlePath.r

            PathArc {
                x: circlePath.cx
                y: circlePath.cy + circlePath.r
                radiusX: circlePath.r
                radiusY: circlePath.r
                direction: PathArc.Counterclockwise
            }

            PathArc {
                x: circlePath.cx
                y: circlePath.cy - circlePath.r
                radiusX: circlePath.r
                radiusY: circlePath.r
                direction: PathArc.Counterclockwise
            }
        }

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        snapMode: PathView.SnapToItem
        movementDirection: PathView.Shortest

        focus: true
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            property real wheelAccum: 0
            onWheel: function(wheel) {
                wheelAccum += wheel.angleDelta.y
                while (wheelAccum >= 300) {
                    resultsList.decrementCurrentIndex()
                    wheelAccum -= 300
                }
                while (wheelAccum <= -300) {
                    resultsList.incrementCurrentIndex()
                    wheelAccum += 300
                }
            }
        }
        Keys.onUpPressed: decrementCurrentIndex()
        Keys.onDownPressed: incrementCurrentIndex()
        Keys.onReturnPressed: root.launchSelected()

        Text {
            anchors.centerIn: parent
            text: "No matching applications"
            color: "#00ff44"
            font.pixelSize: 16
            font.family: "monospace"
            visible: resultsList.count === 0 && root.filteredEntries.length === 0
        }
    }

    Rectangle {
        id: searchContainer
        anchors {
            bottom: parent.bottom
            bottomMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
        width: 500
        height: 48
        radius: 24
        color: "#0a0a1a"
        border.color: "#00ff44"
        border.width: 1

        TextField {
            id: searchField
            anchors {
                fill: parent
                leftMargin: 16
                rightMargin: 16
                topMargin: 12
                bottomMargin: 12
            }
            placeholderText: "Search applications..."
            placeholderTextColor: "#6600ff44"
            color: "#00ff44"
            font.pixelSize: 16
            font.family: "monospace"
            background: Item {}

            onTextChanged: {
                root.updateFilter(text)
                if (resultsList.currentIndex >= root.filteredEntries.length) {
                    resultsList.currentIndex = 0
                }
                if (resultsList.currentIndex < 0 && root.filteredEntries.length > 0) {
                    resultsList.currentIndex = 0
                }
            }

            Keys.onDownPressed: resultsList.incrementCurrentIndex()
            Keys.onUpPressed: resultsList.decrementCurrentIndex()
            Keys.onReturnPressed: root.launchSelected()
            Keys.onEscapePressed: Qt.quit()
        }
    }
}
