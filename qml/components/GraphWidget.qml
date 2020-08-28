import QtQuick 2.0
import QtCharts 2.3

Item
{
    id: root

    property alias xAxis: xAxis
    property alias yAxis: yAxis
    property alias lineSeries: lineSeries

    property var point_X: 0.0
    property var point_Y: 0.0

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
            min: 0; max: 20
            tickCount: 2000
            gridVisible: false

        }

        ValueAxis
        {
            id: yAxis
            labelsVisible: false
            tickCount: 5
            gridLineColor: "grey"
            min: -200; max: 200

        }

        LineSeries {
            id: lineSeries
            width: 1
            axisX: xAxis; axisY: yAxis
            color: isDarkTheme? "orange":"#022F44"

            XYPoint {
                x: point_X
                y: point_Y
            }
        }
    }
}
