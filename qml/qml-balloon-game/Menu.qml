import QtQuick 1.1

Rectangle {

    id: menuBox
    width: 800
    height: 600
    opacity: 1

    Image {

        id: background
        x: 25
        y: 9
        anchors.fill: parent
        source: "qrc:/images/sky.jpg"
        fillMode: Image.PreserveAspectCrop
    }


    Rectangle {

        id: menuScreen
        width: 384
        height: 384
        opacity: 1
        color: Qt.rgba(0, 0, 0, 0.4)
        radius: 5
        anchors {
            horizontalCenter: parent.horizontalCenter;
            verticalCenter: parent.verticalCenter;}


        Rectangle {

            id: logo
            width: gameName.width
            height: gameName.heigth
            color: "#c1c1c1"

            anchors {
                horizontalCenter: parent.horizontalCenter;
                verticalCenter: parent.verticalCenter;}


            Text {

                id:gameName
                x: 0
                y: -170
                color: "#fff"
                anchors {
                    horizontalCenter:parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter;}
                anchors.rightMargin: 10
                text: "Balloon Game"
                anchors.verticalCenterOffset: -138
                anchors.horizontalCenterOffset: 0
                font.family: "LilyUPC"
                font { pointSize: 51 }

            }
        }

        Rectangle {

            id: newgameButton
            x: 127
            y: 177
            width: 130
            height: 30
            color: "red"
            radius: 15
            anchors.bottomMargin: 177
            anchors {
                bottom: menuScreen.bottom;
                verticalCenter: newgameButton.verticalCenter;}

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    menuBox.opacity = 0;
                    game.opacity = 1;
                }

            }

            Text {
                id:newGameText
                color: "#fff"
                anchors {
                    horizontalCenter:parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter;}
                anchors.margins: 10
                text: "New Game"
                font { pointSize: 12 }

            }
        }
    }
}
