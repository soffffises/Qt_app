import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: root
    visible: true
    width: 400
    height: 300
    title: qsTr("Temperature Converter")

    property string currentEditing: ""

    Dialog {
        id: errorDialog
        modal: true
        standardButtons: Dialog.Ok
        title: "Input Error"

        contentItem: Text {
            id: errorText
            text: ""
            wrapMode: Text.WordWrap
            width: parent.width * 0.9
            color: "red"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        onAccepted: {
            errorDialog.close()
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Label {
            text: "Convert Temperatures"
            font.pixelSize: 22
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            color: "#2c3e50"
        }

        // Celsius
        RowLayout {
            spacing: 10
            Layout.fillWidth: true

            Label {
                text: "Celsius"
                font.bold: true
                Layout.preferredWidth: 100
                color: "#34495e"
                verticalAlignment: Text.AlignVCenter
            }

            TextField {
                id: celsiusField
                Layout.preferredWidth: 220
                placeholderText: "Enter °C"
                font.pointSize: 12
                inputMethodHints: Qt.ImhPreferNumbers
                validator: DoubleValidator { bottom: -273.15 }
                color: "#2c3e50"

                onTextEdited: {
                    root.currentEditing = "C"
                    if (text === "" || text === "-") {

                        return;
                    }
                    var val = Number(text);
                    if (isNaN(val)) {
                        errorText.text = "Incorrect input: please enter a number."
                        errorDialog.open()
                        return;
                    }
                    if (val < -273.15) {
                        errorText.text = "The temperature in Celsius cannot be below absolute zero (-273.15°C)."
                        errorDialog.open()
                        return;
                    }
                    temperatureController.updateFromCelsius(text)
                }

                onEditingFinished: {
                    root.currentEditing = ""
                }

                background: Rectangle {
                    color: "white"
                    radius: 6
                    border.color: "#bdc3c7"
                    border.width: 1
                }
                padding: 6
            }
        }

        // Fahrenheit
        RowLayout {
            spacing: 10
            Layout.fillWidth: true

            Label {
                text: "Fahrenheit"
                font.bold: true
                Layout.preferredWidth: 100
                color: "#34495e"
                verticalAlignment: Text.AlignVCenter
            }

            TextField {
                id: fahrenheitField
                Layout.preferredWidth: 220
                placeholderText: "Enter °F"
                font.pointSize: 12
                inputMethodHints: Qt.ImhPreferNumbers
                validator: DoubleValidator { bottom: -459.67 }
                color: "#2c3e50"

                onTextEdited: {
                    root.currentEditing = "F"
                    if (text === "" || text === "-") {
                        return;
                    }
                    var val = Number(text);
                    if (isNaN(val)) {
                        errorText.text = "Incorrect input: please enter a number."
                        errorDialog.open()
                        return;
                    }
                    if (val < -459.67) {
                        errorText.text = "The temperature in Fahrenheit cannot be lower than absolute zero (-459.67°F)."
                        errorDialog.open()
                        return;
                    }
                    temperatureController.updateFromFahrenheit(text)
                }

                onEditingFinished: {
                    root.currentEditing = ""
                }

                background: Rectangle {
                    color: "white"
                    radius: 6
                    border.color: "#bdc3c7"
                    border.width: 1
                }
                padding: 6
            }
        }

        // Kelvin
        RowLayout {
            spacing: 10
            Layout.fillWidth: true

            Label {
                text: "Kelvin"
                font.bold: true
                Layout.preferredWidth: 100
                color: "#34495e"
                verticalAlignment: Text.AlignVCenter
            }

            TextField {
                id: kelvinField
                Layout.preferredWidth: 220
                placeholderText: "Enter K"
                font.pointSize: 12
                inputMethodHints: Qt.ImhPreferNumbers
                validator: DoubleValidator { bottom: 0.0 }
                color: "#2c3e50"

                onTextEdited: {
                    root.currentEditing = "K"
                    if (text === "") {
                        return;
                    }
                    if (text === "-") {

                        errorText.text = "Temperature in Kelvin cannot be negative."
                        errorDialog.open()
                        return;
                    }
                    var val = Number(text);
                    if (isNaN(val)) {
                        errorText.text = "Incorrect input: please enter a number."
                        errorDialog.open()
                        return;
                    }
                    if (val < 0) {
                        errorText.text = "Temperature in Kelvin cannot be negative."
                        errorDialog.open()
                        return;
                    }
                    temperatureController.updateFromKelvin(text)
                }


                onEditingFinished: {
                    root.currentEditing = ""
                }

                background: Rectangle {
                    color: "white"
                    radius: 6
                    border.color: "#bdc3c7"
                    border.width: 1
                }
                padding: 6
            }
        }

        Button {
            text: "Reset"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                celsiusField.text = ""
                fahrenheitField.text = ""
                kelvinField.text = ""
                root.currentEditing = ""
            }
        }
    }

    Connections {
        target: temperatureModel

        function onTemperatureChanged() {
            const minC = -273.15;
            const minF = -459.67;
            const minK = 0.0;

            if (root.currentEditing !== "C") {
                let valC = temperatureModel.celsius;
                if (valC < minC) valC = minC;
                celsiusField.text = valC.toFixed(2);
            }
            if (root.currentEditing !== "F") {
                let valF = temperatureModel.fahrenheit;
                if (valF < minF) valF = minF;
                fahrenheitField.text = valF.toFixed(2);
            }
            if (root.currentEditing !== "K") {
                let valK = temperatureModel.kelvin;
                if (valK < minK) valK = minK;
                kelvinField.text = valK.toFixed(2);
            }
        }
    }

    Connections {
        target: temperatureController

        function onInvalidInput(message) {
            errorText.text = message
            errorDialog.open()
        }
    }

    Component.onCompleted: {
        temperatureController.updateFromCelsius("0")
    }
}
