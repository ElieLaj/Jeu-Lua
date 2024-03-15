local Player = require "player"
local Ball = require "ball"

local window = { x = 800, y = 600 }

local player1 = Player(0, window.y / 2, 20, 60, 200, { 0, 0.4, 0.4 })
local player2 = Player(window.x - 20, window.y / 2, 20, 60, 200, { 0, 0.4, 0.4 })
-- local ball = Ball()

-- Load some default values for our rectangle.
function love.load()
    love.window.setMode(window.x, window.y, { resizable = true, vsync = 0, minwidth = 400, minheight = 300 })
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    if love.keyboard.isDown("s") and player1.y < (window.y - player1.height) then
        player1:moveDown(dt)
    end
    if love.keyboard.isDown("z") and player1.y > 0 then
        player1:moveUp(dt)
    end

    if love.keyboard.isDown("down") and player2.y < (window.y - player2.height) then
        player2:moveDown(dt)
    end
    if love.keyboard.isDown("up") and player2.y > 0 then
        player2:moveUp(dt)
    end
end

-- Draw a coloured rectangle.
function love.draw()
    -- In versions prior to 11.0, color component values are (0, 102, 102)
    love.graphics.setColor(player1.color)
    love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
    love.graphics.setColor(player2.color)
    love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
end
