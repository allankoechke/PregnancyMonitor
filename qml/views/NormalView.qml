import QtQuick 2.0
import QtQuick.Layouts 1.3

import "../components"

Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    RowLayout
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
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            color: isDarkTheme? "grey":"#53d0ec"
        }

        AnalysisView
        {
            Layout.fillHeight: true
            Layout.preferredWidth: 0.25*root.width
        }
    }
}
