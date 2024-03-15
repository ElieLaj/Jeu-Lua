local Player = require("player")

function Ball(x, y, width, height, speed, color)
    local ball = Player(x, y, width, height, speed, color)
    ball.status = { x = 1, y = 1 }

    ball.hit = function(self, color)
        self.status.x = ball.status.x * -1
        ball.color = color
        ball.speed = ball.speed + 5 * self.status.x
    end

    ball.getStatus = function(self)
        return self.status
    end

    ball.move = function(self, dt)
        self.x = self.x + self.speed * self.status.x * dt
        self.y = self.y + self.speed * self.status.y * dt
    end

    ball.reset = function(self)
        self.x = self.baseX
        self.y = self.baseY
        self.speed = self.baseSpeed
        self.status.x = self.status.x * -1
    end
    return ball
end

return Ball
