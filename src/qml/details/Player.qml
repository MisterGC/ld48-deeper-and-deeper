// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtMultimedia 5.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

ResourceHolder
{
    id: player

    maxEnergy: 5
    spriteWidthWu: spriteHeightWu

    // PHYSICS
    categories: collCat.player
    collidesWith: collCat.staticGeo | collCat.enemy
    Component.onCompleted: ClayPhysics.connectOnEntered(fixtures[0], _onCollision)
    function _onCollision(entity) {if (entity instanceof Asteroid) energy--;}

    // VISUALS
    visu.sprites: [
        Sprite {
            name: "player";
            source: assets.visual(sourceSvg + "/" + name)
            frameCount: 1
            frameRate: 1
        }
    ]

    Rectangle{
        z: -1; anchors.centerIn: parent;
        width: parent.width * 3; height: width
        radius: width * .5; opacity: .5; color: "orange"
        visible: theGameCtrl.buttonAPressed
    }

    // BEHAVIOR
    Moving{actor: player; running: Math.abs(player.linearVelocity.x) > 0  ||
                                   Math.abs(player.linearVelocity.y) > 0
    }
    Harvesting {id: harvesting;  actor: player; running: theGameCtrl.buttonAPressed}

    readonly property real veloCompMax: 25
    property real xDirDesire: theGameCtrl.axisX
    linearVelocity.x: xDirDesire * veloCompMax
    property real yDirDesire: theGameCtrl.axisY
    linearVelocity.y: yDirDesire * veloCompMax

    onEnergyChanged: {if(energy < maxEnergy) console.log("Ouch!")}


}
