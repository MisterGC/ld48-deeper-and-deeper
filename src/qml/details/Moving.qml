// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12

Activity
{
    Timer {
        interval: 1000; running: parent.running; repeat: true
        onTriggered: actor.energy--;
    }
}
