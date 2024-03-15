_G.Player = {}

function Player(x, y, width, height, speed, color)
    return {
        x = x,
        y = y,
        width = width,
        height = height,
        speed = speed,
        color = color,

        setColor = function(self, color)
            self.color = color
        end,
        setSpeed = function(self, speed)
            self.speed = speed
        end,
        moveLeft = function(self, dt)
            self.x = self.x - self.speed * dt
        end,
        moveRight = function(self, dt)
            self.x = self.x + self.speed * dt
        end,
        moveUp = function(self, dt)
            self.y = self.y - self.speed * dt
        end,
        moveDown = function(self, dt)
            self.y = self.y + self.speed * dt
        end,
        getLocation = function(self)
            return self.x, self.y
        end,
        getX = function(self)
            return self.x
        end,
        getY = function(self)
            return self.y
        end
    }
end

return Player
