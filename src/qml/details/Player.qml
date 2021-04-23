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
        body.addFixture(areaOfDamage.createObject(player,{}));
        ClayPhysics.connectOnEntered(fixtures[0], _onCollision)
        ClayPhysics.connectOnEntered(fixtures[1], _onEnemySpotted)
        ClayPhysics.connectOnLeft(fixtures[1], _onEnemyLost)
    }
    function _onCollision(entity) { if (entity instanceof Enemy) health--;}
    function _onEnemySpotted(entity) {if (entity instanceof Enemy) enemy = entity;}
    function _onEnemyLost(entity) {if (entity instanceof Enemy) enemy = null;}

    maxHealth: 8
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

    onHealthChanged: {if(health < maxHealth) console.log("Ouch!")}

    Component {
        id: areaOfDamage
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
        onVisibleChanged: if (enemy) enemy.health--;
    }
}
