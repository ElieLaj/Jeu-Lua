local Player = require("player")

function Ball(x, y, width, height, speed, color)
    local ball = Player(x, y, width, height, speed, color)
    ball.status = 0
    ball.setStatus = function(self, status, color)
        self.status = status
        ball.setColor(self, color)
        ball.setSpeed(self, self.speed * -1)
    end

    ball.getStatus = function(self)
        return self.status
    end
end

return Ball
