import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../components"

Rectangle {
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: isDarkTheme? darkThemeBgColor:lightThemeBgColor

    function clearAllFields()
    {

    }

    Item{
        id: buttonsFrame
        width: parent.width; height: 45

        Rectangle
        {
            id: backToNormalViewBtn
            height: 40; anchors.left: parent.left; anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 130; radius: height/2
            color: "#19799F"

            RowLayout
            {
                anchors.fill: parent
                anchors.rightMargin: 10

                Rectangle{
                    Layout.fillHeight: true
                    Layout.preferredWidth: height
                    radius: height/2; color: Qt.darker("#19799F")
                    Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter

                    AppIcon
                    {
                        icon: "\uf0a8"
                        size: 18
                        anchors.centerIn: parent
                        color: darkThemeForeColor
                    }
                }

                Text {
                    text: qsTr("Back")
                    Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                    font.pixelSize:18; font.bold: true
                    color: darkThemeForeColor
                }
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: mainApp.mainStackLayout.currentIndex=3
            }
        }
    }

    Rectangle
    {
        height: 1; width: parent.width; color: "grey"; opacity: 0.5
        anchors.top: buttonsFrame.bottom; anchors.topMargin: 5; anchors.left: parent.left
    }

    RowLayout
    {
        anchors.top: buttonsFrame.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 20

        Item{
            Layout.preferredWidth: 200
            Layout.fillHeight: true

            Rectangle {
                width: 200; height: width
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
                anchors.fill: parent
                spacing: 10

                AccountItem
                {
                    optionLabel: "Full Name"
                    optionValue: currentUser
                }

                AccountItem
                {
                    optionLabel: "Age"
                    optionValue: currentUserAge
                }

                AccountItem
                {
                    optionLabel: "Weight"
                    optionValue: currentUserWeight
                }

                AccountItem
                {
                    optionLabel: "Pregnancy Count"
                    optionValue: currentUserPregnancyCount
                }

                AccountItem
                {
                    optionLabel: "Gestation Period"
                    optionValue: currentUserGestationPeriod
                }

                Item{
                    Layout.fillWidth: true; Layout.preferredHeight: 40

                    RowLayout{
                        anchors.fill: parent
                        anchors.leftMargin: 10

                        Label
                        {
                            text: qsTr("Has history of a chronic diseases")
                            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                            font.pixelSize: 20
                            textFormat: Text.StyledText
                        }

                        CustomRadioButton
                        {
                            visible: currentUserChronicDiseases==="1"
                            text: qsTr("Yes")
                            checked: currentUserChronicDiseases==="1"
                        }

                        CustomRadioButton
                        {
                            text: qsTr("No")
                            checked: currentUserChronicDiseases==="0"
                            visible: currentUserChronicDiseases==="0"
                        }
                    }
                }
            }
        }
    }
}
