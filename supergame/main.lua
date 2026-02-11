function love.draw()
    love.graphics.print("HELLO WII! PRESS A TO QUIT", 100, 100)
end

function love.keypressed(k)
    if k == "a" then love.event.quit() end
end
