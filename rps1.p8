pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
//main stuff

--today's tasks:
 --particle system
 --when option selected
   --some particle effect
 
function _init()
	start_game()
end

function _draw()
	if state=="start" then
	 drw_sg()
	end
	if state=="menu" then
	 drw_mg()
	end
	if state=="result" then
	 drw_fg()
	end
end

function _update()
 t+=1
 timer -= 1
 updparts()

	if state=="start" then
	 upd_sg()
	end
	if state=="menu" then
	 upd_mg()
	end
	if state=="result" then
	 upd_fg()
	end
end

//start game
function start_game()
	state="start"
	shake = 0
	t=0
	timer = 0
	
	sel1=0
	sel2=rand(2)
	
 r={
  x=0,
  y=8,
  h=16,
  w=16,
  px=36,
  py=64,
  id=1,
  a=0,
  s=1,
  col=4
 }

 p={
  x=16,
  y=8,
  h=16,
  w=16,
  px=72,
  py=64,
  id=2,
  a=0,
  s=1,
  col=13
 }

 s={
  x=32,
  y=8,
  h=16,
  w=16,
  px=56,
  py=96,
  id=3,
  a=0,
  s=1,
  col=2
 }
  
	stars={}
	for i=1,100 do
	 local nstars={}
	 nstars.x = flr(rnd(128))
	 nstars.y = flr(rnd(128))
	 nstars.col = 7
	 add(stars, nstars)
	end
	
	parts={}
 
end
-->8
//draw
function drw_sg()
 cls()
	print("placeholder ig for now",28,32,7)
 doshake()
	draw_stars()
 ani_stars(1.5,1.5,sel1)
end

function drw_mg()
 cls()
 doshake()
	draw_stars()
 ani_stars(1.5,1.5,sel1)
 
 sspr(r.x,r.y,r.w,r.h,r.px,r.py+sin(t/30))
 sspr(p.x,p.y,p.w,p.h,p.px,p.py+sin(t/31))
 sspr(s.x,s.y,s.w,s.h,s.px,s.py+sin(t/32))

 if sel1 == 1 then
  sspr(r.x,r.y,r.w,r.h,r.px,r.py+sin(t/30))
	 drawparts()
 end
 if sel1 == 2 then
  sspr(p.x,p.y,p.w,p.h,p.px,p.py+sin(t/31))
	 drawparts(p.x,p.y)
 end
 if sel1 == 3 then
  sspr(s.x,s.y,s.w,s.h,s.px,s.py+sin(t/32))
	 drawparts(s.x,s.y)
 end
end

function drw_fg()
 cls()
 doshake()
	draw_stars()
 ani_stars(1.5,1.5,sel1)
 
 print("p1 chose "..p1,32,64,7)
 print("p2 chose "..p2,32,70,7)

	print("result:",24,80,7)
	if p1==p2 then
	 print("game is a draw",24,86,7)
	else 
	 print(result(),24,86,7)
	end
	
	print("press 🅾️ to play again",28,98,7)

end
-->8
//update
function upd_sg()
 if btnp(🅾️) then
  state="menu"
  shake=2
 end
end

function upd_mg()
 if btn(⬅️) then
  sel1=r.id
  addparts(r.px+8,r.py+8,r.col)
  updparts()
  
  shake=1
 end
 if btn(➡️) then
  sel1=p.id
  addparts(p.px+8,p.py+8,p.col)
  updparts()
  shake=1
 end
 if btn(⬇️) then
  sel1=s.id
  addparts(s.px+8,s.py+8,s.col)
  updparts()
  shake=1
 end
 if btn(⬆️) then
  sel1=0
  shake=1
 end  
 
 if btn(❎) then
  state="result"
  shake=2
 end
end

function upd_fg()
 p1=ret_str(sel1)
	p2=ret_str(sel2)
	
	if btnp(🅾️) then
		state="menu"
		shake=2
  sel1=0
	end
