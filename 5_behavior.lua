-- behavior

function doenemy(myen)
    if myen.wait > 0 then
        myen.wait -= 1
        return
    end
    if myen.mission == "flyin" then
        --flying in
        --basic easing function: x+=(targetx-x)/n
        local dx = (myen.posx - myen.x) / 7 --ease in
        local dy = (myen.posy - myen.y) / 7

        if myen.boss then
            -- myen.x+=min(dx,1)
            myen.y += min(dy, 1)
        else
            myen.x += dx
            myen.y += dy
        end

        if abs(myen.y - myen.posy) < 0.7 then
            myen.y = myen.posy
            myen.x = myen.posx
            if myen.boss then
                myen.mission = "boss1"
                myen.phbegin=t
            else
                myen.mission = "protect"
            end
        end
    elseif myen.mission == "protect" then
        --staying putting
    
    elseif myen.mission == "boss1" then
        boss1(myen)
    elseif myen.mission == "boss2" then
        boss2(myen)
    elseif myen.mission == "boss3" then
        boss3(myen)
    elseif myen.mission == "boss4" then
        boss4(myen)
    elseif myen.mission == "boss5" then
        boss5(myen)

        
    elseif myen.mission == "attack" then
        --attack
        if myen.type == 1 then
            --green guy
            myen.sy = 1.7
            myen.sx = sin(t / 35)

            --move toward center. might be neat to adjust based on player x
            if myen.x < 32 then
                myen.sx += 1 - (myen.x / 32)
            end
            if myen.x > 88 then
                myen.sx -= (myen.x - 88) / 32
            end
        elseif myen.type == 2 then
            --red guy
            myen.sy = 2.5
            myen.sx = sin(t / 20)
        elseif myen.type == 3 then
            --spinny ship - may be good place for state machine?
            if myen.sx == 0 then
                --flying down
                myen.sy = 1
                if ship.y <= myen.y then
                    myen.sy = 0
                    if ship.x < myen.x then
                        myen.sx = -3
                    else
                        myen.sx = 3
                    end
                end
            end
        elseif myen.type == 4 then
            --big yellow ship
            myen.sy = 0.35

            if myen.y > 110 then
                myen.sy = 1
            else
                if t % 25 == 0 then
                    firespread(myen, 8, 1.3, rnd())
                end
            end
        end
        move(myen)
    end
end

function picktimer()
    --escape if there are no enemies to pick from
    if mode ~= "game" then
        return
    end

    if t > nextfire then
        pickfire()
        nextfire = t + 20 + rnd(20)
    end

    if t % attackfreq == 0 then
        pickattack()
    end
end

function pickfire()
    local maxnum = min(10, #enemies)
    local myindex = flr(rnd(maxnum))

    for myen in all(enemies) do
        if myen.type == 4 and myen.mission == "protect" then
            if rnd() < 0.5 then
                firespread(myen, 12, 1.3, rnd())
                return
            end
        end
    end

    myindex = #enemies - myindex
    local myen = enemies[myindex]

    if myen == nil then return end
    -- problem with empty enemy array
    if myen.mission == "protect" then
        if myen.type == 4 then
            firespread(myen, 12, 1.3, rnd())
        elseif myen.type == 2 then
            aimedfire(myen, 2)
        else
            fire(myen, 0, 2)
        end
    end
end

function pickattack()
    local maxnum = min(10, #enemies)
    local myindex = flr(rnd(maxnum))

    myindex = #enemies - myindex
    local myen = enemies[myindex]

    if myen == nil then return end
    -- problem with empty enemy array
    if myen.mission == "protect" then
        myen.mission = "attack"
        myen.anispd = myen.anispd * 3
        myen.wait = 60
        myen.shake = 60
    end
end

function move(obj)
    obj.x += obj.sx
    obj.y += obj.sy
end

function killen(myen)
    del(enemies, myen)
    sfx(2)
    score += 1
    explode(myen.x, myen.y)

    --spawn pickups
    local cherrychance = 0.1
    if rnd() < cherrychance then
        dropickup(myen.x, myen.y)
    end
    if myen.mission == "attack" then
        if rnd() < 0.5 then
            pickattack()
        end
        --enemies who are attacking are more likely to drop pickups
        cherrychance = 0.2
        popfloat("100", myen.x + 4, myen.y + 4)
    end
end

function dropickup(pix, piy)
    local mypick = makespr()
    mypick.x = pix
    mypick.y = piy
    mypick.sy = 0.75
    mypick.spr = 48
    add(pickups, mypick)
end

function plogic(mypick)
    cherry += 1
    smol_shwave(mypick.x + 4, mypick.y + 4, 14)
    if cherry == 10 then
        --get a life
        if lives < 4 then
            lives += 1
            sfx(31)
            cherry = 0
            popfloat("1up!", mypick.x + 4, mypick.y + 4)
        else
            --????
            score += 100
            cherry = 0
        end
    else
        sfx(30)
    end
end

function animate(myen)
    myen.aniframe += myen.anispd
    if flr(myen.aniframe) > #myen.ani then
        myen.aniframe = 1
    end
    myen.spr = myen.ani[flr(myen.aniframe)]
end