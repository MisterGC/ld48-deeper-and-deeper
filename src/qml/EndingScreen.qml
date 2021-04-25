// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Controls 2.15
import QtMultimedia 5.15

import "details"

Rectangle {
    Component.onCompleted: gameMusic.playLooped("ending_music");
    Text{anchors.centerIn: parent;
        text: "You have found " + gameState.score + " planet(s)."
    }
    MouseArea{anchors.fill: parent; onClicked: gameApp.transitionTo(gameSceneComp);}
}
