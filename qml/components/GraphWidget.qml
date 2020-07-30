import QtQuick 2.0
import QtCharts 2.3

Item
{
    id: root

    ChartView {
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
            tickCount: 20
            gridVisible: false
        }

        ValueAxis
        {
            id: yAxis
            labelsVisible: false
            tickCount: 10
            gridLineColor: "grey"

        }

        LineSeries {
            width: 1
            axisX: xAxis; axisY: yAxis
            color: isDarkTheme? "orange":"#022F44"


            XYPoint { x: 0; y: 0 }
            XYPoint { x: 1; y: 2.1 }
            XYPoint { x: 2; y: 3.3 }
            XYPoint { x: 3; y: 2.1 }
            XYPoint { x: 4; y: 4.9 }
            XYPoint { x: 5; y: 3.0 }
            XYPoint { x: 6; y: 3.3 }
            XYPoint { x: 7; y: 3.3 }
            XYPoint { x: 8; y: 2.1 }
            XYPoint { x: 9; y: 4.9 }
            XYPoint { x: 10; y: 3.0 }
            XYPoint { x: 11; y: 3.3 }
            XYPoint { x: 12; y: 3.3 }
            XYPoint { x: 13; y: 3.3 }
            XYPoint { x: 14; y: 2.1 }
            XYPoint { x: 15; y: 4.9 }
            XYPoint { x: 16; y: 3.0 }
            XYPoint { x: 17; y: 3.3 }
        }
    }
}
