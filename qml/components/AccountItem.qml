import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Item{
    Layout.fillWidth: true; Layout.preferredHeight: 40
    id: root

    property string optionLabel
    property string optionValue

    RowLayout
    {
        anchors.fill: parent
        anchors.leftMargin: 10; spacing: 10
        anchors.rightMargin: 10

        Label
        {
            Layout.fillHeight: true
            Layout.preferredWidth: root.width/2-30
            verticalAlignment: Text.AlignVCenter
            text: optionLabel; font.pixelSize: 20
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
        }

        Rectangle{
            Layout.fillWidth: true; Layout.fillHeight: true
            color: isDarkTheme? darkThemeBgColor:lightThemeBgColor
            border{ color: isDarkTheme? darkThemeForeColor:"grey"; width: 1;}
            radius: 5

            Text
            {
                text: optionValue.toString()
                font.pixelSize: 18
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
            }
        }
    }
}
