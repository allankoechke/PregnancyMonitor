import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.11
import Qt.labs.settings 1.1
//import QtQuick.VirtualKeyboard 2.14 as Keyboard

import "./views"
import "./js/script.js" as JsScript

Window {
    id: mainApp
    visible: true
    width: 800
    height: 480
    title: qsTr("Pregnancy Monitor")

    // Aliases
    property alias fontAwesomeFontLoader: fontAwesomeFontLoader
    property alias mainStackLayout: mainStackLayout
    property alias applicationSettings: applicationSettings
    property alias ecgConnectionView: ecgConnectionView

    // Theme stuff
    property bool isDarkTheme: applicationSettings.isDarkTheme
    property string darkThemeBgColor: "#0A202E"
    property string lightThemeBgColor: "#F6F7FB"
    property string darkThemeForeColor: "#F2F2F2"
    property string lightThemeForeColor: "#022F44"

    // States
    property bool isSettingsOpen: false
    property bool isAllOK: true
    property int previousStackIndex: 0
    property bool accountCreatedSuccessfully: false
    property var currentLogedInUser: []

    // Current User
    property string currentUser: ""
    property string currentUserName: ""
    property int currentUserAge: 0
    property real currentUserWeight: 0
    property int currentUserPregnancyCount: 0
    property int currentUserGestationPeriod: 0
    property string currentUserChronicDiseases: ""

    // ------------------- JS ------------------------------------------------

    function getDb()
    {
        return LocalStorage.openDatabaseSync("PregnancyMonitorDB", "1.0", "Analyzer software", 1000000);
    }

    function initializeDb()
    {
        var db = getDb()

        db.transaction(function (tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS "User"("id"	INTEGER NOT NULL, "fullname" TEXT NOT NULL, "username"	TEXT NOT NULL, "password"	TEXT NOT NULL, "age"	INTEGER NOT NULL, "weight"	REAL NOT NULL, "preganancy_no"	INTEGER NOT NULL, "pregnancy_month"	INTEGER NOT NULL, "chronic_diseases"	TEXT DEFAULT "", "date_added"	TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))');
        });
    }

    Component.onCompleted: {
        initializeDb()
        QmlInterface.startSerialPort();
    }

    onCurrentUserNameChanged: applicationSettings.currentUser = currentUserName

    Component.onDestruction: {
        applicationSettings.isDarkTheme = isDarkTheme
        applicationSettings.currentUser = currentUserName
    }

    function createAccount(name, age, weight, pregCount, gestValue, chronic, uname, passw)
    {
        var db = getDb()

        var dt = Date()

        console.log(dt)

        var hashedPass = QmlInterface.hashPassword(passw)

        var chronic_ = chronic? "1":"0"

        console.log("Creating user ", uname)

        try{
            db.transaction(function (tx){

                tx.executeSql('INSERT INTO "User"("fullname","username","password","age","weight","preganancy_no","pregnancy_month","chronic_diseases","date_added") VALUES (?,?,?,?,?,?,?,?,?)',
                              [name, uname, hashedPass, age, weight, pregCount, gestValue, chronic_, dt]);
                accountCreatedSuccessfully = true
            });

        } catch (err) {
            console.log("main.qml- createAccount: ", err)

            accountCreatedSuccessfully = false
        }

        return accountCreatedSuccessfully
    }

    function updateAccount(name, age, weight, pregCount, gestValue, chronic, uname)
    {
        var db = getDb()

        var accountUpdatedSuccessfully = true

        var chronic_ = chronic? "1":"0"

        console.log("Updating user ", uname)

        try{
            db.transaction(function (tx){

                tx.executeSql('UPDATE "User" SET "fullname"=?, "username"=?, "age"=?, "weight"=?, "preganancy_no"=?, "pregnancy_month"=?, "chronic_diseases"=? WHERE "username"=?',
                              [name, uname, age, weight, pregCount, gestValue, chronic_, currentUserName]);

                console.log("main.qml: updateAccount: Successfull")

                var response = tx.executeSql('SELECT * FROM "User" WHERE "username" = ?', uname);

                if(response.rows.length > 0)
                {
                    currentLogedInUser[0] = response.rows[0].id
                    currentLogedInUser[1] = response.rows[0].fullname
                    currentLogedInUser[2] = response.rows[0].username
                    currentLogedInUser[3] = response.rows[0].weight
                    currentLogedInUser[4] = response.rows[0].preganancy_no
                    currentLogedInUser[5] = response.rows[0].pregnancy_month
                    currentLogedInUser[6] = response.rows[0].chronic_diseases
                    currentLogedInUser[7] = response.rows[0].date_added
                    currentLogedInUser[8] = response.rows[0].age

                    updateUserParameters()
                }

                accountUpdatedSuccessfully = true
            });

        } catch (err) {
            console.log("main.qml- updateAccount: ", err)

            accountUpdatedSuccessfully = false
        }

        return accountUpdatedSuccessfully
    }

    function login(username, password)
    {
        var db = getDb()

        var status = false

        var hashedPassword = QmlInterface.hashPassword(password)

        try{
            db.transaction(function (tx){

                var response = tx.executeSql('SELECT * FROM "User" WHERE "username" = ?', username);

                if(response.rows.length > 0)
                {
                    if(response.rows[0].password === hashedPassword)
                    {
                        currentLogedInUser[0] = response.rows[0].id
                        currentLogedInUser[1] = response.rows[0].fullname
                        currentLogedInUser[2] = response.rows[0].username
                        currentLogedInUser[3] = response.rows[0].weight
                        currentLogedInUser[4] = response.rows[0].preganancy_no
                        currentLogedInUser[5] = response.rows[0].pregnancy_month
                        currentLogedInUser[6] = response.rows[0].chronic_diseases
                        currentLogedInUser[7] = response.rows[0].date_added
                        currentLogedInUser[8] = response.rows[0].age

                        status = true

                        updateUserParameters()

                        console.log("main.qml: login: Success!")
                    }
                }

                else
                {
                    console.log("main.qml- login: No such user")
                    status = false
                }
            });

        } catch (err) {
            console.log("main.qml- login: ", err)

            status = false
        }

        return status
    }

    function countUser(username)
    {
        var db = getDb()

        var status = false

        try{
            db.transaction(function (tx){

                var response = tx.executeSql('SELECT username FROM "User" WHERE "username" = ?', username);

                if(response.rows.length > 0)
                {
                    status = true
                }
            });

        } catch (err) {
            console.log("main.qml- login: ", err)

            status = false
        }

        return status
    }


    function updateUserParameters()
    {
        if(currentLogedInUser.length>0)
        {
            currentUser = currentLogedInUser[1]
            currentUserName = currentLogedInUser[2]
            currentUserAge = currentLogedInUser[8]
            currentUserWeight = currentLogedInUser[3]
            currentUserPregnancyCount = currentLogedInUser[4]
            currentUserGestationPeriod = currentLogedInUser[5]
            currentUserChronicDiseases = currentLogedInUser[6]
            console.log("main.qml: currentUser: updated")
        }

        else
        {
            console.log("main.qml: currentUser: Empty")
        }
    }

    // ------------------- JS ------------------------------------------------


    StackLayout{
        id: mainStackLayout

        anchors.fill: parent
        currentIndex: 0

        LoginView
        {
            id: loginView
        }

        NewUserView
        {
            id: newUserView
        }

        UserView
        {
            id: userView
        }

        MainView
        {
            id: mainView
        }

        EcgConnectionView
        {
            id: ecgConnectionView
        }
    }
    FontLoader
    {
        id: fontAwesomeFontLoader
        source: "qrc:/assets/fonts/fontawesome.otf"
    }

    function openBabyDrawer()
    {
        mainView.babyStatusPopup.open()
    }

    function openSettingsDrawer()
    {
        mainView.settingsPopup.open()
    }

    /*Keyboard.InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }*/

    Settings
    {
        id: applicationSettings
        property bool isDarkTheme: true
        property string currentUser: ""
    }
}
