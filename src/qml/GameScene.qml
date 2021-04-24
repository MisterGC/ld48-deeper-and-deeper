// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Controls 2.15
import QtMultimedia 5.12
import QtQuick.Particles 2.0
import Box2D 2.0
import Clayground.GameController 1.0
import Clayground.World 1.0
import Clayground.Behavior 1.0

import "details"

ClayWorld {
    id: gameScene

    Component.onCompleted: map = assets.scene(gameState.level)

    // RENDER SETTINGS
    pixelPerUnit: width / gameScene.worldXMax


    // SCENE CREATION CFG: Map Entity Types -> Components to be intialized
    components: new Map([
                    ['Player', c1],
                    ['Asteroid', c2],
                    ['Wall', c3],
                    ['Floor', c4],
                    ['Finish', c5],
                    ['StaticEntity', c6]
                ])
    Component { id: c1; Player {} }
    Component { id: c2; Asteroid {} }
    Component { id: c3; Wall {} }
    Component { id: c4; Floor {} }
    Component { id: c5; RectTrigger {
            categories: collCat.staticGeo; collidesWith: collCat.player
            onEntered: {console.log("Game Finished"); gameApp.transitionTo(endingScreenComp, true); }
        } }
    Component { id: c6; StaticEntity {} }


    // PHYSICS SETTINGS
    gravity: Qt.point(0,0)
    timeStep: 1/60.0
    //physicsDebugging: true
    QtObject {
        id: collCat
        readonly property int staticGeo: Box.Category1
        readonly property int player: Box.Category2
        readonly property int enemy: Box.Category3
        readonly property int noCollision: Box.None
    }


    running: !player ? false : player.isAlive && !paused
    property bool paused: false
    onPausedChanged: gameMusic.volume = gameScene.paused ? .5 : 1
    property var player: null

    onMapAboutToBeLoaded: {player = null;}
    onMapLoaded: {
        theGameCtrl.selectKeyboard(Qt.Key_S,
                                   Qt.Key_W,
                                   Qt.Key_A,
                                   Qt.Key_D,
                                   Qt.Key_J,
                                   Qt.Key_K);
        gameScene.observedItem = player;
        gameState.fontPixelSize = player.height * .4
        gameMusic.playLooped("level_music");
    }

    Keys.forwardTo: theGameCtrl
    GameController { id: theGameCtrl; anchors.fill: parent }

    Row {
        anchors.top: parent.top
        anchors.topMargin: gameState.safeTopMargin
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: .5 * height
        EnergyBar { observed: player }
        H2oBar { observed: player }
    }

    onMapEntityCreated: {
        if (obj instanceof Player) {
            gameScene.player = obj;
            obj.z = 500;
        }
    }

    Timer {id: scoreBoardTrigger; interval: 7000; onTriggered: gameApp.transitionTo(endingScreenComp)}

    MouseArea {
        id: inGameMenu
        visible: gameScene.paused ||  (player && !player.isAlive)
        anchors.fill: parent
        onClicked: gameScene.paused = false
        Row {
            anchors.centerIn: parent
            spacing: gameState.btnWidth * .1
            GameButton {
                width: gameState.btnWidth
                sourcePath: "visuals/btn_restart"
                onClicked: gameApp.transitionTo(gameSceneComp, true)
            }
            GameButton {
                width: gameState.btnWidth
                sourcePath: "visuals/btn_exit"
                onClicked: gameApp.transitionTo(menuScreenComp, true)
            }
        }
    }

    GameButton {
        id: _playBtn
        visible: (player && player.isAlive)
        width: gameScene.width * .08
        anchors.right: parent.right
        anchors.rightMargin: width * .3
        y: height * .3
        sourcePath: "visuals/" + (gameScene.paused ? "btn_play" : "btn_pause")
        onClicked: gameScene.paused = !gameScene.paused
    }

}
