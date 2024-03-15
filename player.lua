_G.Player = {}

function Player(x, y, width, height, speed, color)
    return {
        x = x,
        baseX = x,
        y = y,
        baseY = y,
        width = width,
        height = height,
        speed = speed,
        baseSpeed = speed,
        color = color,


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
        reset = function(self)
            self.x = self.baseX
            self.y = self.baseY
            self.speed = self.baseSpeed
        end


    }
end

return Player
