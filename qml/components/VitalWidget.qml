import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

import "../components"

GroupBox
{
    Layout.fillHeight: true
    Layout.fillWidth: true

    property real vitalValue
    property string vitalLabel: qsTr("Heartbeat")
    property string vitalIcon: "\uf21e"
    property string vitalUnits: qsTr("bpm")

    label: Label
    {
        text: vitalLabel
        font.pixelSize: 18; opacity: 0.8
        color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
    }

    RowLayout
    {
        anchors.fill: parent
        anchors.margins: 5

        AppIcon
        {
            icon: vitalIcon
            Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
            Layout.rightMargin: 10; size: 25
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Text {
            text: vitalValue.toString()
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 35; Layout.fillWidth: true
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Text {
            text: vitalUnits; opacity: 0.7
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            font.pixelSize: 20; textFormat: Text.StyledText
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }
    }
}
