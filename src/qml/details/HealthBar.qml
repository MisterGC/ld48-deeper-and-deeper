// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.15
import Clayground.Physics 1.0
import Clayground.Svg 1.0

IconBar {
    id: healthBar
    property Player observed: null
    height: observed ? observed.height * .5 : 1
    maxValue: player ? player.maxHealth: 1
    value: player ? player.health : 1
    setSource: "visuals/heart_avail"
    unsetSource: "visuals/heart_na"
}

