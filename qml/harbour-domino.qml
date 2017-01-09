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

    Page {
        id: page

        ListModel {
            id: game
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
    }
}