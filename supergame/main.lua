local board = {}
local cx = 1
local cy = 1

function love.load()
    for y = 1, 8 do
        board[y] = {}
        for x = 1, 8 do
            if (y + x) % 2 == 1 then
                if y <= 3 then board[y][x] = 2
                elseif y >= 6 then board[y][x] = 1
                else board[y][x] = 0 end
            else board[y][x] = 0 end
        end
    end
end

function love.keypressed(k)
    if k == "right" then cx = math.min(8, cx + 1) end
    if k == "left" then cx = math.max(1, cx - 1) end
    if k == "down" then cy = math.min(8, cy + 1) end
    if k == "up" then cy = math.max(1, cy - 1) end
end

function love.draw()
    for y = 1, 8 do
        for x = 1, 8 do
            if (y + x) % 2 == 0 then love.graphics.setColor(0.5, 0.5, 0.5)
            else love.graphics.setColor(0.2, 0.2, 0.2) end
            love.graphics.rectangle("fill", x*40, y*40, 40, 40)
            if board[y][x] == 1 then
                love.graphics.setColor(1, 0, 0)
                love.graphics.circle("fill", x*40+20, y*40+20, 15)
            elseif board[y][x] == 2 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.circle("fill", x*40+20, y*40+20, 15)
            end
        end
    end
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", cx*40, cy*40, 40, 40)
end
