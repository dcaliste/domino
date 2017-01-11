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

        ListModel {
            id: game
            property var distribution: [0, 0, 0, 0, 0, 0, 0]
            signal changed()
            onCountChanged: {
                if (!count) return

                var last = game.get(count - 1)
                distribution[last.left] += 1
                if (last.left != last.right) {
                    distribution[last.right] += 1
                }
                changed()
            }
            Component.onCompleted: {
                if (!count) return

                for (var i = 0; i < count; i++) {
                    var last = game.get(i)
                    distribution[last.left] += 1
                    if (last.left != last.right) {
                        distribution[last.right] += 1
                    }
                }
                changed()
            }
            ListElement {left: 5; right: 2}
            ListElement {left: 2; right: 6}
            ListElement {left: 6; right: 6}
            ListElement {left: 6; right: 0}
            ListElement {left: 0; right: 0}
            ListElement {left: 0; right: 3}
            ListElement {left: 3; right: 4}
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

        MissingIndicator {
            id: help
            property var proba: [0., 0., 0., 0., 0., 0., 0.]

            function update() {
                var proba = []
                for (var i = 0; i < 7; i++) {
                    proba.push(app.pMiss(i, 28, game.distribution, 4))
                }
                help.proba = proba
            }

            Connections {
                target: game
                onChanged: help.update()
            }

            model: proba
            size: page.isPortrait ? page.height / 21 : page.width / 21
            anchors.bottom: page.bottom
            anchors.right: page.right
            width: page.isPortrait ? size + Theme.itemSizeMedium : page.width
            height: page.isPortrait ? 7 * size : size
        }
    }
}
