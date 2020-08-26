import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../components"
import "../js/script.js" as JsScript

Item {
    id: root

    RowLayout
    {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 10

        Item
        {
            Layout.fillHeight: true
            Layout.preferredWidth: (userName.width + 50 < 120)? 120: userName.width+50

            Text {
                id: userName
                text: currentUser
                anchors.leftMargin: 15; anchors.left: parent.left
                font.pixelSize: 15; anchors.verticalCenter: parent.verticalCenter
                color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
            }

            AppIcon
            {
                icon: "\uf078"
                size: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right; anchors.rightMargin: 10
                color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
            }

            Rectangle
            {
                width: parent.width; height: 1; color: "grey"; opacity: 0.5
                anchors.bottom: parent.bottom; anchors.bottomMargin: 5
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: userNamePopup.open()
            }
        }

        Item
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Rectangle
        {
            id: startStopMeasuring
            Layout.fillHeight: true; Layout.rightMargin: 10
            Layout.topMargin: 5; Layout.bottomMargin: 5
            Layout.preferredWidth: 170; radius: height/2
            color: "#19799F"

            RowLayout
            {
                anchors.fill: parent
                anchors.leftMargin: 10; anchors.rightMargin: 10

                Text {
                    text: QmlInterface.isMeasuring? qsTr("Stop Measuring"):qsTr("Start Measuring")
                    Layout.leftMargin: 10; Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                    font.pixelSize: 15;
                    color: darkThemeForeColor
                }

                AppIcon
                {
                    icon: QmlInterface.isMeasuring? "\uf04d":"\uf04b"
                    size: 15
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                    Layout.rightMargin: 10
                    color: darkThemeForeColor
                }
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: QmlInterface.isMeasuring = !QmlInterface.isMeasuring
            }
        }

        Rectangle
        {
            id: clinicTimetable
            visible: !isClinicCalendarOpened
            Layout.fillHeight: true; Layout.rightMargin: 10
            Layout.topMargin: 5; Layout.bottomMargin: 5
            Layout.preferredWidth: 170; radius: height/2
            color: "#19799F"

            RowLayout
            {
                anchors.fill: parent
                anchors.leftMargin: 10; anchors.rightMargin: 10

                Text {
                    text: qsTr("Clinic Schedule")
                    Layout.leftMargin: 10; Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                    font.pixelSize: 15;
                    color: darkThemeForeColor
                }

                AppIcon
                {
                    icon: "\uf133"
                    size: 15
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                    Layout.rightMargin: 10
                    color: darkThemeForeColor
                }
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: clinicCalendar.open()
            }
        }

        Rectangle
        {
            id: settingsBtn
            Layout.fillHeight: true
            Layout.topMargin: 5; Layout.bottomMargin: 5
            Layout.preferredWidth: 150; radius: height/2
            color: "#19799F"

            RowLayout
            {
                anchors.fill: parent
                anchors.leftMargin: 10; anchors.rightMargin: 10

                Text {
                    text: qsTr("Settings")
                    Layout.leftMargin: 10; Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                    font.pixelSize: 15;
                    color: darkThemeForeColor
                }

                AppIcon
                {
                    icon: "\uf013"
                    size: 15
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                    Layout.rightMargin: 10
                    color: darkThemeForeColor
                }
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: mainApp.openSettingsDrawer()
            }
        }
    }
}
