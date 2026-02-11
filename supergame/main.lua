-- Simple Checkers for Wii
local board = {}
local cursor = {x = 1, y = 1}

function love.load()
    -- Create the board (1 = Red, 2 = White, 0 = Empty)
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

function love.keypressed(key)
    -- Wii Remote D-pad
    if key == "right" then cursor.x = math.min(8, cursor.x + 1)
    elseif key == "left" then cursor.x = math.max(1, cursor.x - 1)
    elseif key == "down" then cursor.y = math.min(8, cursor.y + 1)
    elseif key == "up" then cursor.y = math.max(1, cursor.y - 1)
    end
end

function love.draw()
    local size = 40 -- Size of squares
    love.graphics.print("CHECKERS - USE D-PAD", 10, 10)

    for y = 1, 8 do
        for x = 1, 8 do
            -- Draw Board Squares
            if (y + x) % 2 == 0 then love.graphics.setColor(0.5, 0.5, 0.5)
            else love.graphics.setColor(0.2, 0.2, 0.2) end
            love.graphics.rectangle("fill", x*size, y*size, size, size)

            -- Draw Pieces
            if board[y][x] == 1 then
                love.graphics.setColor(1, 0, 0) -- Red
                love.graphics.circle("fill", x*size + size/2, y*size + size/2, size/3)
            elseif board[y][x] == 2 then
                love.graphics.setColor(1, 1, 1) -- White
                love.graphics.circle("fill", x*size + size/2, y*size + size/2, size/3)
            end
        end
    end
    
    -- Draw Green Cursor
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", cursor.x*size, cursor.y*size, size, size)
end
