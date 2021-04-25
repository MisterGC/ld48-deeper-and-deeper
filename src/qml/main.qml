// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    visibility: Window.FullScreen
    title: qsTr("Astromoles")
    GameApp {}
    Component.onCompleted: if(Qt.platform.pluginName === "minimal") Qt.quit()
}
