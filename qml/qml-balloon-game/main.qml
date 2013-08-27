import QtQuick 1.1
import "GameLogic.js" as GameLogic

Rectangle {
    id: game
    width: 800
    height: 600

    focus: true
    property int score: 0
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
            balloon.y = game.height;
            GameLogic.balloons.push(balloon);
        }
    }

    Image {
        id: dart;
        source: "qrc:/images/Dart.png"
        y: 400
    }

    // Dart animations
    Timer { id: goUp; repeat: true; interval: 15; onTriggered: { dart.y -= 4; } }
    Timer { id: goDown; repeat: true; interval: 15; onTriggered: { dart.y += 4; } }
    PropertyAnimation { id: fire; target: dart; property: "x"; duration: 2500; to: game.width; onCompleted: { dart.x = 0; } }

    Timer { repeat: true; interval: 80; running: true; onTriggered: GameLogic.collisionDetect() }

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

    Rectangle {
        id: scoreBar
        width: parent.width; height: 30
        color: "#fff"
        anchors.bottom: game.bottom
        z: 9999;

        Text {
            id: scoreText
            color: "#000"
            anchors { right: parent.right; verticalCenter: parent.verticalCenter;}
            text: "Score:" + game.score
            font { pointSize: 13 }

        }
    }
}

