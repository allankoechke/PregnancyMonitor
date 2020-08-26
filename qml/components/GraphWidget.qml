import QtQuick 2.0
import QtCharts 2.3

Item
{
    id: root

    property alias xAxis: xAxis
    property alias yAxis: yAxis
    property alias lineSeries: lineSeries

    ChartView {
        id: chart
        anchors.fill: parent
        antialiasing: true
        legend.visible: false
        margins.bottom: 0
        margins.top: 0
        margins.right: 0
        margins.left: 0
        backgroundColor: isDarkTheme? darkThemeBgColor:lightThemeBgColor

        ValueAxis
        {
            id: xAxis
            labelsVisible: false
            min: 0; max: 6
            tickCount: 30
            gridVisible: false

        }

        ValueAxis
        {
            id: yAxis
            labelsVisible: false
            tickCount: 5
            gridLineColor: "grey"
            min: 0; max: 20

        }

        LineSeries {
            id: lineSeries
            width: 1
            axisX: xAxis; axisY: yAxis
            color: isDarkTheme? "orange":"#022F44"

        }
    }
}
