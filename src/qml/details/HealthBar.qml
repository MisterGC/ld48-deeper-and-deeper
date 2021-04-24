// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.15
import Clayground.Physics 1.0
import Clayground.Svg 1.0

IconBar {
    property Player observed: null
    height: observed ? observed.height * .5 : 1
    maxValue: player ? player.maxEnergy: 1
    value: player ? player.energy : 1
    setSource: "visuals/energy_avail"
    unsetSource: "visuals/energy_na"
}

