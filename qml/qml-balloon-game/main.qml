import QtQuick 1.1

Rectangle {
    id: screen
    width: 800
    height: 600

    color: "#00B2FF"

    function randomNumber(from, to) {
       return Math.floor(Math.random() * (to - from + 1) + from);
    }

    Timer {
        interval: 2000
        repeat: true
        running: true

        onTriggered: {
            var component = Qt.createComponent("Balloon.qml");
            var balloon = component.createObject(screen);
            balloon.x = randomNumber(0, 500);
            balloon.y = -100;
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }
}
