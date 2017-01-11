/*
 * Tile.qml
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

Item {
    id: tile

    property int size: Theme.itemSizeSmall
    property alias leftId: left.value
    property alias rightId: right.value

    property bool _rotated: left.value == right.value

    width: _rotated ? size : 2 * size
    height: _rotated ? 2 * size : size

    Side {
        id: left
        width: size
        anchors.right: _rotated ? undefined : parent.horizontalCenter
        anchors.top: _rotated ? parent.verticalCenter : undefined
        rotation: _rotated ? 90 : 0
    }
    Side {
        id: right
        width: size
        anchors.left: _rotated ? undefined : parent.horizontalCenter
        anchors.bottom: _rotated ? parent.verticalCenter : undefined
        rotation: _rotated ? 90 : 0
    }
    Rectangle {
        anchors.centerIn: parent
        width: _rotated ? parent.width : left.margin + right.margin
        height: _rotated ? left.margin + right.margin : parent.height
        color: Theme.highlightColor
        opacity: 0.75
    }
    Rectangle {
        anchors.centerIn: parent
        width: 2 * (left.margin + right.margin)
        height: width
        radius: width / 2
        color: Theme.highlightColor
        opacity: 0.75
    }
}
