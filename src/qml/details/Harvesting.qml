// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import Clayground.Physics 1.0
import Box2D 2.0

Activity
{
    readonly property real _h2oPerSec: gameState.harvestH2oPerSec
    readonly property real _energyPerSec: gameState.harvestEnergyPerSec

    Component.onCompleted: {
        actor.body.addFixture(rangeOfExtractionComp.createObject(actor,{}));
        asteroidsWithinRange.fixture = fixtures[fixtures.length -1];
    }

    CollisionTracker{
        id: asteroidsWithinRange
        onEntered: if (entity instanceof Asteroid) entity.targeted = true;
        onLeft: if (entity instanceof Asteroid) entity.targeted = false;
    }
    Component {
        id: rangeOfExtractionComp
        Box {
            x: -actor.width
            y: -actor.height
            width: actor.width * 3
            height: actor.height * 3
            sensor: true
            categories: collCat.player
            collidesWith: collCat.asteroid
        }
    }

    onSecondPassedBy: {
        for (let e of asteroidsWithinRange.entities){
            if (e instanceof Asteroid) {

                let de = e.energy - _energyPerSec > 0 ? _energyPerSec : e.energy;
                let se = actor.energy + de;
                e.energy -= de;
                actor.energy = se > actor.maxEnergy ? actor.maxEnergy : se;

                let dh2o = e.h2o - _h2oPerSec > 0 ? _h2oPerSec : e.h2o;
                let sh2o = actor.h2o + dh2o;
                e.h2o -= dh2o;
                actor.h2o = sh2o > actor.maxH2o ? actor.maxH2o : sh2o;
            }

        }
    }

}
