import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4 as Controls2

import "../components"

Item {
    id: root

    Layout.fillWidth: true
    Layout.rightMargin: 30
    Layout.leftMargin: 30
    Layout.preferredHeight: 40

    property bool isActive: false
    property int activeIndex: 0
    property int prevIndex: 0

    property string analysisLabel: ""


    RotationAnimation
    {
        target: _icon
        running: isActive && activeIndex === 1
        duration: 1500
        from: 0; to: 360;
        loops: RotationAnimation.Infinite

        onStopped: _icon.rotation=0;
    }

    RowLayout
    {
        anchors.fill: parent
        spacing: 20

        Item
        {
            Layout.fillHeight: true
            Layout.preferredWidth: height

            AppIcon
            {
                id: _icon
                size: 18
                color: activeIndex===2 && isActive? "green":"white"
                icon: !isActive? "\uf128":activeIndex===0? "\uf017":activeIndex===1? "\uf110":"\uf058"

                anchors.centerIn: parent
            }
        }

        Text
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft

            text: analysisLabel
            color: "white"
            font.pixelSize: 18
        }
    }
}
