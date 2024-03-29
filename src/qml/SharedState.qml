import QtQuick 2.12
import QtQuick.LocalStorage 2.12
import Clayground.Common 1.0

import "details"

Item {
    id: gameState

    // MECHANIC (All values at this central location
    // to fascillitate balancing)
    // Resource Init
    readonly property real playerMaxH2o: 3
    readonly property real playerMaxEnergy: 3
    readonly property real asteroidMaxH2o: 3
    readonly property real asteroidMaxEnergy: 3
    // Resource Costs
    readonly property real movingEnergyPerSec: .1
    readonly property real miningEnergyPerSec: .2
    readonly property real supplyH2oPerSec: .1
    // Resource Gains
    readonly property real harvestH2oPerSec: 1
    readonly property real harvestEnergyPerSec: 1


    // PROGRESS/SCORE/ACHIEVEMENTS
    property string level: "level"
    property int score: 0
    property int _highScore: 0
    property int numOfPlanets: 0

    // SOUND/MUSIC
    property bool muteSound: false
    property bool muteMusic: false

    //VISUAL
    property int fontPixelSize: 10
    property int safeTopMargin: 10
    property int buttonWidth: 100
    readonly property string screenBgColor: "#292626"
    readonly property string energyColor: "#70dc4e"
    readonly property string h2oColor: "#4ecfdc"
}

