import QtQuick 1.1

Item {
    id: balloon

    property bool destroyed: false

    width: 120
    height: 120

    Item {
        id: sprite
        property int frame: 4

        anchors.centerIn: parent

        height: parent.height
        width: parent.height
        clip: true

        transform: Rotation {
            id: rotator

            origin {
                x: 60
                y: 110
             }
             angle: 0
        }

        SequentialAnimation {
            id: shake
            PropertyAnimation { easing.type: Easing.InQuad; duration: 400; target: rotator; property: "angle"; to: 10 }
            PropertyAnimation { easing.type: Easing.InQuad; duration: 400; target: rotator; property: "angle"; to: -10 }
        }

        Timer {
            running: true
            repeat: true
            interval: 800

            onTriggered: {
                shake.restart();
            }
        }

        Image {
            id: spriteImage
            source: "qrc:/images/BalloonSpriteSheet.png"
            y: 0
            x:-parent.width*sprite.frame
        }
    }

    Timer {
        id: animation;
        repeat: true;
        interval: 80;
        onTriggered: {
            if (sprite.frame == 7) {
                if (game.score / 20 < 100)
                    game.score += 20;
                animation.stop()
                balloon.destroy();
            }

            sprite.frame++;
        }
    }

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
            balloon.y -= 3;

            if (balloon.y + balloon.height < 0) {
                game.removeBalloon(balloon);
                balloon.destroy();
            }
        }
    }
}
