function love.load()
    num=0
end

function love.update(dt)
    num=num+1
end

function love.draw()
    love.graphics.print(num,0,0)
    love.graphics.print(love.timer.getFPS(),0,10)
end

