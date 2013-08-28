import QtQuick 1.1
import "GameLogic.js" as GameLogic

Rectangle {
    id: game
    width: 800
    height: 600

    focus: true
    property int score: 0
    color: "#00B2FF"

    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/images/sky.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    ToolBar {
        id: toolBar
    }

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
    Timer { id: coolDown; interval: 800; onTriggered: { dart.x = 0 } }
    Timer { id: goUp; repeat: true; interval: 12; onTriggered: { dart.y -= 5; } }
    Timer { id: goDown; repeat: true; interval: 12; onTriggered: { dart.y += 5; } }

    ParallelAnimation {
        id: fire

        PropertyAnimation { target: dart; property: "x"; duration: 1300; to: game.width }
        PropertyAnimation { target: dart; property: "y"; duration: 1300; to: dart.y + 150; easing.type: Easing.InQuad }

        onCompleted: coolDown.start();
    }

    Timer { repeat: true; interval: 100; running: true; onTriggered: GameLogic.collisionDetect() }

    Keys.onReleased: {
        if (event.key == Qt.Key_Up) {
            goUp.stop();
        } else if (event.key == Qt.Key_Down)
            goDown.stop();
    }

    Keys.onPressed: {
        if (event.key == Qt.Key_Up && !fire.running) {
            goUp.start();
        } else if (event.key == Qt.Key_Down && !fire.running) {
            goDown.start();
        }
    }

    Keys.onSpacePressed: {
        fire.start();
        toolBar.dropDart();
    }

    Rectangle {
        id: scoreBar
        width: parent.width; height: 40
        anchors.top: game.top
        z: 5
        color: "transparent"


        Text {
            id: scoreText
            color: "#fff"
            anchors { right: parent.right; verticalCenter: parent.verticalCenter;}
            text: "Score:" + game.score
            font { pointSize: 16 }

        }
    }
}

