import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "../components"
import "../delegates"
import "../models"


Drawer {
    height: mainApp.height-55; width: mainApp.width

    property int scrollSpeed: 30
    property alias scrollView: scrollView

    contentItem: Rectangle
    {
        anchors.fill: parent
        color: isDarkTheme? mainApp.darkThemeBgColor:lightThemeBgColor

        ColumnLayout
        {
            anchors.fill: parent
            spacing: 5

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                RowLayout
                {
                    anchors.fill: parent
                    anchors.leftMargin: 20; anchors.rightMargin: 10

                    Text{
                        Layout.fillHeight: true; Layout.minimumWidth: 100
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("My Clinic Roadmap"); font.pixelSize: 20
                        color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                        font.bold: true
                    }

                    Item{
                        Layout.fillWidth: true; Layout.fillHeight: true
                    }

                    Item {
                        Layout.fillHeight: true; Layout.preferredWidth: height
                        Layout.alignment: Qt.AlignRight

                        AppIcon
                        {
                            anchors.centerIn: parent
                            size: 20; icon: "\uf00d"
                            color: isDarkTheme? mainApp.darkThemeForeColor:mainApp.lightThemeForeColor
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked: close()
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

                ColumnLayout
                {
                    anchors.fill: parent
                    anchors.margins: 20

                    Item{
                        Layout.fillWidth: true; Layout.preferredHeight: 60
                    }

                    ScrollView
                    {
                        id: scrollView
                        Layout.fillWidth: true; Layout.fillHeight: true; clip: true
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                        ListView
                        {
                            id: listView
                            anchors.fill: parent
                            orientation: Qt.Horizontal

                            model: 20
                            delegate: Component{
                                id: clinicalvisitDelegate

                                ClinicalVisitsDelegate
                                {
                                    width: 300; height: listView.height*0.8
                                }
                            }
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                        }
                    }
                }
            }
        }
    }
}
