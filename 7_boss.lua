--boss

function boss1(boss)
    debug = "boss1"
    if boss.phbegin + 8 * 30 < t then
        boss.mission = "boss2"
        boss.phbegin = t
    end
end
function boss2(boss)
    debug = "boss2"
    if boss.phbegin + 8 * 30 < t then
        boss.mission = "boss3"
        boss.phbegin = t
    end
end
function boss3(boss)
    debug = "boss3"
    if boss.phbegin + 8 * 30 < t then
        boss.mission = "boss4"
        boss.phbegin = t
    end
end
function boss4(boss)
    debug = "boss4"
    if boss.phbegin + 8 * 30 < t then
        boss.mission = "boss1"
        boss.phbegin = t
    end
end
function boss5(boss)
    --asplodey
end