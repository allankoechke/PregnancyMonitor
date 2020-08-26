import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../components"
import "../models"

Drawer {
    id: root
    height: mainApp.height; width: mainApp.width*0.8
    edge: Qt.RightEdge

    property bool isAnalyzing: false
    property bool isFinishedAnalyzing: false

    function resetApp()
    {
        isAnalyzing = false;

        item1.isActive = false;
        item1.activeIndex = 0;

        item2.isActive = false;
        item2.activeIndex = 0;

        item3.isActive = false;
        item3.activeIndex = 0;

        item4.isActive = false;
        item4.activeIndex = 0;
    }

    RotationAnimation
    {
        target: _icon
        from: 0; to: 360
        duration: 2500
        running: isAnalyzing && !isFinishedAnalyzing
        loops: RotationAnimation.Infinite

        onStopped: _icon.rotation = 0;
    }

    Timer
    {
        id: stage1
        interval: 1000
        repeat: false
        running: false

        onTriggered: {
            item1.activeIndex = 2;
            item2.activeIndex = 1;
            stage2.running = true;
        }
    }

    Timer
    {
        id: stage2
        interval: 3000
        repeat: false
        running: false

        onTriggered: {
            item2.activeIndex = 2;
            item3.activeIndex = 1;
            stage3.running = true;
        }
    }

    Timer
    {
        id: stage3
        interval: 2000
        repeat: false
        running: false;

        onTriggered: {
            item3.activeIndex = 2;
            item4.activeIndex = 1;

            stage4.running = true;
        }
    }

    Timer
    {
        id: stage4
        interval: 2000
        repeat: false
        running: false

        onTriggered: {
            item4.activeIndex = 2;
            isFinishedAnalyzing = true;
        }
    }

    background: Rectangle
    {
        color: isDarkTheme? darkThemeBgColor:lightThemeBgColor

        Item
        {
            anchors.margins: 20
            anchors.fill: parent


            ColumnLayout
            {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: qsTr("Baby Health Status")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.pixelSize: 15; font.bold: true
                    color: isDarkTheme? darkThemeForeColor:"#555555"
                }

                Rectangle
                {
                    Layout.fillWidth: true; Layout.preferredHeight: 1; color: "grey"; opacity: 0.5
                }

                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Item{
                        id: mothernBaby_
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: mothernBaby.width+20
                        height: parent.height

                        Image
                        {
                            id: mothernBaby
                            width: 230; height: 270
                            anchors.centerIn: parent
                            source: isDarkTheme? "qrc:/assets/images/mother-baby-light.png":"qrc:/assets/images/mother-baby-dark.png"
                        }

                        Rectangle
                        {
                            id: analysisBtn
                            height: 40;
                            width: 150; radius: height/2
                            color: "green"

                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: -50
                            anchors.horizontalCenter: parent.horizontalCenter

                            RowLayout
                            {
                                anchors.fill: parent
                                anchors.leftMargin: 10; anchors.rightMargin: 10

                                AppIcon
                                {
                                    id: _icon
                                    icon: isAnalyzing && !isFinishedAnalyzing? "\uf3f4":"\uf04b"
                                    size: 15
                                    Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
                                    Layout.rightMargin: 10
                                    color: darkThemeForeColor
                                }

                                Text {
                                    text: isAnalyzing && !isFinishedAnalyzing? qsTr("Analyzing ..."):qsTr("Start Analysis")
                                    Layout.alignment: Qt.AlignRight|Qt.AlignVCenter
                                    font.pixelSize: 15; Layout.rightMargin: 20
                                    color: darkThemeForeColor
                                }
                            }

                            MouseArea
                            {
                                anchors.fill: parent

                                onClicked: {
                                    if(isFinishedAnalyzing)
                                    {
                                        resetApp();
                                    }

                                    if(!isAnalyzing)
                                    {
                                        isAnalyzing = true;
                                        stage1.running = true;

                                        item1.isActive = true
                                        item1.activeIndex = 1;

                                        item2.isActive = true
                                        item2.activeIndex = 0;

                                        item3.isActive = true
                                        item3.activeIndex = 0;

                                        item4.isActive = true
                                        item4.activeIndex = 0;
                                    }
                                }
                            }
                        }
                    }

                    GroupBox
                    {
                        anchors.right: parent.right
                        anchors.left: mothernBaby_.right
                        anchors.bottom: parent.bottom
                        anchors.top: parent.top



                        label: Label{
                            text: qsTr("Baby & Mother Health Analysis")
                            color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                            font.pixelSize: 20
                            font.bold: true
                        }

                        Item
                        {
                            anchors.fill: parent


                            ColumnLayout
                            {
                                anchors.fill: parent

                                AnalysisItem
                                {
                                    id: item1
                                    analysisLabel: qsTr("Preparing data ...")
                                }

                                AnalysisItem
                                {
                                    id: item2
                                    analysisLabel: qsTr("Analyzing the Heartbeats ...")
                                }

                                AnalysisItem
                                {
                                    id: item3
                                    analysisLabel: qsTr("Analyzing past history ...")
                                }

                                AnalysisItem
                                {
                                    id: item4
                                    analysisLabel: qsTr("Parsing data to model ...")
                                }

                                Item
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 40

                                    RowLayout
                                    {
                                        anchors.centerIn: parent

                                        Text {
                                            text: qsTr("Baby Status: ")
                                            color: !isDarkTheme? "#535353":"white"
                                        }

                                        Rectangle
                                        {
                                            color: "green"
                                            Layout.preferredHeight: 40
                                            Layout.preferredWidth: 60

                                            Text {
                                                text: item4.activeIndex===2? qsTr("OK"):qsTr("---")
                                                font.pixelSize: 30
                                                font.bold: true
                                                color: "white"

                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Item{
                    height: 50; Layout.fillWidth: true

                    RowLayout
                    {
                        anchors.fill: parent

                        Text{
                            Layout.fillWidth: true; Layout.fillHeight: true
                        }

                        Rectangle
                        {
                            height: 40; anchors.topMargin: 5; anchors.bottomMargin: 5
                            width: 100; radius: height/2
                            color: "#E08A7B"

                            RowLayout
                            {
                                anchors.fill: parent
                                anchors.leftMargin: 10; anchors.rightMargin: 10

                                AppIcon
                                {
                                    icon: "\uf05e"
                                    size: 15
                                    Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
                                    Layout.rightMargin: 10
                                    color: darkThemeForeColor
                                }

                                Text {
                                    text: qsTr("Close")
                                    Layout.alignment: Qt.AlignRight|Qt.AlignVCenter
                                    font.pixelSize: 15; Layout.rightMargin: 20
                                    color: darkThemeForeColor
                                }
                            }

                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked: {
                                    close();
                                    resetApp();
                                }
                            }
                        }

                    }
                }
            }
        }
    }
}
