local Player = require "player"
local Ball = require "ball"

local window = { x = 800, y = 600 }

local player1 = Player(0, window.y / 2, 20, 60, 200, { 0, 0.4, 0.4 })
local player2 = Player(window.x - 20, window.y / 2, 20, 60, 200, { 0, 0.4, 0.4 })
local ball = Ball(window.x / 2, window.y / 2, 20, 20, 100, { 0, 0, 1 })
local scores = { p1 = 0, p2 = 0 }

local function reset()
    ball:reset()
    player1:reset()
    player2:reset()
end

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
    if ball.y <= 0 then
        ball.status.y = 1
    end
    if ball.y >= window.y - ball.height then
        ball.status.y = -1
    end

    if ball.x <= player1.x + player1.width and ball.x + ball.width >= player1.x and
        ball.y <= player1.y + player1.height and ball.y + ball.height >= player1.y then
        ball:hit(player1.color)
    end
    if ball.x <= player2.x + player2.width and ball.x + ball.width >= player2.x and
        ball.y <= player2.y + player2.height and ball.y + ball.height >= player2.y then
        ball:hit(player2.color)
    end

    if ball.x <= 0 then
        scores.p2 = scores.p2 + 1
        reset()
    end
    if ball.x >= window.x - ball.width then
        scores.p1 = scores.p1 + 1
        reset()
    end

    ball:move(dt)
end

-- Draw a coloured rectangle.
function love.draw()
    -- In versions prior to 11.0, color component values are (0, 102, 102)
    love.graphics.setColor(player1.color)
    love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
    love.graphics.setColor(player2.color)
    love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
    love.graphics.setColor(ball.color)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(scores.p1 .. " - " .. scores.p2, window.x / 2, 10)
end
