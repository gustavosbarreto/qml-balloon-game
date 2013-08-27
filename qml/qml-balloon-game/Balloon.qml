import QtQuick 1.1

Item {
    id: balloon

    Image {
        source: "qrc:/images/Balloon.png"
    }

    Timer {
        interval: 50
        running: true
        repeat: true

        onTriggered: {
            balloon.y += 5;
        }
    }
}
