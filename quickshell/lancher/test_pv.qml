import QtQuick
import Quickshell
import Quickshell.Widgets

PanelWindow {
    width: 400; height: 400
    color: "transparent"
    x: 100; y: 100

    PathView {
        anchors.fill: parent
        model: ["Firefox", "Terminal", "Files", "Code", "Settings", "Music", "Calc", "Clock", "Maps", "Camera", "Browser", "Mail"]
        delegate: Text {
            text: modelData
            color: "white"
            font.pixelSize: 18
        }
        path: Path {
            startX: 200; startY: 50
            PathArc { x: 200; y: 350; radiusX: 150; radiusY: 150 }
            PathArc { x: 200; y: 50; radiusX: 150; radiusY: 150 }
        }
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
    }
}
