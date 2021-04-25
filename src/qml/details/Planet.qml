// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.15
import QtMultimedia 5.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

ResourceHolder
{
    id: planet

    categories: collCat.planet
    collidesWith: collCat.staticGeo | collCat.player
    bodyType: Body.Dynamic
    density: 6
    restitution: .1
    sensor: true

    property bool colonized: false
    property string type: "blue"
    property alias name: _lbl.text

    Component.onCompleted: {
        ClayPhysics.connectOnEntered(body.fixtures[0],
                                     (p) => {
                                         if (!planet.colonized) {
                                         gameState.score++;
                                         planet.colonized = true;
                                         }
                                         _reTim.player = p;
                                     },
                                     (f) => {return f.getBody().target instanceof Player;});
        ClayPhysics.connectOnLeft(body.fixtures[0],
                                     (p) => {_reTim.player = null;},
                                     (f) => {return f.getBody().target instanceof Player;});
    }

    Timer{
        id: _reTim;  property var player: null; interval: 500; repeat: true
        running: player; onTriggered: {let p = player; p.h2o = player.maxH2o; p.energy = p.maxEnergy;}
    }

    visu.sprites: [
        Sprite {
            name: "planet";
            source: assets.visual(sourceSvg + "/planet_" + planet.type)
            frameCount: 1
            frameRate: 1
            to: {"unknown": 0}
        }
    ]

    Rectangle{
        anchors.fill: visu; color: "brown"; radius: width * .5; opacity: planet.colonized ? 0 : .9
        Text{anchors.centerIn: parent; color: "white"; text: "?"; font.pixelSize: parent.height * .5}
        Behavior on opacity {NumberAnimation{duration: 500}}
    }

    Text {id: _lbl; opacity: planet.colonized ? 1 : 0; color: "white";
          anchors.top: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter;
          anchors.topMargin: height * .1; font.pixelSize: planet.height * .07
          Behavior on opacity {NumberAnimation{duration: 500}}
    }

}
