import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import "../components"

Rectangle {
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: isDarkTheme? darkThemeBgColor:lightThemeBgColor

    property var errorArray: []

    onErrorArrayChanged: {
        if(errorArray===[])
        {
            errorLabel.visible=false
        }
        else
        {
            errorLabel.visible=true
            errorLabel.inputfieldLabel=errorArray[0]===undefined? "":errorArray[0]
        }
    }

    function clearFields()
    {
        nameInputField.nameField.text = ""
        userNameInputField.nameField.text = ""
        passwordInputField.nameField.text = ""
        confirmPasswordInputField.nameField.text = ""
    }

    RowLayout
    {
        anchors.fill: parent
        anchors.margins: 20

        Item{
            Layout.preferredWidth: 200
            Layout.fillHeight: true

            Rectangle {
                id: ico
                height: 200; width: height
                anchors.top: parent.top; radius: height/2
                color: isDarkTheme? Qt.lighter(darkThemeBgColor):"#535353"

                AppIcon
                {
                    size: parent.height*0.6
                    anchors.centerIn: parent
                    color: "white"
                    icon: "\uf007"
                }
            }

            Rectangle {
                id: listViewHeader
                anchors.topMargin: 5
                anchors.top: ico.bottom
                width: listView.width; height: 20
                color: isDarkTheme? Qt.lighter(darkThemeBgColor):"grey"
                radius: 3

                Text{
                    anchors.centerIn: parent
                    font.bold: true
                    text: qsTr("Chronic Diseases")
                    color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                }
            }

            ListView
            {
                id: listView
                anchors.top: listViewHeader.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.topMargin: 4
                clip: true

                model: ["Alzheimer disease", "Arthritis", "Asthma", "Cancer","COPD","Crohn disease", "Cystic fibrosis", "Diabetes", "Epilepsy", "Heart disease", "HIV/AIDS", "Mood disorders","Multiple sclerosis","Parkinson disease"]
                delegate: Text{
                    font.pixelSize: 14
                    color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                    height: 30; verticalAlignment: Text.AlignVCenter
                    text: (index+1).toString()+". " + modelData
                }

            }
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true

            ScrollView
            {
                anchors.fill: parent
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                ColumnLayout
                {
                    anchors.fill: parent
                    anchors.rightMargin: 5
                    spacing: 10

                    InputPanel
                    {
                        id: nameInputField
                        isPasswordField: false
                        inputfieldLabel: qsTr("Full Name")+"<sup><font color:\"red\">*</font></sup>"
                        inputFieldHintText: qsTr("Enter full name here")
                        nameField.text: mainApp.previousStackIndex===3? currentUser:""
                    }

                    CustomComboBox
                    {
                        optionLabel: "Age"
                        optionValue{
                            id: ageValue
                            value: mainApp.previousStackIndex===3? currentUserAge:30
                            from: 0; to: 150; stepSize: 1
                        }
                    }

                    CustomComboBox
                    {
                        optionLabel: "Weight"
                        optionValue{
                            id: weightValue
                            value: mainApp.previousStackIndex===3? currentUserWeight:75
                            from: 0; to: 300; stepSize: 1
                        }
                    }

                    CustomComboBox
                    {
                        optionLabel: "Pregnancy Count"
                        optionValue{
                            id: pregnancyCountValue
                            value: mainApp.previousStackIndex===3? currentUserPregnancyCount:1
                            from: 0; to: 40; stepSize: 1
                        }
                    }

                    CustomComboBox
                    {
                        optionLabel: "Gestation Period"
                        optionValue{
                            id: gestationPeriodValue
                            value: mainApp.previousStackIndex===3? currentUserGestationPeriod:5
                            from: 0; to: 10; stepSize: 1
                        }
                    }

                    Item{
                        Layout.fillWidth: true; Layout.preferredHeight: 40

                        RowLayout{
                            anchors.fill: parent
                            anchors.leftMargin: 10

                            Label
                            {
                                text: qsTr("Any history of chronic diseases?")+"<sup>*</sup>"
                                color: isDarkTheme? darkThemeForeColor:lightThemeForeColor
                                font.pixelSize: 20
                                textFormat: Text.StyledText
                            }

                            CustomRadioButton
                            {
                                id: chronicRadio
                                text: qsTr("Yes")
                                checked: mainApp.previousStackIndex===3? currentUserChronicDiseases==="1":false
                            }

                            CustomRadioButton
                            {
                                text: qsTr("No")
                                checked: mainApp.previousStackIndex===3? currentUserChronicDiseases==="0":true

                            }
                        }
                    }

                    InputPanel
                    {
                        id: userNameInputField
                        isPasswordField: false
                        inputfieldLabel: qsTr("Select a username")+"<sup><font color:\"red\">*</font></sup>"
                        inputFieldHintText: qsTr("Enter username here")
                        nameField.text: mainApp.previousStackIndex===3? currentUserName:""
                    }

                    InputPanel
                    {
                        id: passwordInputField
                        visible: mainApp.previousStackIndex!==3
                        isPasswordField: true
                        inputfieldLabel: qsTr("Select Password")+"<sup><font color:\"red\">*</font></sup>"
                        inputFieldHintText: qsTr("Should be atleast 5 letters")
                    }

                    InputPanel
                    {
                        id: confirmPasswordInputField
                        isPasswordField: true
                        visible: mainApp.previousStackIndex!==3
                        nameField.enabled: passwordInputField.nameField.text.length>4
                        inputfieldLabel: qsTr("Confirm Password")+"<sup><font color:\"red\">*</font></sup>"
                        inputFieldHintText: qsTr("Confirm the password")
                    }

                    InputPanel
                    {
                        id: errorLabel
                        inputfieldLabel: ""
                        nameField.visible: false
                        Layout.preferredHeight: 20
                        inputLabel{
                            color: "red"
                            font.pixelSize: 18
                        }
                    }

                    Item{
                        id: buttonsFrame
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        Layout.topMargin: 10

                        Rectangle
                        {
                            id: cancelUser
                            height: 40; anchors.right: saveUser.left; anchors.rightMargin: 30
                            anchors.verticalCenter: parent.verticalCenter
                            width: 150; radius: height/2
                            color: "magenta"

                            RowLayout
                            {
                                anchors.fill: parent
                                anchors.leftMargin: 10; anchors.rightMargin: 10

                                Text {
                                    text: qsTr("Cancel")
                                    Layout.leftMargin: 10; Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                                    font.pixelSize: 15;
                                    color: darkThemeForeColor
                                }

                                AppIcon
                                {
                                    icon: "\uf057"
                                    size: 15
                                    Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                                    Layout.rightMargin: 10
                                    color: darkThemeForeColor
                                }
                            }

                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked: mainApp.mainStackLayout.currentIndex = previousStackIndex
                            }
                        }

                        Rectangle
                        {
                            id: saveUser
                            height: 40; anchors.right: parent.right; anchors.rightMargin: 30
                            anchors.verticalCenter: parent.verticalCenter
                            width: 150; radius: height/2
                            color: "#19799F"



                            RowLayout
                            {
                                anchors.fill: parent
                                anchors.leftMargin: 10; anchors.rightMargin: 10

                                Text {
                                    text: qsTr("Save Profile")
                                    Layout.leftMargin: 10; Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                                    font.pixelSize: 15;
                                    color: darkThemeForeColor
                                }

                                AppIcon
                                {
                                    icon: "\uf058"
                                    size: 15
                                    Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
                                    Layout.rightMargin: 10
                                    color: darkThemeForeColor
                                }
                            }

                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked: {
                                    var name = nameInputField.nameField.text
                                    var age = ageValue.value
                                    var weight = weightValue.value
                                    var pregCount = pregnancyCountValue.value
                                    var gestValue = gestationPeriodValue.value
                                    var chronic = chronicRadio.checked
                                    var uname = userNameInputField.nameField.text
                                    var passW = passwordInputField.nameField.text
                                    var cPassW = confirmPasswordInputField.nameField.text

                                    // Clear error array
                                    var _errorArray=[]

                                    if(name.length < 5)
                                    {
                                        nameInputField.nameRect.border.color = "red"
                                        _errorArray.push(qsTr("Short Name Field"))
                                        errorArray = _errorArray
                                    }

                                    else
                                    {
                                        nameInputField.nameRect.border.color = isDarkTheme? darkThemeForeColor:"grey"
                                    }

                                    if(uname.length < 4)
                                    {
                                        userNameInputField.nameRect.border.color = "red"
                                        _errorArray.push(qsTr("Short Username Field"))
                                        errorArray = _errorArray
                                    }
                                    else{
                                        userNameInputField.nameRect.border.color = isDarkTheme? darkThemeForeColor:"grey"
                                    }

                                    if(mainApp.previousStackIndex!==3)
                                    {

                                        if(passW !== cPassW)
                                        {
                                            _errorArray.push(qsTr("Passwords do not match"))
                                            errorArray = _errorArray
                                            passwordInputField.nameRect.border.color = "red"
                                            confirmPasswordInputField.nameRect.border.color = "red"
                                        }

                                        else
                                        {
                                            passwordInputField.nameRect.border.color = isDarkTheme? darkThemeForeColor:"grey"
                                            confirmPasswordInputField.nameRect.border.color = isDarkTheme? darkThemeForeColor:"grey"

                                            if(passW.length < 5)
                                            {
                                                _errorArray.push(qsTr("Password is short"))
                                                errorArray = _errorArray
                                                passwordInputField.nameRect.border.color = "red"
                                            }

                                            else
                                            {
                                                passwordInputField.nameRect.border.color = isDarkTheme? darkThemeForeColor:"grey"
                                            }

                                            if(cPassW.length < 5)
                                            {
                                                _errorArray.push(qsTr("Password is short"))
                                                errorArray = _errorArray
                                                confirmPasswordInputField.nameRect.border.color = "red"
                                            }

                                            else
                                            {
                                                confirmPasswordInputField.nameRect.border.color = isDarkTheme? darkThemeForeColor:"grey"
                                            }
                                        }
                                    }

                                    if(_errorArray.length === 0)
                                    {
                                        console.log("Checking for user ", uname)

                                        var reply = mainApp.countUser(uname)

                                        if(mainApp.previousStackIndex===3)
                                        {
                                            if(currentUserName!==uname && reply)
                                            {
                                                _errorArray.push(qsTr("This username already taken"))

                                                errorArray = _errorArray
                                            }
                                            else
                                            {
                                                updateAccount(name, age, weight, pregCount, gestValue, chronic,uname)

                                                mainApp.mainStackLayout.currentIndex=mainApp.previousStackIndex
                                            }
                                        }

                                        else
                                        {
                                            if(reply)
                                            {
                                                _errorArray.push(qsTr("This username already exists"))

                                                errorArray = _errorArray
                                            }
                                            else
                                            {
                                                var state = mainApp.createAccount(name, age, weight, pregCount, gestValue, chronic,uname, passW)

                                                console.log(state)

                                                if(state)
                                                {
                                                    console.log("NewUserView: >> User saved successfully")

                                                    mainApp.mainStackLayout.currentIndex = previousStackIndex

                                                    clearFields()
                                                }
                                                else
                                                    console.log("NewUserView: >> Couldnt save user")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
