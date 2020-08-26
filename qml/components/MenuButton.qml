import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../components"

Item {
    id: root

    property string menuLabel: "Menu Item"
    property string menuIcon: "\uf80c"

    signal clicked()

    Layout.fillWidth: true

    RowLayout{
        anchors.fill: parent
        spacing: 5

        AppIcon
        {
            icon: menuIcon
            size: 15
            Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
            Layout.leftMargin: 10
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Text {
            text: menuLabel
            Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
            Layout.leftMargin: 3; font.pixelSize: 15
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Item
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
