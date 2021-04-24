// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12

Item
{
    property ResourceHolder actor: null
    property bool running: false

    property int coolDownMs: 0
    onRunningChanged: if (!running) _coolDown.start()

    signal secondPassedBy();
    Timer{interval: 1000; repeat: true; running: parent.running || _coolDown.running
        onTriggered: parent.secondPassedBy();}
    Timer{id: _coolDown; interval: parent.coolDownMs}

}
