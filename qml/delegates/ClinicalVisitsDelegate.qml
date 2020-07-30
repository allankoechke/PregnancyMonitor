import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../components"

Item {
    //Layout.fillHeight: true
    //Layout.minimumWidth: 30

    property bool pending: true

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 0

        Item
        {
            id: topBar
            Layout.fillWidth: true; Layout.preferredHeight: 60

            RowLayout
            {
                anchors.fill: parent
                spacing: 0

                Rectangle
                {
                    Layout.preferredHeight: 0.8*topBar.height; Layout.preferredWidth: height
                    radius: height/2; color: isDarkTheme? "green":"maroon"
                    Layout.alignment: Qt.AlignVCenter

                    AppIcon
                    {
                        anchors.centerIn: parent; color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                        size: 20; icon: pending? "\uf110":"\uf00c"
                    }
                }

                Rectangle
                {
                    Layout.preferredHeight: 1; Layout.fillWidth: true; color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                    Layout.alignment: Qt.AlignVCenter
                }

                /*Rectangle
                {
                    Layout.preferredHeight: 0.6*topBar.height; Layout.preferredWidth: height
                    radius: height/2; color: isDarkTheme? "green":"maroon"
                    Layout.alignment: Qt.AlignVCenter
                }*/
            }
        }

        Rectangle
        {
            Layout.fillWidth: true; Layout.fillHeight: true; radius: 4; Layout.bottomMargin: 20
            color: isDarkTheme? Qt.lighter(darkThemeBgColor):Qt.lighter(lightThemeBgColor)
            Layout.leftMargin: 10; Layout.rightMargin: 10
        }
    }
}
