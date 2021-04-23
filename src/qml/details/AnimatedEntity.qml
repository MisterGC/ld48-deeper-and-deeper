// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

SpriteBoxBody
{
    id: theEntity

    bodyType: Body.Static
    property string sourceSvg: "visuals"
}
