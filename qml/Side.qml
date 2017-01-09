/*
 * Side.qml
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
    property int id
    property int dotSize: width / 6
    property int margin: dotSize / 4

    height: width

    Rectangle {
        anchors.centerIn: parent
        width: parent.width - 2 * margin
        height: width
        color: Theme.highlightColor
        opacity: 0.33
    }

    Rectangle {
        width: dotSize
        height: width
        radius: width / 2
        color: Theme.highlightColor
        anchors.centerIn: parent
        visible: id == 1 || id == 3 || id == 5
    }
    Rectangle {
        width: dotSize
        height: width
        radius: width / 2
        color: Theme.highlightColor
        anchors.right: parent.right
        anchors.rightMargin: parent.width / 4 - width / 2
        anchors.top: parent.top
        anchors.topMargin: parent.height / 4 - width / 2
        visible: id == 2 || id == 3 || id == 4 || id == 5 || id == 6
    }
    Rectangle {
        width: dotSize
        height: width
        radius: width / 2
        color: Theme.highlightColor
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 4 - width / 2
        anchors.top: parent.top
        anchors.topMargin: parent.height / 4 - width / 2
        visible: id == 4 || id == 5 || id == 6
    }
    Rectangle {
        width: dotSize
        height: width
        radius: width / 2
        color: Theme.highlightColor
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 4 - width / 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 4 - width / 2
        visible: id == 2 || id == 3 || id == 4 || id == 5 || id == 6
    }
    Rectangle {
        width: dotSize
        height: width
        radius: width / 2
        color: Theme.highlightColor
        anchors.right: parent.right
        anchors.rightMargin: parent.width / 4 - width / 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 4 - width / 2
        visible: id == 4 || id == 5 || id == 6
    }
    Rectangle {
        width: dotSize
        height: width
        radius: width / 2
        color: Theme.highlightColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 4 - width / 2
        visible: id == 6
    }
    Rectangle {
        width: dotSize
        height: width
        radius: width / 2
        color: Theme.highlightColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height / 4 - width / 2
        visible: id == 6
    }
}