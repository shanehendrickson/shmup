--bullets

function fire(myen)
    local myebul=makespr()
    myebul.x=myen.x+3
    myebul.y=myen.y+6
    myebul.spr=32
    myebul.ani={32,33,34,33}
    myebul.anispd=0.5
    myebul.sy=2

    myebul.colw=2
    myebul.colh=2
    myebul.bulmode=true

    myen.flash=4
    add(ebuls,myebul)
    sfx(29)
end