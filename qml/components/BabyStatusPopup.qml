import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../components"
import "../models"

Drawer {
    id: root
    height: mainApp.height; width: mainApp.width*0.8
    edge: Qt.RightEdge

    background: Rectangle
    {
        color: isDarkTheme? darkThemeBgColor:lightThemeBgColor

        Item
        {
            anchors.margins: 20
            anchors.fill: parent


            ColumnLayout
            {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: qsTr("Baby Health Status")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.pixelSize: 15; font.bold: true
                    color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                }

                Rectangle
                {
                    Layout.fillWidth: true; Layout.preferredHeight: 1; color: "grey"; opacity: 0.5
                }

                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Item{
                        id: mothernBaby_
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: mothernBaby.width+20
                        height: parent.height

                        Image
                        {
                            id: mothernBaby
                            width: 230; height: 270
                            anchors.centerIn: parent
                            source: isDarkTheme? "qrc:/assets/images/mother-baby-light.png":"qrc:/assets/images/mother-baby-dark.png"
                        }
                    }

                    GroupBox
                    {
                        anchors.right: parent.right
                        anchors.left: mothernBaby_.right
                        anchors.bottom: parent.bottom
                        anchors.top: parent.top



                        label: Label{
                            text: qsTr("Status propability")
                            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                            font.pixelSize: 20
                            font.bold: true
                        }

                        GridView{
                            anchors.fill: parent
                            flow: GridView.LeftToRight
                            model: 4 //PropabilityModel
                            cellWidth: 100; cellHeight: 140
                            delegate: Component{

                                PropabilityProgressBar
                                {

                                }
                            }
                        }
                    }
                }

                Item{
                    height: 50; Layout.fillWidth: true

                    RowLayout
                    {
                        anchors.fill: parent

                        Text{
                            Layout.fillWidth: true; Layout.fillHeight: true
                        }

                        Rectangle
                        {
                            height: 40; anchors.topMargin: 5; anchors.bottomMargin: 5
                            width: 100; radius: height/2
                            color: "#E08A7B"

                            RowLayout
                            {
                                anchors.fill: parent
                                anchors.leftMargin: 10; anchors.rightMargin: 10

                                AppIcon
                                {
                                    icon: "\uf05e"
                                    size: 15
                                    Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
                                    Layout.rightMargin: 10
                                    color: darkThemeForeColor
                                }

                                Text {
                                    text: qsTr("Close")
                                    Layout.alignment: Qt.AlignRight|Qt.AlignVCenter
                                    font.pixelSize: 15; Layout.rightMargin: 20
                                    color: darkThemeForeColor
                                }
                            }

                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked: {
                                    close()
                                }
                            }
                        }

                    }
                }
            }
        }
    }
}
