/*
 * harbour-domino.qml
 * Copyright (C) Damien Caliste 2017 <dcaliste@free.fr>
 *
 * domino is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
    id: app
    initialPage: page
    //cover: cover
    _defaultPageOrientations: Orientation.All

    function pMiss(digit, nPool, visibleDistribution, nHand) {
        // Return the probability that @digit is missing in
        // a set of @nHand dominos, when the size of the pool of total
        // number of dominos is @nPool and the distribution of visible
        // digits is given by @visibleDistribution
        var p = 1.
        for (var i = 0; i < nHand; i++) {
            p *= (nPool - i - (7. - visibleDistribution[digit])) / (nPool - i)
        }
        return p
    }

    Page {
        id: page

        SetModel {
            id: game
            Component.onCompleted: {
                append({'left': 5, 'right': 2})
                append({'left': 2, 'right': 6})
                append({'left': 6, 'right': 6})
                append({'left': 6, 'right': 0})
                append({'left': 0, 'right': 0})
                append({'left': 0, 'right': 3})
                append({'left': 3, 'right': 4})
            }
        }

        SetModel {
            id: hand
            Component.onCompleted: {
                append({'left': 5, 'right': 4})
                append({'left': 0, 'right': 3})
                append({'left': 0, 'right': 5})
                append({'left': 6, 'right': 1})
                append({'left': 6, 'right': 5})
                append({'left': 4, 'right': 6})
                append({'left': 3, 'right': 2})
            }
        }

        SilicaFlickable {
            id: board

            anchors.centerIn: parent
            width: page.width
            height: line.height
            contentWidth: line.width
            contentHeight: line.height

            Row {
                id: line
                Repeater {
                    model: game
                    delegate: Tile {
                        anchors.verticalCenter: parent.verticalCenter
                        leftId: model.left
                        rightId: model.right
                    }
                }
            }

            HorizontalScrollDecorator {
                flickable: board
            }
        }

        Rectangle {
            width: page.width
            height: page.height / 3
            anchors.bottom: parent.bottom

            gradient: Gradient {
                GradientStop {position: 0.; color: Theme.highlightDimmerColor}
                GradientStop {position: 1.; color: Theme.rgba(Theme.highlightDimmerColor, 0.75)}
            }

            MissingIndicator {
                id: help
                property var proba: [0., 0., 0., 0., 0., 0., 0.]

                function update() {
                    var proba = []
                    var distribution = [0, 0, 0, 0, 0, 0, 0]
                    for (var i = 0; i < 7; i++) {
                        distribution[i] += game.distribution[i]
                        distribution[i] += hand.distribution[i]
                    }
                    for (var i = 0; i < 7; i++) {
                        proba.push(app.pMiss(i, 28, distribution, 4))
                    }
                    help.proba = proba
                }

                Connections {
                    target: game
                    onChanged: help.update()
                }
                Connections {
                    target: hand
                    onChanged: help.update()
                }

                model: proba
                size: page.isPortrait ? page.height / 21 : page.width / 21
                anchors.top: parent.top
                anchors.right: parent.right
                width: page.isPortrait ? size + Theme.itemSizeMedium : page.width
                height: page.isPortrait ? 7 * size : size
            }

            Item {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: page.isPortrait ? parent.width - help.width : parent.width
                height: page.isPortrait ? parent.height : parent.height - help.height
                Flow {
                    id: handFlow
                    property real size: Math.min(page.isPortrait
                                                 ? parent.height / 4 - Theme.paddingSmall
                                                 : (parent.width / 7 - Theme.paddingSmall) / 2
                                                 , Theme.itemSizeExtraSmall)
                    anchors.centerIn: parent
                    width: page.isPortrait
                    ? size * 4 + Theme.paddingSmall
                    : hand.count * 2 * size + (hand.count - 1) * Theme.paddingSmall
                    height: page.isPortrait
                    ? Math.ceil(hand.count / 2) * size + (Math.ceil(hand.count / 2) - 1) * Theme.paddingSmall
                    : size
                    spacing: Theme.paddingSmall
                    Repeater {
                        model: hand
                        delegate: Tile {
                            size: handFlow.size
                            leftId: model.left
                            rightId: model.right
                        }
                    }
                }
            }
        }
    }
}
