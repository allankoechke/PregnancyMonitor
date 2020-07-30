import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../components"

Item {
    id: root

    Item
    {
        anchors.fill: parent

        ColumnLayout
        {
            anchors.margins: 5
            anchors.fill: parent
            spacing: 2

            GraphWidget
            {
                // RA probe
                Layout.fillWidth: true
                Layout.fillHeight: true

            }

            GraphWidget
            {
                // LA probe
                Layout.fillWidth: true
                Layout.fillHeight: true

            }

            GraphWidget
            {
                // RF probe
                Layout.fillWidth: true
                Layout.fillHeight: true

            }
        }
    }
}
