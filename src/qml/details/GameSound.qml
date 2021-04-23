// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtMultimedia 5.12
import Clayground.Common 1.0

SoundEffect {
    property string sound: ""
    muted: gameState.muteSound
    source: assets.sound(sound)
}
