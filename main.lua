local Player = require "player"
local Ball = require "ball"
local Bonus = require "bonus"

local window = { x = 800, y = 600 }

local player1 = Player(0, window.y / 2, 20, 60, 200, { 0, 0.4, 0.4 })
local player2 = Player(window.x - 20, window.y / 2, 20, 60, 200, { 0, 0.4, 0.4 })
local ball = Ball(window.x / 2, window.y / 2, 20, 20, 270, { 1, 1, 1 })
local bonus = Bonus(0, 0, 30, 30, window.x, window.y, { 0, 0.4, 0.4 })

local scores = { p1 = 0, p2 = 0 }

local showTitleScreen = true

local chooseColors = false
local colorList = { { 0, 0, 1 }, { 0, 1, 0 }, { 1, 0, 0 }, { 0, 1, 1 }, { 1, 0, 1 }, { 1, 1, 0 } }
local p1Index = 1
local p2Index = 1
local p1Ready = false
local p2Ready = false

local nbHits = 0
local game = false

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
    if showTitleScreen then
        if love.keyboard.isDown("return") then
            showTitleScreen = false
            chooseColors = true
        end
    elseif chooseColors == true then
        if p1Ready and p2Ready then
            chooseColors = false
            game = true
        end

        function love.keyreleased(key)
            if key == "q" and p1Ready == false and p1Index < #colorList then
                p1Index = p1Index + 1
                player1.color = colorList[p1Index]
            elseif key == "d" and p1Ready == false and p1Index > 1 then
                p1Index = p1Index - 1
                player1.color = colorList[p1Index]
            elseif key == "left" and p2Ready == false and p2Index < #colorList then
                p2Index = p2Index + 1
                player2.color = colorList[p2Index]
            elseif key == "right" and p2Ready == false and p2Index > 1 then
                p2Index = p2Index - 1
                player2.color = colorList[p2Index]
            end

            if key == "z" then
                p1Ready = not p1Ready
            end
            if key == "up" then
                p2Ready = not p2Ready
            end
        end
    elseif game == true then
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
            nbHits = nbHits + 1
        end
        if ball.x <= player2.x + player2.width and ball.x + ball.width >= player2.x and
            ball.y <= player2.y + player2.height and ball.y + ball.height >= player2.y then
            ball:hit(player2.color)
            nbHits = nbHits + 1
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
        if nbHits >= 4 and bonus.is == false then
            if math.ceil(math.random(0, nbHits)) == nbHits then
                bonus:draw()
            end
        end
    end
end

-- Draw a coloured rectangle.
function love.draw()
    if showTitleScreen then
        -- Affichage de l'écran d'accueil
        love.graphics.print("Bienvenue sur Bordeaux Pong", window.x / 2 - 100, window.y / 2 - 20)
        love.graphics.print("Appuyez sur Entrée pour commencer", window.x / 2 - 140, window.y / 2 + 20)
    elseif chooseColors == true then
        -- Affichage de l'écran de choix de couleurs

        love.graphics.setColor(player1.color)
        love.graphics.print("Appuyer sur 'Z' pour valider", window.x / 2 - 215, window.y / 2 - 140)
        love.graphics.print("Choisissez une couleur pour le joueur 1", window.x / 2 - 250, window.y / 2 - 100)
        love.graphics.rectangle("fill", window.x / 2 - 150, window.y / 2 - 60, player1.width, player1.height)

        if p1Ready == true then
            love.graphics.print("Le joueur 1 est prêt", window.x / 2 - 200, window.y / 2 + 20)
        end


        love.graphics.setColor(player2.color)
        love.graphics.print("Appuyer sur 'Flèche Haut' pour valider", window.x / 2 + 50, window.y / 2 - 140)
        love.graphics.print("Choisissez une couleur pour le joueur 2", window.x / 2 + 50, window.y / 2 - 100)
        love.graphics.rectangle("fill", window.x / 2 + 150, window.y / 2 - 60, player2.width, player2.height)

        if p2Ready == true then
            love.graphics.print("Le joueur 2 est prêt", window.x / 2 + 105, window.y / 2 + 20)
        end
    elseif game == true then
        if bonus.is == true then
            love.graphics.setColor(bonus.color)
            love.graphics.rectangle("fill", bonus.x, bonus.y, bonus.width, bonus.height)
        end
        love.graphics.setColor(player1.color)
        love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
        love.graphics.setColor(player2.color)
        love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
        love.graphics.setColor(ball.color)
        love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)

        love.graphics.setColor(1, 1, 1)
        love.graphics.print(scores.p1 .. " - " .. scores.p2, window.x / 2, 10)
    end
end
