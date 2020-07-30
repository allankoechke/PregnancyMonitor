import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../components"

Rectangle
{
    Layout.preferredHeight: 40
    Layout.fillWidth: true
    Layout.topMargin: 30
    radius: 4
    color: isDarkTheme? Qt.lighter(darkThemeBgColor):Qt.lighter("white")

    property bool themeIsToggled

    Component.onCompleted: isDarkTheme? themeIsToggled=true:themeIsToggled=false

    RowLayout
    {
        anchors.fill: parent
        spacing: 20

        AppIcon
        {
            icon: isDarkTheme? "\uf673":"\uf672"
            size: 15
            Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
            Layout.leftMargin: 30
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Text {
            text: qsTr("Set Dark Theme")
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            font.pixelSize: 15; Layout.fillWidth: true
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Item{
            Layout.fillHeight: true
            Layout.preferredWidth: 100

            AppIcon
            {
                icon: themeIsToggled? "\uf205":"\uf204"
                anchors.centerIn: parent; size: 35
                color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: themeIsToggled = !themeIsToggled
            }
        }
    }
}
