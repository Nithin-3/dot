import QtQuick
import Quickshell

ShellRoot {
    Launcher {}

    Connections {
        target: Quickshell
        function onLastWindowClosed() { Qt.quit() }
    }
}
