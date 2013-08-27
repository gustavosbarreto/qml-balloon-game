var balloons = new Array();

function collisionDetect() {
    for (var i = 0; i < balloons.length; i++) {
        var dart = game.getDartPosition();
        if (dart.x + 95 > balloons[i].x && dart.x < balloons[i].x)
            if (dart.y > balloons[i].y && dart.y < balloons[i].y + 90)
                 balloons[i].explode();

    }
}

