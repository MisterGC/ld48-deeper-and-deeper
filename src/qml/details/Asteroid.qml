// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.15
import QtMultimedia 5.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

ResourceHolder
{
    id: asteroid

    categories: collCat.asteroid
    collidesWith: collCat.staticGeo | collCat.player
    bodyType: Body.Dynamic
    density: 6
    restitution: .1

    property real maxVeloX: 1.
    property real maxVeloY: 1.

    Component.onCompleted: _letFlow.start()
    Timer{
        id: _letFlow; interval: 1000;
        onTriggered: {
            linearVelocity.x= Math.random() * asteroid.maxVeloX * (Math.random() > .5 ? 1 : -1);
            linearVelocity.y= Math.random() * asteroid.maxVeloY * (Math.random() > .5 ? 1 : -1);
        }
    }

    function initialResources(max){
        return Math.round(1 + Math.random() * (max-1));
    }

    maxH2o: initialResources(gameState.asteroidMaxH2o)
    maxEnergy: initialResources(gameState.asteroidMaxEnergy)

    onEnergyChanged: if (energy < 0) asteroid.destroy()
    visu.sprites: [
        Sprite {
            name: "asteroid";
            source: assets.visual(sourceSvg + "/" + name)
            frameCount: 1
            frameRate: 1
        }
    ]

    Column{
        anchors.bottom: asteroid.top
        anchors.left: asteroid.left
        spacing: .07 * asteroid.height
        Rectangle{
            height: asteroid.height * .12
            width: asteroid.width * (asteroid.h2o/gameState.asteroidMaxH2o)
            color: gameState.h2oColor
        }
        Rectangle{
            height: asteroid.height * .12
            width: asteroid.width * (asteroid.energy/gameState.asteroidMaxEnergy)
            color: gameState.energyColor
        }

    }

    property bool targeted: false
    Rectangle{
        z: -1; anchors.centerIn: parent;
        width: parent.width * 3; height: width
        radius: width * .5; color: "transparent"
        border.color: "red"; border.width: width * .1
        opacity: parent.targeted ? .5 : 0
        Behavior on opacity {NumberAnimation{duration: 250;}}
    }


}
