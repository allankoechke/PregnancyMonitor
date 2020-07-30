import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

import "../components"

Item{
    Layout.fillWidth: true; Layout.preferredHeight: 40
    id: root

    property string optionLabel
    property alias optionValue: control

    RowLayout
    {
        anchors.fill: parent
        anchors.margins: 10; spacing: 10

        Label
        {
            Layout.fillHeight: true
            Layout.preferredWidth: root.width/2-30
            verticalAlignment: Text.AlignVCenter
            text: optionLabel+"<sup><font color:\"red\">*</font></sup>"
            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
            font.pixelSize: 20
            textFormat: Text.StyledText
        }

        SpinBox
        {
            id: control
            Layout.preferredHeight: 35
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            editable: false
            font.pixelSize: 20
            font.bold: true
            value: 30
            from: 0; to: 120

            background: Rectangle{
                width: parent.width; height: parent.height
                color: isDarkTheme? darkThemeBgColor:lightThemeBgColor
                border{
                    color: isDarkTheme? darkThemeForeColor:"grey"
                    width: 1;
                }
                radius: 5
            }

            contentItem: TextInput {
                z: 2
                text: control.textFromValue(control.value, control.locale)
                font: control.font
                color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                selectionColor: "#21be2b"
                selectedTextColor: "#ffffff"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                readOnly: !control.editable
                validator: control.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

        }
    }
}
