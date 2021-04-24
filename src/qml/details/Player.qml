// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtMultimedia 5.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

LivingEntity
{
    id: player

    property var enemy: null
    Component.onCompleted: {
        body.addFixture(rangeOfExtractionComp.createObject(player,{}));
        ClayPhysics.connectOnEntered(fixtures[0], _onCollision)
        asteroidsWithinRange.fixture = fixtures[1];
    }

    CollisionTracker{id: asteroidsWithinRange }
    Connections{
        target: theGameCtrl
        function onButtonAPressedChanged(){
            for (let e of asteroidsWithinRange.entities){
                if (e instanceof Asteroid) e.energy--;
            }
        }
    }

    function _onCollision(entity) { if (entity instanceof Asteroid) energy--;}

    maxEnergy: 5
    spriteWidthWu: spriteHeightWu

    categories: collCat.player
    collidesWith: collCat.staticGeo | collCat.enemy

    visu.sprites: [
        Sprite {
            name: "player";
            source: assets.visual(sourceSvg + "/" + name)
            frameCount: 1
            frameRate: 1
        }
    ]

    readonly property real veloCompMax: 25
    property real xDirDesire: theGameCtrl.axisX
    linearVelocity.x: xDirDesire * veloCompMax
    property real yDirDesire: theGameCtrl.axisY
    linearVelocity.y: yDirDesire * veloCompMax

    onEnergyChanged: {if(energy < maxEnergy) console.log("Ouch!")}

    Component {
        id: rangeOfExtractionComp
        Box {
            x: -player.width
            y: -player.height
            width: player.width * 3
            height: player.height * 3
            sensor: true
            categories: collCat.player
            collidesWith: collCat.enemy
        }
    }

    Rectangle{
        z: -1; anchors.centerIn: parent;
        width: parent.width * 3; height: width
        radius: width * .5; opacity: .5; color: "orange"
        visible: theGameCtrl.buttonAPressed
    }
}
