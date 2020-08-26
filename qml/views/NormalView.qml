import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../components"

Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 3

        GraphsView
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Rectangle
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: isDarkTheme? "grey":"#53d0ec"
        }

        AnalysisView
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 0.45*root.height
        }
    }
}
