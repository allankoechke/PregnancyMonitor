import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

import "../components"
import "../views"

Rectangle {
    id: root
    color: isDarkTheme? darkThemeBgColor:lightThemeBgColor
    Layout.fillWidth: true
    Layout.fillHeight: true

    // Aliases
    property alias userNamePopup: userNamePopup
    property alias babyStatusPopup: babyStatusPopup
    property alias settingsPopup: settingsPopup
    property alias logoutDelayTimer: logoutDelayTimer
    property alias clinicCalendar: clinicCalendar

    //State
    property bool isClinicCalendarOpened: false

    Timer
    {
        id: logoutDelayTimer
        repeat: false
        interval: 3000
        running: false

        onTriggered: {
            logoutPopup.close()
            mainApp.previousStackIndex=0
            mainStackLayout.currentIndex = 0
        }
    }

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 0

        TopNavBarView
        {
            // Top navigation bar
            Layout.fillWidth: true
            Layout.preferredHeight: 50
        }

        Rectangle
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: isDarkTheme? "grey":"#53d0ec"
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true

            NormalView
            {
                id: normalView
                anchors.fill: parent
            }

        }

        Rectangle
        {
            id: warningsanderrorspane
            visible: !isAllOK
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            color: isDarkTheme? darkThemeBgColor:lightThemeBgColor

            Rectangle
            {
                width: parent.width; height: 1
                color: isDarkTheme? "grey":"#53d0ec"
                anchors.top: parent.top
            }
        }
    }

    UserNamePopup
    {
        id: userNamePopup
        x: 3; y: 45
    }

    BabyStatusPopup
    {
        id: babyStatusPopup
    }

    SettingsPopup
    {
        id: settingsPopup
    }

    LogoutPopup
    {
        id: logoutPopup
        x: (mainApp.width-width)/2
        y: (mainApp.height-height)/2
    }

    ClinicCalendar
    {
        id: clinicCalendar
        edge: Qt.BottomEdge

        onOpened: isClinicCalendarOpened = true

        onClosed: isClinicCalendarOpened = false
    }
}
