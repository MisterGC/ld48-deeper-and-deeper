import QtQuick 2.12
import QtQuick.Controls 2.15
import Clayground.Svg 1.0

import "details"

Rectangle {
    id: menuButtons
    color: gameState.screenBgColor
    Image {
        anchors.centerIn: parent
        source: assets.visual("visuals/instructions")
        fillMode: Image.PreserveAspectFit
        height: parent.height * .8; width: height;
        sourceSize.height: parent.height; sourceSize.width: parent.height * (783/500)
    }
    MouseArea{
        anchors.fill: parent;
        onClicked: gameApp.transitionTo(gameSceneComp, true)
    }
}
