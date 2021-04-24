// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12

Activity
{
    onSecondPassedBy: actor.energy-= (actor.energy > gameState.movingEnergyPerSec ?
                                      gameState.movingEnergyPerSec : actor.energy);
}
