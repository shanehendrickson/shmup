--bullets

function fire(myen, ang, spd)
    local myebul = makespr()
    myebul.x = myen.x + 3
    myebul.y = myen.y + 6
    if myen.type == 4 then
        myebul.x = myen.x + 7
        myebul.y = myen.y + 13
    elseif myen.boss then
        myebul.x = myen.x + 15
        myebul.y = myen.y + 23
    end
    myebul.spr = 32
    myebul.ani = { 32, 33, 34, 33 }
    myebul.anispd = 0.5

    myebul.sx = sin(ang) * spd
    myebul.sy = cos(ang) * spd

    myebul.colw = 2
    myebul.colh = 2
    myebul.bulmode = true
    if myen.boss != true then
        myen.flash = 4
        sfx(29)
    else
        sfx(34)

    end
    add(ebuls, myebul)
    return myebul
end

function firespread(myen, num, spd, base)
    if base == nil then
        base = 0
    end
    for i = 1, num do
        fire(myen, 1 / num * i + base, spd)
    end
end

function aimedfire(myen, spd)
    --atan2(y2-y1,x2-x1) -- calculate angle between two points
    local myebul = fire(myen, 0, spd)
    local ang = atan2((ship.y + 4) - myebul.y, (ship.x + 4) - myebul.x)
    myebul.sx = sin(ang) * spd
    myebul.sy = cos(ang) * spd
end

function cherrybomb(cherry)
    local spc = 0.25 / (cherry * 2)

    for i = 0, cherry * 2 do
        local ang = 0.375 + spc * i
        local newbul = makespr()
        newbul.x = ship.x
        newbul.y = ship.y - 3
        newbul.spr = 17
        newbul.dmg = 3
        newbul.sx = sin(ang) * 4
        newbul.sy = cos(ang) * 4

        add(buls, newbul)
    end
    big_shwave(ship.x, ship.y)
    shake = cherry
    muzzle = 5
    invul = 60
end