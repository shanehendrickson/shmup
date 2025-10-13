function draw_game()
    cls(0)
    starfield()
    if lives>0 then
        if invul<=0 then        
            drwmyspr(ship)
            spr(flamespr,ship.x,ship.y+8)
        else
            --invul state / blink anim
            if sin(t/5)<0.1 then
                drwmyspr(ship)
                spr(flamespr,ship.x,ship.y+8)
            end
        end        
    end
    
    --drawing enemies
    for myen in all(enemies) do
        if myen.flash>0 then
            myen.flash-=1
            for i=1,15 do
                pal(i,7)
            end
        end
        drwmyspr(myen)
        pal()
    end
    
    --drawing bullets
    for mybul in all(buls) do
        drwmyspr(mybul)
    end
    
    --draw muzzle flash
    if muzzle>0 then
        circfill(ship.x+3,ship.y-2,muzzle,7)
        circfill(ship.x+4,ship.y-2,muzzle,7)
    end

    --drawing shockwaves
    for mysw in all(shwaves) do
        circ(mysw.x+4,mysw.y+4,mysw.r,mysw.col)
        mysw.r+=mysw.speed
        if mysw.r>mysw.tr then
            del(shwaves,mysw)
        end
    end

    --drawing particles
    for myp in all(parts) do
        local pc=7

        if myp.blue then
            pc=page_blue(myp.age)
        else    
            pc=page_red(myp.age)
        end

        if myp.spark then
            pset(myp.x,myp.y,7)
        else
            circfill(myp.x+4,myp.y+4,myp.size,pc)
        end
        myp.x+=myp.sx
        myp.y+=myp.sy
        myp.sx=myp.sx*0.85
        myp.sy=myp.sy*0.85
        myp.age+=1

        if myp.age>myp.maxage then
            myp.size-=0.5
            if myp.size <0 then                
                del(parts,myp)
            end
        end
    end
    
    print("score:"..score,40,1,12)
    
    for i=1,4 do
        if lives>=i then
            spr(13,i*9-8,1)
        else
            spr(14,i*9-8,1)
        end 
    end
    
end

function draw_start()
    cls(1)

    --modulo based timer for events: great for blinking
    -- local seconds=flr(time())
    -- local stuff=seconds%5
    
    print("shmup!",34,40,12) 
    print("press any key to start",20,80,blink())
end

function draw_over()
    draw_game()
    print("game over",47,40,8) 
    print("press any key to continue",16,80,blink())
end

function draw_wavetext()
    draw_game()
    print("wave " ..wave, 56, 40, blink())
end

function draw_win()
    draw_game()
    print("conglaturation",35,40,12) 
    print("press any key to continue",16,80,blink())
end