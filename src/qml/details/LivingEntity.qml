// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

AnimatedEntity
{
    id: theEntity

    bodyType: Body.Dynamic
    property int maxHealth: 3
    property int health: maxHealth
    property bool isAlive: health >= 1
    property bool invulnerable: false
}
