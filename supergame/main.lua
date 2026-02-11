-- Game Variables
local board = {}
local cursor = {x = 1, y = 1}
local selected = nil
local turn = 1 -- 1 for Red, 2 for White
local cellSize = 60
local offsetX, offsetY = 80, 40

function love.load()
    -- Initialize 8x8 board: 1 = Red, 2 = White, 0 = Empty
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
    -- Movement (Wii Remote D-Pad maps to Arrows)
    if key == "right" then cursor.x = math.min(8, cursor.x + 1)
    elseif key == "left" then cursor.x = math.max(1, cursor.x - 1)
    elseif key == "down" then cursor.y = math.min(8, cursor.y + 1)
    elseif key == "up" then cursor.y = math.max(1, cursor.y - 1)
    
    -- Selection/Action (A Button)
    elseif key == "return" or key == "a" then
        local bx, by = cursor.x, cursor.y
        
        if not selected then
            -- Try to select your own piece
            if board[by][bx] == turn then
                selected = {x = bx, y = by}
            end
        else
            -- Check for simple move (1 diagonal space)
            local dx = math.abs(bx - selected.x)
            local dy = by - selected.y
            local direction = (turn == 1) and -1 or 1
            
            if dx == 1 and dy == direction and board[by][bx] == 0 then
                board[by][bx] = turn
                board[selected.y][selected.x] = 0
                selected = nil
                turn = (turn == 1) and 2 or 1 -- Swap turns
            else
                selected = nil -- Deselect if invalid
            end
        end
    end
end

function love.draw()
    love.graphics.print("Player Turn: " .. (turn == 1 and "RED" or "WHITE"), 10, 10)

    for y = 1, 8 do
        for x = 1, 8 do
            -- Draw Squares
            if (y + x) % 2 == 0 then love.graphics.setColor(0.7, 0.7, 0.7)
            else love.graphics.setColor(0.2, 0.2, 0.2) end
            love.graphics.rectangle("fill", x*cellSize + offsetX, y*cellSize + offsetY, cellSize, cellSize)

            -- Draw Pieces
            if board[y][x] ~= 0 then
                if board[y][x] == 1 then love.graphics.setColor(0.8, 0, 0)
                else love.graphics.setColor(1, 1, 1) end
                love.graphics.circle("fill", x*cellSize + offsetX + cellSize/2, y*cellSize + offsetY + cellSize/2, cellSize/2.5)
            end
        end
    end
    
    -- Draw Cursor
    love.graphics.setLineWidth(3)
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", cursor.x*cellSize + offsetX, cursor.y*cellSize + offsetY, cellSize, cellSize)
    
    -- Highlight Selection
    if selected then
        love.graphics.setColor(1, 1, 0)
        love.graphics.rectangle("line", selected.x*cellSize + offsetX, selected.y*cellSize + offsetY, cellSize, cellSize)
    end
end
