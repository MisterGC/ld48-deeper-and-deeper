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
    maxH2o: 10
    spriteWidthWu: spriteHeightWu

    // PHYSICS
    categories: collCat.player
    collidesWith: collCat.staticGeo | collCat.asteroid
    Component.onCompleted: ClayPhysics.connectOnEntered(fixtures[0], _onCollision)
    function _onCollision(entity) {if (entity instanceof Asteroid) energy--;}
    readonly property real veloCompMax: 25
    property real xDirDesire: theGameCtrl.axisX
    linearVelocity.x: xDirDesire * veloCompMax
    property real yDirDesire: theGameCtrl.axisY
    linearVelocity.y: yDirDesire * veloCompMax

    // VISUAL
    Connections{
        target: _moving
        function onIsCoolChanged(){
            if (_moving.isCool) visu.jumpTo("player")
            else visu.jumpTo("player_moving")
        }
    }
    visu.sprites: [
        Sprite {
            name: "player";
            source: assets.visual(sourceSvg + "/" + name)
            frameCount: 1
            frameRate: 1
        },
        Sprite {
            name: "player_moving";
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

    Rectangle{
        id: _engineLight
        z: -1; anchors.centerIn: parent;
        width: parent.width * 1.1; height: width
        radius: width * .5; opacity: 0; color: gameState.h2oColor
        SequentialAnimation{
            loops: Animation.Infinite; running: !_moving.isCool
            onRunningChanged: if (!running) _fadeOut.start()
            PropertyAnimation { target: _engineLight; property: "opacity"
                to: 0.7; easing.type: Easing.OutQuad; duration: 1000; }
            PropertyAnimation { target: _engineLight; property: "opacity"
                to: 0.5; easing.type: Easing.OutQuad; duration: 1000;  }
        }
        PropertyAnimation {id: _fadeOut; target: _engineLight; property: "opacity"
            to: 0.0; easing.type: Easing.OutQuad; duration: 500; }
    }

    // BEHAVIOR
    Moving{
        id: _moving; actor: player;
        running: Math.abs(xDirDesire) > Number.MIN_VALUE ||
                 Math.abs(yDirDesire) > Number.MIN_VALUE
        coolDownMs: 500
    }
    Harvesting{id: harvesting;  actor: player; running: theGameCtrl.buttonAPressed}
    SupplyingWithH2o{actor: player; running: player.h2o>0}


    onEnergyChanged: {if(energy < maxEnergy) console.log("Ouch!")}


}
