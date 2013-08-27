import QtQuick 1.1

Rectangle {
    width: 360
    height: 360
    Text {
        text: "QML Ballon Game"
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }
}
