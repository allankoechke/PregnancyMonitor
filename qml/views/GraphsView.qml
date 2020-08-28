import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../components"

Item {
    id: root

    function mapXAxisData(xValue)
    {
        return (xValue*6)/30
    }

    Connections
    {
        target: QmlInterface

        function onEmitPlotDataChanged()
        {
            var _data = QmlInterface.getChartData();

            ecgGraphWidget.lineSeries.clear()

            for(var i =0; i<_data.length; i++)
            {
                ecgGraphWidget.lineSeries.append(mapXAxisData(i), _data[i])
            }
        }

        function onEmitChartData(_x, _y)
        {
            ecgGraphWidget.lineSeries.append(_x, _y*100);

            console.log(_x + ":" + _y*100);
        }

        function onClearChart()
        {
            ecgGraphWidget.lineSeries.clear();
        }
    }

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
                id: ecgGraphWidget
                // RA probe
                Layout.fillWidth: true
                Layout.fillHeight: true

            }

            /*GraphWidget
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

            }*/
        }
    }
}
