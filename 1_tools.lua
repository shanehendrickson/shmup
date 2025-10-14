function starfield()
    
    for i=1,#stars do
        local mystar=stars[i]
        local scol=6
        
        if mystar.spd<1 then
            scol=1
        elseif mystar.spd<1.5 then
            scol=13
        end   
        
        pset(mystar.x,mystar.y,scol)
    end
end

function animatestars()
    
    for i=1,#stars do
        local mystar=stars[i]
        mystar.y=mystar.y+mystar.spd
        if mystar.y>128 then
            mystar.y=mystar.y-128
        end
    end
    
end

function blink()
    local banim={5,5,5,5,5,5,5,5,5,5,5,6,6,7,7,6,6,5}
    
    if blinkt>#banim then
        blinkt=1
    end
    
    return banim[blinkt]
end

function drwmyspr(myspr)
    local sprx=myspr.x
    local spry=myspr.y
    if myspr.shake>0 then
        myspr.shake-=1
        if t%4<2 then
            sprx+=1
        end
    end
    --workaround for "hitbox"
    --future - change collision detection to account for a hitbox
    if myspr.bulmode then
        sprx-=2
        spry-=2
    end

    spr(myspr.spr,sprx,spry,myspr.sprw,myspr.sprh)
end

function col(a,b)
    --lots of math
    local a_left=a.x
    local a_top=a.y
    local a_right=a.x+a.colw
    local a_bottom=a.y+a.colh

    local b_left=b.x
    local b_top=b.y
    local b_right=b.x+b.colw
    local b_bottom=b.y+b.colh

    if a_top > b_bottom then return false end
    if b_top > a_bottom then return false end
    if a_left > b_right then return false end
    if b_left > a_right then return false end
    return true
end

function explode(expx,expy,isblue)

    local myp={}
    myp.x=expx
    myp.y=expy

    myp.sx=0
    myp.sy=0

    myp.age=0
    myp.size=10
    myp.maxage=0
    myp.blue=isblue

    add(parts,myp)   

    for i=1,30 do
        local myp={}
        myp.x=expx
        myp.y=expy

        myp.sx=(rnd()-0.5)*6
        myp.sy=(rnd()-0.5)*6

        myp.age=rnd(2)
        myp.size=1+rnd(4)
        myp.maxage=10+rnd(10)
        myp.blue=isblue

        add(parts,myp)    
    end

    for i=1,20 do
        local myp={}
        myp.x=expx
        myp.y=expy

        myp.sx=(rnd()-0.5)*10
        myp.sy=(rnd()-0.5)*10

        myp.age=rnd(2)
        myp.size=1+rnd(4)
        myp.maxage=10+rnd(10)
        myp.blue=isblue
        myp.spark=true
        add(parts,myp)    
    end
    big_shwave(expx,expy)
end

function page_red(page)
    local col= 7
    if page>5 then
        col=10
    end
    if page>7 then
        col=9
    end
    if page>10 then
        col=8
    end
    if page>12 then
        col=2
    end
    if page>15 then
        col=5
    end

    return col
end
function page_blue(page)
    local col= 7
    if page>5 then
        col=6
    end
    if page>7 then
        col=12
    end
    if page>10 then
        col=13
    end
    if page>12 then
        col=1
    end
    if page>15 then
        col=1
    end

    return col
end

function smol_shwave(shx,shy)
    local mysw={}
    mysw.x=shx
    mysw.y=shy
    mysw.r=3
    mysw.tr=6
    mysw.col=9
    mysw.speed=1
    add(shwaves,mysw)
end
function big_shwave(shx,shy)
    local mysw={}
    mysw.x=shx
    mysw.y=shy
    mysw.r=3
    mysw.tr=25
    mysw.col=7
    mysw.speed=3.5
    add(shwaves,mysw)
end


function smol_spark(sx,sy)
    for i=1,rnd(3)+1 do
        local myp={}
        myp.x=sx
        myp.y=sy

        myp.sx=(rnd()-0.5)*8
        myp.sy=(rnd()-1)*3       

        myp.age=rnd(2)
        myp.size=1+rnd(4)
        myp.maxage=10+rnd(10)
        myp.blue=isblue
        myp.spark=true
        myp.col=11
        add(parts,myp)    
    end
end

function makespr()
    local myspr={
        x=0,
        y=0,
        sx=0,
        sy=0,
        flash=0,
        shake=0,
        aniframe=1,
        spr=0,
        sprw=1,
        sprh=1,
        colw=7, -- sprite witdh of 8 - 1
        colh=7


    }
    return myspr
end