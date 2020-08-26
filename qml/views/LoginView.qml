import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../components"

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: isDarkTheme? darkThemeBgColor:lightThemeBgColor

    function clearAllFields()
    {
        usernameEntry.text = ""
        passwordEntry.text = ""
    }

    RowLayout
    {
        anchors.fill: parent
        anchors.margins: 20

        Item{
            Layout.preferredWidth: 200
            Layout.fillHeight: true

            Rectangle {
                id: ico
                height: 200; width: height
                anchors.centerIn: parent; radius: height/2
                color: isDarkTheme? Qt.lighter(darkThemeBgColor):"#535353"

                AppIcon
                {
                    size: parent.height*0.6
                    anchors.centerIn: parent
                    color: "white"
                    icon: "\uf007"
                }
            }
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout
            {
                spacing: 10
                anchors.centerIn: parent
                width: parent.width*0.75; height: parent.height*0.75

                Item{
                    Layout.fillWidth: true; Layout.preferredHeight: 40
                    id: parent1

                    RowLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 10; spacing: 10

                        Label
                        {
                            Layout.fillHeight: true
                            Layout.preferredWidth: parent1.width/3
                            verticalAlignment: Text.AlignVCenter
                            text: qsTr("Username")
                            horizontalAlignment: Text.AlignRight
                            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                            font.pixelSize: 20
                            textFormat: Text.StyledText
                        }

                        TextField
                        {
                            id: usernameEntry
                            Layout.preferredHeight: 40
                            Layout.fillWidth: true

                            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                            font.pixelSize: 18; text: mainApp.applicationSettings.currentUser
                            placeholderText: qsTr("Enter username")

                            background: Rectangle{
                                id: usernameRect
                                width: parent.width; height: parent.height
                                color: isDarkTheme? darkThemeBgColor:lightThemeBgColor
                                border{
                                    color: isDarkTheme? darkThemeForeColor:"green"
                                    width: 1;
                                }
                                radius: 5
                            }
                        }
                    }
                }


                Item{
                    Layout.fillWidth: true; Layout.preferredHeight: 40
                    id: passwordInput

                    RowLayout
                    {
                        anchors.fill: parent
                        anchors.margins: 10; spacing: 10

                        Label
                        {
                            Layout.fillHeight: true
                            Layout.preferredWidth: parent1.width/3
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignRight
                            text: qsTr("Password")
                            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                            font.pixelSize: 20
                            textFormat: Text.StyledText
                        }

                        TextField
                        {
                            id: passwordEntry
                            Layout.preferredHeight: 40
                            Layout.fillWidth: true

                            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                            font.pixelSize: 18; echoMode: TextField.Password
                            placeholderText: qsTr("Enter password")

                            background: Rectangle{
                                id: passwordRect
                                width: parent.width; height: parent.height
                                color: isDarkTheme? darkThemeBgColor:lightThemeBgColor
                                border{ color: isDarkTheme? darkThemeForeColor:"green"; width: 1;}
                                radius: 5
                            }
                        }
                    }
                }

                Text
                {
                    id: errorText
                    color: "red"
                    font.pixelSize: 15
                    visible: false
                    Layout.minimumHeight: 20; Layout.minimumWidth: 100
                    Layout.alignment: Qt.AlignHCenter
                }

                Item{
                    id: buttonsFrame
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45

                    Rectangle
                    {
                        id: cancelUser
                        height: 40; anchors.right: saveUser.left; anchors.rightMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        width: 150; radius: height/2
                        color: "magenta"

                        RowLayout
                        {
                            anchors.fill: parent
                            anchors.leftMargin: 10; anchors.rightMargin: 10

                            Text {
                                text: qsTr("Sign up")
                                Layout.leftMargin: 10; Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                                font.pixelSize: 15;
                                color: darkThemeForeColor
                            }

                            AppIcon
                            {
                                icon: "\uf234"
                                size: 15
                                Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                                Layout.rightMargin: 10
                                color: darkThemeForeColor
                            }
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked: {
                                previousStackIndex = 0
                                mainApp.mainStackLayout.currentIndex = 1
                                clearAllFields()
                            }
                        }
                    }

                    Rectangle
                    {
                        id: saveUser
                        height: 40; anchors.right: parent.right; anchors.rightMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        width: 150; radius: height/2
                        color: "#19799F"



                        RowLayout
                        {
                            anchors.fill: parent
                            anchors.leftMargin: 10; anchors.rightMargin: 10

                            Text {
                                text: qsTr("Log in")
                                Layout.leftMargin: 10; Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                                font.pixelSize: 15;
                                color: darkThemeForeColor
                            }

                            AppIcon
                            {
                                icon: "\uf2f6"
                                size: 15
                                Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                                Layout.rightMargin: 10
                                color: darkThemeForeColor
                            }
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked: {

                                var username = usernameEntry.text
                                var password = passwordEntry.text

                                var usernameIsOkay = false
                                var passwordIsOkay = false

                                if(username.length < 4)
                                {
                                    usernameIsOkay = false
                                    errorText.visible = true
                                    errorText.text = qsTr("Short username given")
                                    usernameRect.border.color = "red"
                                } else {
                                    usernameIsOkay = true
                                    errorText.visible = false
                                    errorText.text = qsTr("")
                                    usernameRect.border.color = isDarkTheme? darkThemeForeColor:"grey"
                                }

                                if(password.length < 5)
                                {
                                    passwordIsOkay = false
                                    errorText.visible = true
                                    if(usernameIsOkay)
                                        errorText.text = qsTr("Short password given")
                                    passwordRect.border.color = "red"
                                } else {
                                    passwordIsOkay = true
                                    if(usernameIsOkay)
                                    {
                                        errorText.visible = false
                                        errorText.text = qsTr("")
                                    }
                                    passwordRect.border.color = isDarkTheme? darkThemeForeColor:"grey"
                                }

                                if(usernameIsOkay && passwordIsOkay)
                                {
                                    if(countUser(username))
                                    {
                                        if(mainApp.login(username, password))
                                        {

                                            errorText.visible = false
                                            errorText.text = qsTr("")
                                            previousStackIndex = 0
                                            mainApp.mainStackLayout.currentIndex = 4
                                            clearAllFields() // Clear input fields

                                        } else
                                        {
                                            errorText.visible = true
                                            errorText.text = qsTr("Wrong login credentials")
                                            console.log("LoginView: Failed Login")
                                        }
                                    }
                                    else
                                    {
                                        errorText.visible = true
                                        errorText.text = qsTr("User doesnt exits")
                                        console.log("LoginView: Failed Login")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
