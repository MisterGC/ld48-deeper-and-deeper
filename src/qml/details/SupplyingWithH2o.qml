// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12

Activity
{
    onSecondPassedBy: actor.h2o -= (actor.h2o > gameState.supplyH2oPerSec ?
                                    gameState.supplyH2oPerSec : actor.h2o);
}
