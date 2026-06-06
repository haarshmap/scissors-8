pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function _init()
 start_game()
end

function _draw()
 if state=="start" then
  drw_start()
 end
 if state=="menu" then
  drw_menu()
 end 
 
 if state=="end" then
  drw_end()
 end 
end

function _update()
 if state=="start" then
  upd_start()
 end
 if state=="menu" then
  upd_menu()
 end
end
-->8
//start game
function start_game()
	state="start"
	shake = 0
	t=0
		
	//players
	p1={
	 hp=5,
	 dmg=1,
 	sel1=2,
 	atk=false,
	}
	p2={
	 hp=5,
	 dmg=1,
	 sel2=flr(rand(3)),
	 atk=true, 
	}
	
	//items
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
  nstars.sx = 1.5
  nstars.sy = 1.5
	 nstars.col = 7
	 nstars.r = (rnd(2))
	 add(stars,nstars)
	end
	
	parts={}
end
-->8
//draw
function drw_start()
 cls()
 print("p1.sel1:"..p1.sel1,56,8,7)
 print("p2.sel2:"..p2.sel2,56,16,7)

end

function drw_menu()
 cls()
 print("p1.atk:",16,8,7)
 print(p1.atk,16,16,7)
 print("p2.atk:",64,8,7)
 print(p2.atk,64,16,7)
 
 print("p1.hp:"..p1.hp,24,56,7)
 print("p2.hp:"..p2.hp,56,56,7)
 
end

function drw_end()
 cls()
end
-->8
//update
function upd_start()
 if btn(⬅️) then
  p1.sel1=1
 end
 if btn(➡️) then
  p1.sel1=3
 end
 if btn(⬇️) then
  p1.sel1=0
 end
 if btn(⬆️) then
  p1.sel1=2
 end  
 if btnp(🅾️) then
  state="menu"
  p1.atk = retout(p1.sel1,p2.sel2)
  if p1.atk == true then
   p2.atk = false
   p1atk()
  elseif p1.atk == false then
   p2atk()
  end
  if p1.hp == 0 or p2.hp == 0 then
   state="end"
  end  
 end
end


function upd_menu()
 if btnp(❎) then
  state = "start"
 end
 
end
-->8
//tools
function rand(i)
 r = rnd(i)+1
 return r
end

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
 p2.hp -= p1.dmg
 if p2.hp < 0 then
  p2.hp=0
 end
end

function p2atk()
 p1.hp -= p2.dmg
 if p1.hp < 0 then
  p1.hp=0
 end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
