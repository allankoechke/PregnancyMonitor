import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

import "../components"

Item {
    id: root

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

        VitalWidget
        {
            Layout.topMargin: 10
            vitalValue: 75
            vitalLabel: qsTr("Heartbeat")
            vitalIcon: "\uf21e"
            vitalUnits: qsTr(" bpm")
        }

        VitalWidget
        {
            vitalValue: 37.2
            vitalLabel: qsTr("Temperature")
            vitalIcon: "\uf76b"
            vitalUnits: " <sup>*</sup>C"
        }

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
                arcEnd: 320
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

        Rectangle
        {
            Layout.preferredHeight: 30
            Layout.topMargin: 5; Layout.bottomMargin: 5
            Layout.fillWidth: true; radius: height/2
            color: "#19799F"// :"#E08A7B"

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
