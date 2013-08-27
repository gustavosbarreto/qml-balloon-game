import QtQuick 1.1
import "GameLogic.js" as GameLogic

Rectangle {
    id: game
    width: 800
    height: 600

    focus: true

    color: "#00B2FF"

    function randomNumber(from, to) {
       return Math.floor(Math.random() * (to - from + 1) + from);
    }

    function removeBalloon(balloon) {
        GameLogic.balloons.splice(GameLogic.balloons.indexOf(balloon), 1);
    }

    function getDartPosition() {
        return { x: dart.x, y: dart.y }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true

        onTriggered: {
            var component = Qt.createComponent("Balloon.qml");
            var balloon = component.createObject(game);
            balloon.x = randomNumber(200, game.width);
            balloon.y = -100;
            GameLogic.balloons.push(balloon);
        }
    }

    Image {
        id: 'dart'
        source: "qrc:/images/Dart.png"
        y: 400
    }

    // Dart animations
    Timer { id: goUp; repeat: true; interval: 10; onTriggered: { dart.y -= 3; } }
    Timer { id: goDown; repeat: true; interval: 10; onTriggered: { dart.y += 3; } }
    PropertyAnimation { id: fire; target: dart; property: "x"; duration: 2000; to: game.width; onCompleted: { dart.x = 0; } }

    Timer { repeat: true; interval: 50; running: true; onTriggered: GameLogic.collisionDetect() }

    Keys.onReleased: {
        if (event.key == Qt.Key_Up) {
            goUp.stop();
        } else if (event.key == Qt.Key_Down)
            goDown.stop();
    }

    Keys.onPressed: {
        if (event.key == Qt.Key_Up) {
            goUp.start();
        } else if (event.key == Qt.Key_Down) {
            goDown.start();
        }
    }

    Keys.onSpacePressed: {
        fire.start();
    }
}
