// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Controls 2.15

import "details"

Rectangle {
    color: gameState.screenBgColor
    Component.onCompleted: {
        if (gameMusic.sound != "menu_music")
            gameMusic.playLooped("menu_music")
    }

    Image {
        anchors.centerIn: parent
        source: assets.visual("visuals/title_image")
        fillMode: Image.PreserveAspectFit
        height: parent.height; width: height;
        sourceSize.height: parent.height; sourceSize.width: parent.height * (493/722)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: gameApp.transitionTo(menuScreenComp)
    }

    GameButton {
        width: gameState.btnWidth * .6
        anchors.right: parent.right; anchors.rightMargin: width * .3
        anchors.top: parent.top; anchors.topMargin: width *  .25
        sourcePath: "visuals/btn_info"
        onClicked: gameApp.transitionTo(infoScreenComp)
    }

}
