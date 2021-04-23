// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.15
import QtMultimedia 5.12
import Box2D 2.0
import Clayground.Physics 1.0
import Clayground.Svg 1.0

LivingEntity
{
    id: enemy

    categories: collCat.enemy
    collidesWith: collCat.staticGeo | collCat.player
    bodyType: Body.Dynamic
    maxHealth: 1
    onHealthChanged: if (health < 0) enemy.destroy()
    visu.sprites: [
        Sprite {
            name: "enemy";
            source: assets.visual(sourceSvg + "/" + name)
            frameCount: 1
            frameRate: 1
        }
    ]

}
