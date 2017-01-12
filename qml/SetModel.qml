/*
 * SetModel.qml
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

ListModel {
    id: set
    property var distribution: [0, 0, 0, 0, 0, 0, 0]
    signal changed()
    onCountChanged: {
        if (!count) return

        var last = set.get(count - 1)
        distribution[last.left] += 1
        if (last.left != last.right) {
            distribution[last.right] += 1
        }
        changed()
    }
    Component.onCompleted: {
        if (!count) return

        for (var i = 0; i < count; i++) {
            var last = set.get(i)
            distribution[last.left] += 1
            if (last.left != last.right) {
                distribution[last.right] += 1
            }
        }
        changed()
    }
}
