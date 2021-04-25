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
    pixelPerUnit: width / (.5 * gameScene.worldXMax)


    // SCENE CREATION CFG: Map Entity Types -> Components to be intialized
    components: new Map([
                    ['Player', c1],
                    ['Planet', c2],
                    ['Asteroid', c3],
                    ['Wall', c4],
                    ['Floor', c5],
                    ['Finish', c5],
                    ['StaticEntity', c7]
                ])
    Component { id: c1; Player {} }
    Component { id: c2; Planet {} }
    Component { id: c3; Asteroid {} }
    Component { id: c4; Wall {} }
    Component { id: c5; Floor {} }
    Component { id: c6; RectTrigger {
            categories: collCat.staticGeo; collidesWith: collCat.player
            onEntered: {console.log("Game Finished"); gameApp.transitionTo(endingScreenComp, true); }
        } }
    Component { id: c7; StaticEntity {} }


    // PHYSICS SETTINGS
    gravity: Qt.point(0,0)
    timeStep: 1/60.0
    //physicsDebugging: true
    QtObject {
        id: collCat
        readonly property int staticGeo: Box.Category1
        readonly property int player: Box.Category2
        readonly property int asteroid: Box.Category3
        readonly property int planet: Box.Category4
        readonly property int noCollision: Box.None
    }


    running: player
    property var player: null

    onMapAboutToBeLoaded: {player = null; gameState.score=0}
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

    GameButton {
        width: gameScene.width * .08
        anchors.right: parent.right
        anchors.rightMargin: width * .3
        y: height * .3
        sourcePath: "visuals/btn_restart"
        onClicked: gameApp.transitionTo(gameSceneComp);
    }

    Connections{
        target: gameScene.player
        ignoreUnknownSignals: true
        function onEnergyChanged(){_endGameOnDemand()}
        function onH2oChanged(){_endGameOnDemand()}
    }
    function _endGameOnDemand(){
        if (player.energy <= 0 || player.h2o <=0)
            gameApp.transitionTo(endingScreenComp);
    }
}
