/*
 * MissingIndicator.qml
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

Flow {
    id: root

    property alias model: repeater.model
    property real size

    property bool _isPortrait: width < height

    Repeater {
        id: repeater
        delegate: Row {
            height: digit.height

            Side {
                id: digit
                width: root.size
                value: model.index
            }
            Label {
                id: label
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: (root._isPortrait ? root.width : root.width / 7) - digit.width - 1
                height: root.size
                text: (modelData * 100.).toFixed(1) + "%"
                Rectangle {
                    width: parent.width * modelData
                    anchors.bottom: parent.bottom
                    color: Theme.highlightColor
                    height: Theme.paddingSmall
                    opacity: 0.5
                }
            }
        }
    }
}
