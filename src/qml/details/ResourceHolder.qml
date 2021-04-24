// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

AnimatedEntity
{
    bodyType: Body.Dynamic

    property real maxEnergy: 3
    property real energy: maxEnergy
    property bool isAlive: energy >= 1

    property real maxH2o: 3
    property real h2o: maxH2o
    property bool isHydrated: h2o >= 1
}
