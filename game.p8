pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
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
	if state=="buff" then
	 drw_buff()
	end
	if state=="result" then
	 drw_res()
	end
	if state=="end" then
	 drw_end()
	end
end

function _update()
 updparts()
 
	if state=="start" then
	 upd_sg()
	end
	if state=="menu" then
	 upd_mg()
 if sp<3.9 then
  sp+=.1
 else
  sp=1
 end
	 p1.hp-=0.1
	 if p1.hp < 0 then
	  p1.hp = 0 
	  state = "end"
	 end
	end
	if state=="result" then
	 upd_res()
	 p1.hp-=0.1
	 if p1.hp < 0 then
	  p1.hp = 0 
	  state = "end"
	 end
	 if boss.hp < 0 then
	  boss.hp = 0 
	  timer = 500
	  state = "buff"
	 end
	end
	if state=="buff" then
	 upd_buff()
	 p1.hp-=0.1
	 if p1.hp < 0 then
	  p1.hp = 0 
	  state = "end"
	 end
	end
	if state=="end" then
	 upd_end()
	end
end

-->8
//start game
function start_game()
	state="start"
	shake = 0
	t=0
 
 //animate
 sp=1
 arr={1,3,5}
	
	//players
	p1={
	 hp=100,
	 dmg=1,
 	sel1=2,
 	atk=false,
	}
	boss={
	 hp=1,
	 thp=5,
	 dmg=1,
	 sel2=flr(rand(3)),
	}
	
	//items
 r={
  n=1,
  h=2,
  w=2,
  px=36,
  py=64,
  id=1,
  a=0,
  s=1,
  col=4
 }
 p={
  n=3,
  h=2,
  w=2,
  px=72,
  py=64,
  id=2,
  a=0,
  s=1,
  col=13
 }
 s={
  n=5,
  h=2,
  w=2,
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
  nstars.sx = 1.5
  nstars.sy = 1.5
	 nstars.col = 7
	 nstars.r = (rnd(2))
	 add(stars,nstars)
	end
	
	rct1={
	 x1=12,
	 y1=118,
	 x2=114,
	 y2=124,
	}
	rct2={
	 x1=12,
	 y1=2,
	 x2=64,
	 y2=8,
	 barw=48
	}
	
	parts={}
end
-->8
//draw
function drw_sg()
 cls()
 print("state:"..state,0,8,7)
 print("p1.sel1:"..p1.sel1,0,16,7)
 print("boss.sel2:"..boss.sel2,0,24,7)

	print("placeholder ig for now",28,32,7)
 doshake()
	draw_stars()
 ani_stars(p1.sel1)
end

function drw_mg()
 cls()
 print("state:"..state,0,8,7)
 print("p1.sel1:"..p1.sel1,0,16,7)
 print("boss.sel2:"..boss.sel2,0,24,7)
 print("frames:"..arr[flr(n)],0,32,7)

 doshake()
	draw_stars()
 ani_stars(p1.sel1)

	spr(arr[flr(sp)],54,32,2,2)

 if p1.sel1 == 1 then
  spr(r.n,r.px,r.py+sin(t/30),r.w,r.h)
	 drawparts()
 end
 if p1.sel1 == 2 then
  spr(p.n,p.px,p.py+sin(t/30),p.w,p.h)
	 drawparts(p.x,p.y)
 end
 if p1.sel1 == 3 then
  spr(s.n,s.px,s.py+sin(t/30),s.w,s.h)
	 drawparts(s.x,s.y)
 end
  
 spr(r.n,r.px,r.py+sin(t/30),r.w,r.h)
 spr(p.n,p.px,p.py+sin(t/30),p.w,p.h)
 spr(s.n,s.px,s.py+sin(t/30),s.w,s.h)

 print("p1.hp:"..p1.hp,24,56,7)
 print("boss.hp:"..boss.hp,24,48,7)


 drw_hp(rct1.x1,rct1.y1,rct1.x2,rct1.y2,p1.hp)

end 	

function drw_res()
 cls()
 print("state:"..state,0,8,7)
 print("p1.sel1:"..p1.sel1,0,16,7)
 print("boss.sel2:"..boss.sel2,0,24,7)

 doshake()
	draw_stars()
 ani_stars(p1.sel1)
  
 print("p1.hp:"..p1.hp,24,56,7)
 print("boss.hp:"..boss.hp,24,48,7)

 drw_hp(rct1.x1,rct1.y1,rct1.x2,rct1.y2,p1.hp)

end

function drw_buff()
 cls()
 doshake()
	draw_stars()
 ani_stars(p1.sel1)
 
 print("state:"..state,0,8,7)
 print("p1.sel1:"..p1.sel1,0,16,7)
 print("p1.dmg:"..p1.dmg,0,24,7)
 print("boss.sel2:"..boss.sel2,0,32,7)


 spr(r.n,r.px,r.py+sin(t/30),r.w,r.h)
 spr(p.n,p.px,p.py+sin(t/30),p.w,p.h)
 spr(s.n,s.px,s.py+sin(t/30),s.w,s.h)
 drw_hp(rct1.x1,rct1.y1,rct1.x2,rct1.y2,p1.hp)

end

function drw_end()
 cls()
 print("state:"..state,0,8,7)
 print("p1.sel1:"..p1.sel1,0,16,7)
 print("p1.dmg:"..p1.dmg,0,24,7)
 print("boss.sel2:"..boss.sel2,0,32,7)
 print("game over",76,76,7)
 
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
  p1.sel1=r.id
  addparts(r.px+8,r.py+8,r.col)
  updparts()
  sfx(0)
  shake=1
 end
 if btn(➡️) then
  p1.sel1=p.id
  addparts(p.px+8,p.py+8,p.col)
  updparts()
  sfx(0)
  shake=1
 end
 if btn(⬇️) then
  p1.sel1=s.id
  addparts(s.px+8,s.py+8,s.col)
  updparts()
  sfx(0)
  shake=1
 end
 if btn(⬆️) then
  p1.sel1=0
  shake=1
 end  
 if btnp(❎) then
  boss.sel2 = flr(rand(3))
  p1.atk = retout(p1.sel1,boss.sel2)
  if p1.atk == true then
   p1atk()
   rct2.barw = rct2.barw*(boss.hp/boss.thp)

  elseif p1.atk == false then
   p2atk()
  end 
  state="result"
 end
 if p1.hp == 0 then
  state="end"
 end
 if boss.hp == 0 then
  state="buff"
 end
 n=5
 if n<4 then 
  n=n+1
 else
  n=1
 end
end

function upd_buff()
 if btn(⬅️) then
  p1.sel1=r.id
  addparts(r.px+8,r.py+8,r.col)
  updparts()
  sfx(0)
  shake=1
 end
 if btn(➡️) then
  p1.sel1=p.id
  addparts(p.px+8,p.py+8,p.col)
  updparts()
  sfx(0)
  shake=1
 end
 if btn(⬇️) then
  p1.sel1=s.id
  addparts(s.px+8,s.py+8,s.col)
  updparts()
  sfx(0)
  shake=1
 end
 if btn(⬆️) then
  p1.sel1=0
  shake=1
 end   
 if btnp(🅾️) then
   if p1.hp <= 80 and sel1 == 1 then
    p1.hp += 20
   end
   if p1.sel1 == 2 then

   end
   if p1.sel1 == 3 then
    p1.dmg += 3
   end
  boss.hp += boss.thp
  boss.dmg += 5
  state="menu"
 end
end 

function upd_res()
 if btnp(🅾️) then
  state = "menu"
  boss.sel2 = flr(rand(3))
 end
end

function upd_end()
 if btnp(🅾️) then
  state="start"
  start_game()
 end
end
-->8
//game logic
function retout(sel1,sel2)
 if sel1 == 0 or sel1 == sel2 then
  return false
 end 
 if sel1 == 1 and sel2 == 3 or
    sel1 == 2 and sel2 == 1 or
    sel1 == 3 and sel2 == 2 then
  return true
 else
  return false 
 end
end 

function p1atk()
 boss.hp -= p1.dmg
 if boss.hp < 0 then
  boss.hp=0
 end
end

function p2atk()
 p1.hp -= boss.dmg
 if p1.hp < 0 then
  p1.hp=0
 end
end


-->8
//tools
function rand(i)
 p2=flr(rnd(i))+1
 return p2
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
   circ(nstars.x,nstars.y,nstars.r,nstars.col)
 end
end

function ani_stars(sel1)
 for i = 1,#stars do
 	local nstars = stars[i]
		//spd depending on sel1
		if sel1 == 0 then
   nstars.x += 0
   nstars.y -= nstars.sy
   nstars.col = 7
   if nstars.y < 0 then
	   nstars.y += 128
	  end
		elseif sel1 == 1 then
   nstars.x -= nstars.sx
   nstars.y += 0
   nstars.col = 4
   if nstars.x < 0 then
	   nstars.x += 128
	  end
		elseif sel1 == 2 then
   nstars.x += nstars.sx
   nstars.y += 0
   nstars.col = 13
   if nstars.x > 128 then
	   nstars.x -= 128
	  end
		elseif sel1 == 3 then
   nstars.x += 0
   nstars.y += nstars.sy
   nstars.col = 2
   if nstars.y > 128 then
	   nstars.y -= 128
	  end
		end  
 end
end

function addparts(px,py,col)
 for i=1,10 do
  local nparts = {}
  nparts.x = px
  nparts.y = py
  nparts.r = flr(rnd(6))
  nparts.decay = 0.2
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
  nparts.r -= nparts.decay
 end
end

function drw_hp(x1,y1,x2,y2,barw)
 rect(x1,y1,x2,y2,7) 
 rectfill(x1+2,y1+2,x1+2+barw,y2-2,11) 
end

__gfx__
000000000000000000000000000177777666561000000001d1000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000017777766656d1000000001d1000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000111100000017777776665dd100000001dd1000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000001dddd10000017111111165d1000000001dd1000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000111d6666d1000017777776665d1000111001dd1000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001ddd766666d10001711117666610001888101dd1111110000000000000000000000000000000000000000000000000000000000000000000000000
0000000000155d766666651001777777666610008000816666666661000000000000000000000000000000000000000000000000000000000000000000000000
0000000000155dd766666510017111111166100080008887d6666110000000000000000000000000000000000000000000000000000000000000000000000000
00000000000156ddd666d510017777777666100080008118d1111000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001766666ddd551001711111666610001888101810000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000016776666d6510001777777666610000111018881000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001ddd666666100001711111116610000000180008100000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001dddd666ddd10016655555776610000000180008100000000000000000000000000000000000000000000000000000000000000000000000000000
000000000001ddddddddd10016666666576610000000180008100000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000001dddd111100016666666577100000000018881000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000001111000000001666666657100000000001110000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000000025050270502a0502b050280502015000150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
