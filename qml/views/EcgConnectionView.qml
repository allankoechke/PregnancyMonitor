import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4

import "../components"

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: isDarkTheme? darkThemeBgColor:lightThemeBgColor

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 5

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            RowLayout
            {
                anchors.fill: parent
                anchors.leftMargin: 20; anchors.rightMargin: 10

                Text{
                    Layout.fillHeight: true; Layout.minimumWidth: 100
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("Setting up the machine"); font.pixelSize: 20
                    color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                    font.bold: true
                }

                Item{
                    Layout.fillWidth: true; Layout.fillHeight: true
                }

                Rectangle {
                    Layout.preferredHeight: 40; Layout.preferredWidth: 150
                    Layout.alignment: Qt.AlignRight|Qt.AlignVCenter; color: "#19799F"; radius: height/2

                    RowLayout
                    {
                        anchors.fill: parent
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10

                        Text{
                            text: previousStackIndex === 0? qsTr("Next"):qsTr("Back")
                            font.pixelSize: 18; font.bold: true
                            color: darkThemeForeColor
                            Layout.alignment: Qt.AlignVCenter
                        }

                        AppIcon
                        {
                            Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                            size: 20; icon: previousStackIndex===0? "\uf061":"\uf053"
                            color: isDarkTheme? mainApp.darkThemeForeColor:mainApp.lightThemeForeColor
                        }
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {
                            mainApp.mainStackLayout.currentIndex = 3
                        }
                    }
                }
            }
        }

        Rectangle
        {
            height: 1; Layout.fillWidth: true; color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true


            Image
            {
                height: parent.height
                width: height*(794/1123)
                source: "qrc:/assets/images/electrode-placement.png"
            }

            Text {
                id: name
                width: parent.width/2
                text: qsTr("Place the probes as shown on the image then click 'NEXT'")
                color: isDarkTheme? "white":"#535353"
                font.bold: true
                wrapMode: Text.WordWrap
                font.pixelSize: 18

                anchors.left: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50
            }
        }
    }
}
