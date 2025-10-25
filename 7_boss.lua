--myen

function boss1(myen)
    --movement: left and right
    local spd = 2
    if myen.sx == 0 or myen.x >= 93 then
        myen.sx = -spd
    end
    if myen.x <= 3 then
        myen.sx = spd
    end

    --shooting
    if t % 30 > 3 then
        if t % 3 == 0 then
            fire(myen, 0, 2)
        end
    end

    --transition
    debug = "boss1"
    if myen.phbegin + 8 * 30 < t then
        myen.mission = "boss2"
        myen.phbegin = t
    end
    move(myen)
end
function boss2(myen)
    debug = "boss2"
    if myen.phbegin + 8 * 30 < t then
        myen.mission = "boss3"
        myen.phbegin = t
    end
end
function boss3(myen)
    debug = "boss3"
    if myen.phbegin + 8 * 30 < t then
        myen.mission = "boss4"
        myen.phbegin = t
    end
end
function boss4(myen)
    debug = "boss4"
    if myen.phbegin + 8 * 30 < t then
        myen.mission = "boss1"
        myen.phbegin = t
    end
end
function boss5(myen)
    --asplodey
end