end
-->8
//tools
function rand(i)
 p2=flr(rnd(i))+1
 return p2
end

function ret_str(sel)
	if sel==0 then
	 return "-----"
	end
	if sel==1 then
	 return "rock"
	end
	if sel==2 then
	 return "paper"
	end
	if sel==3 then
	 return "scissor"
	end
end

function result()
 if p1=="shield" and p2=="sword" or
    p1=="staff" and p2=="shield"or
    p1=="sword" and p2=="staff" then
  return "p1 wins!!!"
 else
  return "p2 wins!!!"
 end
end

function doshake()
 local shakex = rnd(shake)-rnd(shake/2)
 local shakey = rnd(shake)-rnd(shake/2)

 shakex *= shake
 shakey *= shake

 camera(shakex, shakey)
 
 shake *= 0.1
 if shake < 0.5 then
  shake=0
 end
end

function draw_stars()
 for i = 1,#stars do
 	local nstars = stars[i]
  pset(nstars.x,nstars.y,nstars.col)
 end
end

function ani_stars(xspd, yspd, sel1)
 for i = 1,#stars do
 	local nstars = stars[i]
		//spd depending on sel1
		if sel1 == 0 then
   nstars.x += 0
   nstars.y += yspd
   nstars.col = 7
   if nstars.y > 128 then
	   nstars.y -= 128
	  end
		elseif sel1 == 1 then
   nstars.x -= xspd
   nstars.y += 0
   nstars.col = 4
   if nstars.x < 0 then
	   nstars.x += 128
	  end
		elseif sel1 == 2 then
   nstars.x += 0
   nstars.y -= yspd
   nstars.col = 13
	  if nstars.y < 0 then
	   nstars.y += 128
	  end
		elseif sel1 == 3 then
   nstars.x += xspd
   nstars.y += 0
   nstars.col = 2
   if nstars.x > 128 then
	   nstars.x -= 128
	  end
		end  
 end
end

function addparts(px,py,col)
 for i=1,10 do
  local nparts = {}
  nparts.x = px
  nparts.y = py
  nparts.r = flr(rnd(5))
  nparts.col = col
  nparts.sx = rnd(2)-1
  nparts.sy = rnd(2)-1

  add(parts,nparts)
 end 
end

function drawparts()
 for i=1,#parts do
  local nparts = parts[i]
  circ(nparts.x,nparts.y,nparts.r,nparts.col)
 end 
end

function updparts()
 for i=1,#parts do
  local nparts = parts[i]
  nparts.x += nparts.sx
  nparts.y += nparts.sy
  nparts.r -= 0.3
 end
end
__gfx__
000000000055dd000077777700006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055dddd00775557000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070055ddddd50757770000060006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700055566ddd0775550000060006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000555566dd0757777088866660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700556566d50075557080880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000005666d500757777088080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006555007775770008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000177777666561000000001d100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000017777766656d1000000001d100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000011110000000017777776665dd100000001dd100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00001dddd1000000017111111165d1000000001dd100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001d6666d111000017777776665d1000111001dd100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001d666667ddd10001711117666610001888101dd111111000000000000000000000000000000000000000000000000000000000000000000000000000000000
0156666667d551000177777766661000800081666666666100000000000000000000000000000000000000000000000000000000000000000000000000000000
015666667dd55100017111111166100080008887d666611000000000000000000000000000000000000000000000000000000000000000000000000000000000
015d666ddd651000017777777666100080008118d111100000000000000000000000000000000000000000000000000000000000000000000000000000000000
0155ddd6666671000171111166661000188810181000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00156d66667761000177777766661000011101888100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001666666ddd1000171111111661000000018000810000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001ddd666dddd1001665555577661000000018000810000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001ddddddddd10001666666657661000000018000810000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001111dddd100001666666657710000000001888100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000001111000000166666665710000000000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
