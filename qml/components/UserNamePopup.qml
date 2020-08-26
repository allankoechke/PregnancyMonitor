import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../components"

Popup {
    width: 150
    height: 211

    background: Image {
        source: isDarkTheme? "qrc:/assets/images/user-popup-dark.png":"qrc:/assets/images/user-popup-light.png"

        ColumnLayout
        {
            anchors.fill: parent
            anchors.topMargin: 20
            spacing: 3

            MenuButton
            {
                Layout.preferredHeight: 30
                menuLabel: "My Profile"
                menuIcon: "\uf406"

                onClicked: {
                    mainApp.previousStackIndex = 3
                    mainApp.mainStackLayout.currentIndex = 2
                    close()
                }
            }

            Rectangle
            {
                Layout.fillWidth: true; Layout.preferredHeight: 1; color: "grey"; opacity: 0.5
            }

            MenuButton
            {
                Layout.preferredHeight: 30
                menuLabel: "Edit Profile"
                menuIcon: "\uf4ff"

                onClicked: {
                    mainApp.previousStackIndex=3
                    mainApp.mainStackLayout.currentIndex=1
                    close()
                }
            }

            Rectangle
            {
                Layout.fillWidth: true; Layout.preferredHeight: 1; color: "grey"; opacity: 0.5
            }

            MenuButton
            {
                Layout.preferredHeight: 30
                menuLabel: "Sign Out"
                menuIcon: "\uf2f5"

                onClicked: {
                    logoutDelayTimer.start()
                    logoutPopup.open()
                    close()
                }
            }

            Rectangle
            {
                Layout.fillWidth: true; Layout.preferredHeight: 2; color: "grey"; opacity: 0.5
            }

            Rectangle
            {
                visible: false
                Layout.fillWidth: true; Layout.preferredHeight: 1; color: "grey"; opacity: 0.5
            }

            MenuButton
            {
                Layout.preferredHeight: 30
                menuLabel: "Power Off"
                menuIcon: "\uf011"

                onClicked: {
                }
            }
        }
    }
}
