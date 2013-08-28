import QtQuick 1.1

Item {
    id: toolBarItem
    width: game.width
    height: 60

    Rectangle {
        color: Qt.rgba(0, 0, 0, 0.2)
        anchors.fill: parent
    }

    Component {
        id: dartComponent
        Image {
            source: 'qrc:/images/Dart.png'
            width: 46
            x: 0

            transform: Rotation {
                id: rotator

                origin {
                    x: 23
                    y: parent.height/2
                 }
                 angle: 90
            }
        }
    }

    Component.onCompleted: {
        for (var i = 0; i < 20; i++) {
            var item = dartComponent.createObject(toolBarItem);
            item.y=-0;
            item.x=(item.x + 28) *i;
        }
    }
}
