pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
#include 0_main.lua

-->8
--tools--

function starfield()
	for i = 1, #stars do
		local star = stars[i]
		star_color = 7
		if star.sp < 1 then
			star_color = 1
		elseif star.sp < 1.5 then
			star_color = 13
		end

		pset(
			stars[i].sx,
			stars[i].sy,
			star_color
		)
	end
end

function animate_stars()
	for i = 1, #stars do
		local star = stars[i]
		star.sy += star.sp
		if star.sy > 128 then
			star.sy = 0
			star.sx = flr(rnd(128))
			--if
		end
		--for
	end
	--function
end

function blink()
	local blink_ani = { 5, 6, 7, 7, 6, 5 }

	if blinkt > 6 then
		blinkt = 1
	end
	return blink_ani[blinkt]
end
-->8
--update--

function update_game()
	if ship.health == 0 then
		mode = "over"
	end

	--save pos--
	local prevx = ship.xpos
	local prevy = ship.ypos

	--controls
	if btn(0) then
		--left
		ship.xpos -= ship.spd
		ship.img =
			--right
			1
	elseif btn(1) then
		ship.xpos += ship.spd
		ship.img = 3
	else
		ship.img = 2
		--if btn 0 or 1
	end
	if btn(2) then
		ship.ypos -= ship.spd
	elseif btn(3) then
		ship.ypos += ship.spd
		--if btn 2 or 3
	end

	if btnp(5) and ship.bul_count < 3 then
		local newbul = {}
		newbul.x = ship.xpos
		newbul.y = ship.ypos - 2
		newbul.spd = 4
		ship.bul_count += 1
		add(bullets, newbul)

		sfx(0)
		muzzle = 6
	end

	if btnp(4) then
		ship.health -= 1
	end

	--move the bullets
	for i = #bullets, 1, -1 do
		local mybul = bullets[i]
		mybul.y -= mybul.spd

		if mybul.y < -8 then
			del(bullets, mybul)
			ship.bul_count -= 1
		end
	end

	--animate flame
	if ship.flame == 9 then
		ship.flame = 5
	else
		ship.flame = ship.flame + 1
	end

	--animate muzzle flash
	if muzzle > 0 then
		muzzle -= 1
	end

	--check edge
	if ship.xpos > 127 then
		ship.xpos = -7
	elseif ship.xpos < -7 then
		ship.xpos = 127
		--if
	end

	if ship.ypos > 127 then
		ship.ypos = -7
	elseif ship.ypos < -7 then
		ship.ypos = 127
		--if
	end

	animate_stars()
	--_update
end

function update_start()
	if btnp(4) or btnp(5) then
		start_game()
	end
end

function update_over()
	if btnp(4) or btnp(5) then
		mode = "start"
	end
end
-->8
--draw--
function draw_game()
	cls(0)
	starfield()
	spr(ship.img, ship.xpos, ship.ypos)

	for i = 1, #bullets do
		local mybul = bullets[i]
		spr(16, mybul.x, mybul.y)
	end

	spr(ship.flame, ship.xpos, ship.ypos + 8)
	if muzzle > 0 then
		circfill(
			ship.xpos + 3,
			ship.ypos - 2,
			muzzle,
			7
		)
	end

	print(ui.score, 64, 1, 12)

	--draw hearts
	for i = 1, ship.max_h do
		if ship.health >= i then
			spr(13, i * 9, 1)
		else
			spr(14, i * 9, 1)
		end
	end
	print(#bullets, 5, 5, 7)
end

function draw_start()
	cls(1)
	print(
		"my awesome shmup",
		34, 40, 12
	)
	print(
		"press any key to start",
		20, 80, blink()
	)
end

function draw_over()
	cls(8)
	print("game over", 50, 40, 2)
	print(
		"press any key to continue",
		15, 80, 7
	)
end

__gfx__
00000000000220000002200000022000000000000000000000000000000000000000000000000000000000000000000000000000088008800880088000000000
000000000028820000288200002882000000000000077000000770000007700000c77c0000077000000000000000000000000000888888888008800800000000
007007000028820000288200002882000000000000c77c000007700000c77c000cccccc000c77c00000000000000000000000000888888888000000800000000
0007700000288e2002e88e2002e882000000000000cccc00000cc00000cccc0000cccc0000cccc00000000000000000000000000888888888000000800000000
00077000027c88202e87c8e202887c2000000000000cc000000cc000000cc00000000000000cc000000000000000000000000000088888800800008000000000
007007000211882028811882028811200000000000000000000cc000000000000000000000000000000000000000000000000000008888000080080000000000
00000000025582200285582002285520000000000000000000000000000000000000000000000000000000000000000000000000000880000008800000000000
00000000002992000029920000299200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00899800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
089aa980000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
89a77a98000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9a7777a9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9a7777a9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
89a77a98000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
089aa980000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00899800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002b5502e550305502d5502a5502755023550205501d5501a550185501555012550105500d5500a55008550065500355001550005500b0000a000090000800007000060000500004000040000300002000
