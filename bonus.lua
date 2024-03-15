_G.Bonus = {}

function Bonus(x, y, width, height, maxX, maxY, color)
    return {
        x = x,
        y = y,
        maxX = maxX,
        maxY = maxY,
        width = width,
        height = height,
        color = color,
        is = false,
        draw = function(self)
            self.is = true
            math.randomseed(os.time())
            self.x = math.random(0, self.maxX)
            self.y = math.random(0, self.maxY)
        end,
        effect = function(self)
            math.randomseed(os.time())
            local index = math.random(1, 3)
            if index == 1 then
                return 100
            elseif index == 2 then
                return 200
            else
                return 300
            end
        end
    }
end

return Bonus
