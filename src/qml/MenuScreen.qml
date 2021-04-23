import QtQuick 2.12
import QtQuick.Controls 2.15
import Clayground.Svg 1.0

import "details"

Rectangle {
    id: menuButtons
    color: gameState.screenBgColor
    Text {
       anchors.centerIn: parent
       text: assets.text(assets.cCHOOSE_YOUR_SETTINGS)
    }
    MouseArea{
        anchors.fill: parent;
        onClicked: gameApp.transitionTo(gameSceneComp, true)
    }
}
