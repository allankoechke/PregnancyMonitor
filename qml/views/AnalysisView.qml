import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

import "../components"

Item {
    id: root

    property int heartBeatValue: 0
    property var temperatureValue: 0
    property var healthPercentage: 0

    Timer
    {
        repeat: QmlInterface.isMeasuring
        interval: 3000
        running: QmlInterface.isMeasuring

        onTriggered: {
            if(QmlInterface.isMeasuring)
            {
                var rand = Math.floor(Math.random()*10)

                var h = [73, 74, 70, 74, 73, 76, 74, 70, 69, 74]
                var t = [36.4, 36.7, 37.2, 37.4, 36.5, 37.0, 37.1, 36.7, 37.5, 37.7]
                var s = [99, 100, 98, 98, 100, 98, 96, 97, 99, 100]

                heartBeatValue = h[rand];
                temperatureValue = t[rand]
                healthPercentage = s[rand]
            }
            else
            {
                heartBeatValue = 0;
                temperatureValue = 0;
                healthPercentage = 0;
            }
        }
    }

    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 10

        Text {
            text: qsTr("Vitals Monitored")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 15;
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Rectangle
        {
            Layout.fillWidth: true; Layout.preferredHeight: 1; color: "grey"; opacity: 0.5
        }

        Item
        {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout
            {
                anchors.fill: parent
                spacing: 20

                VitalWidget
                {
                    Layout.leftMargin: 10
                    vitalValue: heartBeatValue
                    vitalLabel: qsTr("Heartbeat")
                    vitalIcon: "\uf21e"
                    vitalUnits: qsTr(" bpm")
                }

                VitalWidget
                {
                    vitalValue: temperatureValue
                    vitalLabel: qsTr("Temperature")
                    vitalIcon: "\uf76b"
                    vitalUnits: " <sup>*</sup>C"
                }

                Item
                {
                    Layout.fillWidth: true
                    Layout.minimumWidth: 250
                    Layout.fillHeight: true

                    ColumnLayout
                    {
                        anchors.fill: parent
                        spacing: 5

                        Text {
                            id: titleX
                            text: qsTr("Baby Health Status")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pixelSize: 15; Layout.topMargin: 10
                            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                        }

                        Rectangle
                        {
                            Layout.preferredWidth: titleX.width + 50; Layout.preferredHeight: 1; color: "grey"; opacity: 0.5
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Item{
                            Layout.fillWidth: true;
                            Layout.fillHeight: true

                            RoundProgressbar {
                                id: progress
                                anchors.centerIn: parent
                                size: parent.width>parent.height? parent.height-10:parent.width-10
                                colorCircle: "#0092CC"
                                colorBackground: "#E6E6E6"
                                arcBegin: 0
                                arcEnd: (healthPercentage/100)*360
                                lineWidth: 10

                                Text {
                                    anchors.centerIn: parent
                                    text: Math.floor((progress.arcEnd/360)*100).toString()+"%"
                                    font.bold: true
                                    font.pixelSize: 20
                                    color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle
        {
            Layout.preferredHeight: 30
            Layout.topMargin: 5; Layout.bottomMargin: 5; Layout.rightMargin: 50
            Layout.preferredWidth: 250; radius: height/2
            color: "#19799F"// :"#E08A7B"
            Layout.alignment: Qt.AlignRight
            visible: QmlInterface.isMeasuring

            RowLayout
            {
                anchors.fill: parent
                anchors.leftMargin: 10; anchors.rightMargin: 10

                Text {
                    text: qsTr("View More ...")
                    Layout.leftMargin: 10; Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                    font.pixelSize: 15;
                    color: darkThemeForeColor
                }

                AppIcon
                {
                    icon: "\uf101"
                    size: 15
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                    Layout.rightMargin: 10
                    color: darkThemeForeColor
                }
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: mainApp.openBabyDrawer()
            }
        }


    }
}
