import QtQuick 2.0

ListModel {

    ListElement
    {
        _pending: false
        _week: 4
        _status: qsTr("First doctor's visit")
    }

    ListElement
    {
        _pending: false
        _week: 8
        _status: qsTr("Baby's development is okay")
    }

    ListElement
    {
        _pending: false
        _week: 13
        _status: qsTr("Both mother and baby are well")
    }

    ListElement
    {
        _pending: false
        _week: 17
        _status: qsTr("Found the chill will be a boy")
    }

    ListElement
    {
        _pending: true
        _week: 24
        _status: qsTr("Mother health progress checkup")
    }

    ListElement
    {
        _pending: true
        _week: 28
        _status: qsTr("Mother and Baby checkup")
    }

    ListElement
    {
        _pending: true
        _week: 34
        _status: qsTr("final pre-natal checkup")
    }

    ListElement
    {
        _pending: true
        _week: 36
        _status: qsTr("Giving Birth")
    }
}
