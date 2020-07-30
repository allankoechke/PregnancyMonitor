import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item{
    Layout.fillWidth: true; Layout.preferredHeight: 40
    id: parent1

    property bool isPasswordField: false
    property string inputfieldLabel: ""
    property string inputFieldHintText: ""
    property alias nameField: nameField
    property alias nameRect: nameRect
    property alias inputLabel: inputLabel

    RowLayout
    {
        anchors.fill: parent
        anchors.margins: 10; spacing: 10

        Label
        {
            id: inputLabel
            Layout.fillHeight: true
            Layout.preferredWidth: parent1.width/2-30
            verticalAlignment: Text.AlignVCenter
            text: inputfieldLabel
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
            font.pixelSize: 20
            textFormat: Text.StyledText
        }

        TextField
        {
            id: nameField
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            echoMode: isPasswordField? TextField.Password:TextField.Normal

            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
            font.pixelSize: 18
            placeholderText: inputFieldHintText

            background: Rectangle{
                id: nameRect
                width: parent.width; height: parent.height
                color: isDarkTheme? darkThemeBgColor:lightThemeBgColor
                border{
                    color: isDarkTheme? darkThemeForeColor:"grey"
                    width: 1;
                }
                radius: 5
            }

        }
    }
}
