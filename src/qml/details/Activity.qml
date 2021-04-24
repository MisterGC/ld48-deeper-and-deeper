// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12

Item
{
    property ResourceHolder actor: null
    property bool running: false

    property int coolDownMs: 0
    readonly property bool isCool: !(running || _coolDown.running)
    onRunningChanged: if (!running) _coolDown.start()

    signal secondPassedBy();
    Timer{interval: 1000; repeat: true; running: !isCool
        onTriggered: parent.secondPassedBy();}
    Timer{id: _coolDown; interval: parent.coolDownMs}

}
