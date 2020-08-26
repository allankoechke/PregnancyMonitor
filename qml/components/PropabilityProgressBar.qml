import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../components"

Item {
    width: 90
    height: 130

    ColumnLayout
    {
        RoundProgressbar {
            id: progress
            Layout.alignment: Qt.AlignTop|Qt.AlignHCenter
            size: 100
            colorCircle: "#0092CC"
            colorBackground: "red" //"#E6E6E6"
            arcBegin: 0
            arcEnd: 45
            lineWidth: 10

            Text {
                anchors.centerIn: parent
                text: Math.floor((progress.arcEnd/360)*100).toString()+"%"
                font.bold: true
                font.pixelSize: 20
                color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
            }
        }

        Text {
            Layout.alignment: Qt.AlignTop|Qt.AlignHCenter
            text: qsTr("Miscarry")
            font.bold: true
            font.pixelSize: 20
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }
    }
}
