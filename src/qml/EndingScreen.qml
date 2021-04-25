// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Controls 2.15
import QtMultimedia 5.15

import "details"

Rectangle {
    color: gameState.screenBgColor
    Component.onCompleted: gameMusic.playLooped("ending_music");
    Image {
        anchors.centerIn: parent
        source: assets.visual("visuals/patch")
        fillMode: Image.PreserveAspectFit
        height: .5 * parent.height; width: height
        sourceSize.height: .5 * parent.height; sourceSize.width: height
        Text{
            anchors.top: parent.bottom; anchors.topMargin: height *.2
            anchors.horizontalCenter: parent.horizontalCenter
            text: "You have found " + gameState.score + " planet(s)."
            font.pixelSize: parent.height * .1; color: "white"
        }
    }
    MouseArea{anchors.fill: parent; onClicked: gameApp.transitionTo(gameSceneComp);}
}
