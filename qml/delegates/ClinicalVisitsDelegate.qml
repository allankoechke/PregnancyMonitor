import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../components"

Item {
    property bool pending: true
    property string status: ""
    property var week: 0

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 0

        Item
        {
            id: topBar
            Layout.fillWidth: true; Layout.preferredHeight: 60

            RowLayout
            {
                anchors.fill: parent
                spacing: 0

                Rectangle
                {
                    Layout.preferredHeight: 0.8*topBar.height; Layout.preferredWidth: height
                    radius: height/2; color: "green"
                    Layout.alignment: Qt.AlignVCenter

                    AppIcon
                    {
                        anchors.centerIn: parent; color: isDarkTheme? darkThemeForeColor:"white"
                        size: 20; icon: pending? "\uf110":"\uf00c"
                    }
                }

                Rectangle
                {
                    Layout.preferredHeight: 1; Layout.fillWidth: true; color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }

        Rectangle
        {
            Layout.fillWidth: true; Layout.fillHeight: true; radius: 4; Layout.bottomMargin: 20
            color: isDarkTheme? Qt.lighter(darkThemeBgColor):Qt.lighter(lightThemeBgColor)
            Layout.leftMargin: 10; Layout.rightMargin: 10

            ColumnLayout
            {
                anchors.fill: parent
                spacing: 5

                Rectangle
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    Layout.margins: 5

                    color: isDarkTheme? "grey":"#535353"
                    radius: 3

                    RowLayout
                    {
                        anchors.fill: parent
                        spacing: 10

                        Text
                        {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter

                            text: qsTr("Week: ")
                            font.pixelSize: 15
                            color: "white"
                        }

                        Text
                        {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter

                            text: week.toString()
                            font.bold: true
                            font.pixelSize: 15
                            color: isDarkTheme? "white":"white"
                        }
                    }
                }

                Rectangle
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 5

                    color: isDarkTheme? "grey":"#535353"
                    radius: 3

                    ColumnLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 5
                        spacing: 10

                        Text
                        {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 30
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            text: qsTr("Status: ")
                            font.pixelSize: 15
                            color: "white"
                        }

                        Text
                        {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter

                            text: status
                            font.bold: true
                            wrapMode: Text.WordWrap
                            font.pixelSize: 15
                            color: "white"
                        }
                    }
                }
            }
        }
    }
}
