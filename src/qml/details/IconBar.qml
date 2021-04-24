// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.15
import Clayground.Physics 1.0
import Clayground.Svg 1.0

Row {
    id: iconBar

    property int maxValue: 0
    property int value: 0
    property string setSource: ""
    property string unsetSource: ""
    spacing: 5

    Repeater {
        model: maxValue
        Item {
            height: iconBar.height
            width: _avail.width
            Image {
                id: _avail
                fillMode: Image.PreserveAspectFit
                height: parent.height
                source: assets.visual(iconBar.setSource)
                visible: index < value
            }
            Image {
                fillMode: Image.PreserveAspectFit
                height: parent.height
                source: assets.visual(iconBar.unsetSource)
                visible: !_avail.visible
            }
        }
    }
}

