function love.load()
    target={}
    target.x=300
    target.y=300
    target.rad=50

    score=0
    time=0
    gamestate=1

    gamefont=love.graphics.newFont(25)

    sprites={}
    sprites.sky=love.graphics.newImage('sprites/sky.png')
    sprites.crosshairs=love.graphics.newImage('sprites/crosshairs.png')
    sprites.target=love.graphics.newImage('sprites/target.png')

    love.mouse.setVisible(false)
end

function love.update(dt)
    if time>dt then
        time=time-dt
    else
        time=0
        gamestate=1
    end
end

function love.draw()
    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gamefont)
    if gamestate==2 then
        love.graphics.print("SCORE: "..score,5,5)
        love.graphics.print("TIME: "..math.ceil(time),200,5)
    end

    if gamestate==1 then
        love.graphics.printf("Click Anywhere To Begin!!!",0,250,love.graphics.getWidth(),"center")
    end

    if gamestate==2 then
        love.graphics.draw(sprites.target, target.x-target.rad, target.y-target.rad)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
    
end

function love.mousepressed( x, y, button, istouch, presses )
    if gamestate == 2 then
        local mouseToTarget = distancecalc(x, y, target.x, target.y)
        if mouseToTarget < target.rad then
            if button == 1 then
            	score = score + 1
            elseif button == 2 then
            	score = score + 2
            	time = time - 1
            end
            target.x = math.random(target.rad, love.graphics.getWidth() - target.rad)
            target.y = math.random(target.rad, love.graphics.getHeight() - target.rad)
        elseif score > 0 then
        	score = score - 1
        end
    elseif gamestate==1 and button==1 then
        gamestate = 2
        time=30
        score=0
    end
end

--Alternate but a little lengthy way found by yours truly "ME" :)

--[[function love.mousepressed( x, y, button, istouch, presses )
    if button==1 and gamestate==2 then
        local mouseTotarget=distancecalc(x,y,target.x,target.y)
        if mouseTotarget<target.rad then
            score=score+1
            target.x=math.random(target.rad, love.graphics.getWidth()-target.rad)
            target.y=math.random(target.rad, love.graphics.getHeight()-target.rad)
        else
            score=score-1
            if score<0 then
                gamestate=1
            end    
        end    
    elseif button==1 and gamestate==1 then
        gamestate=2
        time=10
        score=0
    end

    if button==2 and gamestate==2 then
        local mouseTotarget=distancecalc(x,y,target.x,target.y)
        if mouseTotarget<target.rad then
            score=score+2
            time=time-1
            target.x=math.random(target.rad, love.graphics.getWidth()-target.rad)
            target.y=math.random(target.rad, love.graphics.getHeight()-target.rad)
        else
            score=score-1
            if score<0 then
                gamestate=1
            end    
        end    
    elseif button==1 and gamestate==1 then
        gamestate=2
        time=10
        score=0
    end
end]]

function distancecalc(x1, y1, x2, y2)
    return ((x2-x1)^2+(y2-y1)^2)^0.5
end

