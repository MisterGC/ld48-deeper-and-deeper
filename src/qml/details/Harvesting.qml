// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import Clayground.Physics 1.0
import Box2D 2.0

Activity
{
    Component.onCompleted: {
        actor.body.addFixture(rangeOfExtractionComp.createObject(actor,{}));
        asteroidsWithinRange.fixture = fixtures[fixtures.length -1];
    }

    CollisionTracker{id: asteroidsWithinRange}

    Timer {
        interval: 1000; running: parent.running; repeat: true
        onTriggered: {
            for (let e of asteroidsWithinRange.entities){
                if (e instanceof Asteroid) e.energy--;
            }
        }
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
            collidesWith: collCat.enemy
        }
    }
}
