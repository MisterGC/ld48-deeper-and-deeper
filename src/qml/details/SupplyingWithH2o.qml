// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12

Activity
{
    Timer {
        interval: 2000; repeat: true; running: parent.running
        onTriggered: if(actor.h2o > 0) actor.h2o--;
    }
}
