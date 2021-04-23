// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Controls 2.15

import "details"

Item {
    Component.onCompleted: {
        if (gameMusic.sound != "menu_music")
            gameMusic.playLooped("menu_music")
    }

    Image {
        id: titleImg
        anchors.centerIn: parent
        source: assets.visual("visuals/title_image")
        fillMode: Image.PreserveAspectFit
        width: stack.width * .8
        height: (sourceSize.height / sourceSize.width) * width
        MouseArea {
            anchors.fill: parent
            onClicked: gameApp.transitionTo(menuScreenComp)
        }
    }

    GameButton {
        width: gameState.btnWidth * .6
        anchors.right: parent.right; anchors.rightMargin: width * .3
        anchors.top: parent.top; anchors.topMargin: width *  .25
        sourcePath: "visuals/btn_info"
        onClicked: gameApp.transitionTo(infoScreenComp)
    }

}
