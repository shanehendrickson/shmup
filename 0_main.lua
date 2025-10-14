-- todo --
-- ----------------
-- enemy behavior

-- enemy bullets
-- pickups
-- bombs?
-- boss
-- nicer screens

function _init()
    cls(0) -- clear screen
    
    startscreen()
    blinkt=1
    t=0
    lockout=0
end

function _update()
    t+=1
    blinkt+=1
    
    if mode=="game" then
        update_game()
    elseif mode=="start" then
        update_start()
    elseif mode=="wavetext" then
        update_wavetext()
    elseif mode=="over" then
        update_over()
    elseif mode=="win" then
        update_win()
    end
    
end

function _draw()
    
    if mode=="game" then
        draw_game()
    elseif mode=="start" then
        draw_start()
    elseif mode=="wavetext" then
        draw_wavetext()
    elseif mode=="over" then
        draw_over()
    elseif mode=="win" then
        draw_win()
    end
    
end

function startscreen()
    mode="start"
    music(7)
end

function startgame()
    
    t=0
    wave=0
    nextwave()
    
    ship=makespr()
    ship.x=64
    ship.y=96
    ship.sx=0
    ship.sy=0
    ship.spr=2

    
    flamespr=5
    
    bultimer=0
    
    muzzle=0
    
    score=0
    
    lives=1
    invul=0

    attackfreq=60
    nextfire=0
    stars={} 
    for i=1,100 do
        local newstar={}
        newstar.x=flr(rnd(128))
        newstar.y=flr(rnd(128))
        newstar.spd=rnd(1.5)+0.5
        add(stars,newstar)
    end 
    
    buls={}
    ebuls={}
    enemies={}

    parts={}

    shwaves={}

end
