--bullets

function fire(myen,ang,spd)
    local myebul=makespr()
    myebul.x=myen.x+3
    myebul.y=myen.y+6
    if myen.type==3 then
        myebul.x=myen.x+7
        myebul.y=myen.y+13
    end
    myebul.spr=32
    myebul.ani={32,33,34,33}
    myebul.anispd=0.5
    
    myebul.sx=sin(ang)*spd
    myebul.sy=cos(ang)*spd

    myebul.colw=2
    myebul.colh=2
    myebul.bulmode=true

    myen.flash=4
    add(ebuls,myebul)
    sfx(29)
    return myebul
end

function firespread(myen,num,spd,base)    
    if base==nil then
        base=0
    end
    for i=1,num do
        fire(myen,1/num*i+base,spd)
    end
end

function aimedfire(myen,spd)
    --atan2(y2-y1,x2-x1) -- calculate angle between two points
    local myebul=fire(myen,0,spd)
    local ang=atan2((ship.y+4)-myebul.y,(ship.x+4)-myebul.x)
    myebul.sx=sin(ang)*spd
    myebul.sy=cos(ang)*spd
end