import QtQuick 1.1

Item {
    id: balloon

    property bool destroyed: false

    width: 120
    height: 120

    Item {
        id: sprite
        property int frame: 0

        anchors.centerIn: parent

        height: parent.height
        width: parent.height
        clip: true

        Image {
            id: spriteImage
            source: "qrc:/images/BalloonSpriteSheet.png"
            y: 0
            x:-parent.width*sprite.frame
        }
    }

    Timer { id: animation; repeat: true; interval: 80; onTriggered: { if (sprite.frame == 7) animation.stop(); sprite.frame++; } }

    function explode() {
        if (!destroyed) {
            sprite.frame = 5;
            animation.start();
        }
        destroyed = true;
    }

    Timer {
        interval: 50
        running: true
        repeat: true

        onTriggered: {
            balloon.y += 3;

            if (balloon.y > game.height) {
                game.removeBalloon(balloon);
                balloon.destroy();
            }
        }
    }
}
