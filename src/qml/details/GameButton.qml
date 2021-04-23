// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Controls 2.15

Button {
    width: 100
    height: width
    padding: { left: 0; right: 0; top: 0; bottom: 0 }
    property string sourcePath: ""
    property bool isLocked: false
    background: Rectangle {opacity: 0}
    Image {
        anchors.fill: parent
        source: assets.visual(parent.sourcePath)
    }
}
