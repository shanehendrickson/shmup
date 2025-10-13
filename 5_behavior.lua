-- behavior

function doenemy(myen)
    if myen.wait>0 then
        myen.wait-=1
        return
    end
    if myen.mission=="flyin" then
        --flying in
        --basic easing function: x+=(targetx-x)/n

        myen.x+=(myen.posx-myen.x)/7 --ease in
        myen.y+=(myen.posy-myen.y)/7
        
        if abs(myen.y-myen.posy)<0.7 then
            myen.y=myen.posy
            myen.mission="protect"
        end

    elseif myen.mission=="protect" then
        --staying putting
    
    --this enemy attack pattern would be great for an enemy class
    elseif myen.mission=="attack" then
        --attack
        if myen.type==1 then
            --green guy
            myen.sy=1.7
            myen.sx=sin(t/35)

            --move toward center. might be neat to adjust based on player x
            if myen.x<32 then
                myen.sx+=1-(myen.x/32)
            end
            if myen.x>88 then
                myen.sx-=(myen.x-88)/32
            end

            
        elseif myen.type==2 then
            --red guy
            myen.sy=2.5
            myen.sx=sin(t/20)
            
        elseif myen.type==3 then
            --spinny ship - may be good place for state machine?
            if myen.sx==0 then
                --flying down
                myen.sy=1
                if ship.y<=myen.y then
                    myen.sy=0
                    if ship.x<myen.x then myen.sx=-3
                    else myen.sx=3
                    end
                end
            
            end
        elseif myen.type==4 then
            --big yellow ship
            myen.sy=0.35
            if myen.y>110 then
                myen.sy=1
            end
        end
        move(myen)
    end
end

function picktimer()
    --escape if there are no enemies to pick from
    if mode!="game" then
        return
    end

    if t%attackfreq==0 then
        pickattack()
    end
end

function pickattack()
    local maxnum=min(10,#enemies)
    local myindex=flr(rnd(maxnum))

    myindex=#enemies-myindex
    local myen=enemies[myindex]

    if myen==nil then return end -- problem with empty enemy array
    if myen.mission=="protect" then
        myen.mission="attack"
        myen.anispd*=3
        myen.wait=60
        myen.shake=60
    end 
end

function move(obj)
    obj.x+=obj.sx
    obj.y+=obj.sy
end

function killen(myen)
    del(enemies,myen)
    sfx(2)
    score+=1                    
    explode(myen.x,myen.y)

    if myen.mission=="attack" then
        if rnd()<0.5 then
            pickattack()            
        end
    end
end