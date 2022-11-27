require("player")
require("sound")

function getdistance(x1,y1,x2,y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
function getdistance2(x1,y1,x2,y2)
  return (x2 - x1)^2 + (y2 - y1)^2
end



function damageplayer(dmg)
  player.candamage = false
  if player.health > 1 then
    Play(dmgsound.armourdestroy)
  end
  player.health = player.health - dmg
end

function addenemy(xpos,ypos,hp,type,speed)
  enemy = {
    xpos = xpos,
    ypos = ypos,
    rad = 0,
    extcd = 0,
    speed = speed,
    right = 0.8,
    health = hp,
    type = type,
    ext = love.math.random(1, 30)
  }
  table.insert(enemies,enemy)
end

function createarrow(xpos,ypos,rad)
  arrow = {
    xpos = xpos,
    ypos = ypos,
    rad = rad,
    speedx = math.cos(rad) * 11,
    speedy = math.sin(rad) * 11
  }
  table.insert(arrows,arrow)
end

function addsoul(xpos,ypos,sped)
  soul = {
    xpos = xpos,
    ypos = ypos,
    tick = 0,
    tint = 1,
    speed = sped
  }
  table.insert(souls,soul)
end

function enemy_load()
  enemimg = {
    soul = love.graphics.newImage("assets/Soul.png"),
    vilf1 = love.graphics.newImage("assets/enemies/VillageFork1.png"),
    vilf2 = love.graphics.newImage("assets/enemies/VillageFork2.png"),
    vilf3 = love.graphics.newImage("assets/enemies/VillageFork3.png"),
    vilt1 = love.graphics.newImage("assets/enemies/VillageTorch1.png"),
    vilt2 = love.graphics.newImage("assets/enemies/VillageTorch2.png"),
    vilt3 = love.graphics.newImage("assets/enemies/VillageTorch3.png"),
    knight1 = love.graphics.newImage("assets/enemies/Knight1.png"),
    knight2 = love.graphics.newImage("assets/enemies/Knight2.png"),
    knight3 = love.graphics.newImage("assets/enemies/Knight3.png"),
    archer1 = love.graphics.newImage("assets/enemies/Archer1.png"),
    archer2 = love.graphics.newImage("assets/enemies/Archer2.png"),
    archer3 = love.graphics.newImage("assets/enemies/Archer3.png"),
    ogre = love.graphics.newImage("assets/enemies/Ogre.png"),
    assassin = love.graphics.newImage("assets/enemies/Assassin.png"),
  }
  arrowimg = love.graphics.newImage("assets/Arrow.png")
  enemies = {}
  souls = {}
  arrows = {}
  --addenemy((200 * i) + 100, 300, 1, "villagerfork",237)
  --addenemy((200 * i) + 100, 300, 1, "villagertorch",190)
  --addenemy((200 * i) + 100, 300, 2, "knight",237)
  --addenemy((200 * i) + 100, 300, 1, "archer",320)
  --addenemy((200 * i) + 100, 300, 3, "ogre", 190)
  --addenemy((200 * i) + 100, 300, 1, "assassin",340)
end

function enemy_update(dt)
  for i,v in ipairs(souls) do


    v.ypos = v.ypos - math.sin(v.tick) * v.speed
    v.tick = v.tick + 0.1
    v.tint = v.tint - 0.01 * v.speed
    if v.tick >= 3.3 then
      table.remove(souls,i)
    end
  end
  for i,v in ipairs(enemies) do
    v.extcd = v.extcd + 57 * dt

    if v.extcd >= 100 and v.type == "archer" then
      createarrow(v.xpos,v.ypos,math.atan2(v.ypos - player.ypos, v.xpos - player.xpos))
      v.extcd = 0
    end


    v.rad = math.atan2(v.ypos - player.ypos, v.xpos - player.xpos)
    for o, l in ipairs(enemies) do
      if v ~= l then
        if getdistance2(v.xpos,v.ypos,l.xpos,l.ypos) < 4000 then
          v.rad = v.rad + math.rad(getdistance2(v.xpos,v.ypos,l.xpos,l.ypos)) / 150
          l.rad = l.rad + math.rad(getdistance2(v.xpos,v.ypos,l.xpos,l.ypos)) / 150
        end
      end
    end
    if v.type ~= "archer" then
      v.xpos = v.xpos - math.cos(v.rad) * (v.speed * dt)
      v.ypos = v.ypos - math.sin(v.rad) * (v.speed * dt)
    end
    if v.xpos > player.xpos + 10 then
      v.right = -0.8
    else
      v.right = 0.8
    end
    if v.type == "archer" then
      local dist = getdistance2(player.xpos,player.ypos,v.xpos,v.ypos)
      if dist > 220000 then
        v.xpos = v.xpos - math.cos(v.rad) * (v.speed * dt)
        v.ypos = v.ypos - math.sin(v.rad) * (v.speed * dt)
      end
      if dist < 220000 and dist > 175000 then

      end
      if dist < 170000 then
        v.xpos = v.xpos + math.cos(v.rad) * (v.speed * dt)
        v.ypos = v.ypos + math.sin(v.rad) * (v.speed * dt)
      end
    end

    if v.type == "villagerfork" then
      if collide(player.xpos - 37, player.ypos - 30, 75, 75,v.xpos - 30,v.ypos - 30,60,60) and player.candamage == true then
        damageplayer(1)
      end
    end
    if v.type == "villagertorch" then
      if collide(player.xpos - 37, player.ypos - 30, 75, 75,v.xpos - 23,v.ypos - 23,60,60) and player.candamage == true then
        player.health = 0
      end
    end
    if v.type == "knight" then
      if collide(player.xpos - 37, player.ypos - 30, 75, 75,v.xpos - 37,v.ypos - 30,75,75) and player.candamage == true then
        damageplayer(1)
      end
    end
    if v.type == "ogre" then
      if collide(v.xpos - 40, v.ypos - 60, 80, 105,player.xpos - 37, player.ypos - 30, 75, 75) and player.candamage == true then
        player.health = 0
      end
    end
    if v.type == "assassin" then
      if collide(v.xpos - 31, v.ypos - 31, 65, 65,player.xpos - 37, player.ypos - 30, 75, 75) and player.candamage == true then
        damageplayer(1)
      end
    end
    for o,l in ipairs(bullets) do
      if collide(l.xpos,l.ypos,8,8,v.xpos - 30,v.ypos - 30,60,60) and v.type == "villagerfork" then
        table.remove(bullets,o)
        if v.health > 1 then
          Play(dmgsound.armourdestroy)
        end
        v.health = v.health - 1
      end
      if collide(l.xpos,l.ypos,8,8,v.xpos - 23,v.ypos - 23,60,60)  and v.type == "villagertorch" then
        table.remove(bullets,o)
        if v.health > 1 then
          Play(dmgsound.armourdestroy)
        end
        v.health = v.health - 1
      end
      if collide(l.xpos,l.ypos,8,8,v.xpos - 37,v.ypos - 30,75,75) and v.type == "knight" then
        table.remove(bullets,o)
        if v.health > 1 then
          Play(dmgsound.armourdestroy)
        end
        v.health = v.health - 1
      end
      if collide(l.xpos,l.ypos,8,8,v.xpos - 37,v.ypos - 30,75,75) and v.type == "archer" then
        table.remove(bullets,o)
        if v.health > 1 then
          Play(dmgsound.armourdestroy)
        end
        v.health = v.health - 1
      end
      if collide(l.xpos,l.ypos,8,8,v.xpos - 40, v.ypos - 60, 80, 105) and v.type == "ogre" then
        table.remove(bullets,o)
        if v.health > 1 then
          Play(dmgsound.armourdestroy)
        end
        v.health = v.health - 1
      end
      if collide(l.xpos,l.ypos,8,8,v.xpos - 31, v.ypos - 31, 65, 65) and v.type == "assassin" then
        table.remove(bullets,o)
        if v.health > 1 then
          Play(dmgsound.armourdestroy)
        end
        v.health = v.health - 1
      end
    end
    if v.health <= 0 then
      addsoul(v.xpos,v.ypos,3)
      Play(dmgsound.hit)
      table.remove(enemies,i)
    end
  end
  if player.health <= 0 and player.dead == false then
    addsoul(player.xpos,player.ypos,1)
    Play(dmgsound.hit)
  end



  for i,v in ipairs(arrows) do
    v.xpos = v.xpos - v.speedx
    v.ypos = v.ypos - v.speedy
    if collide(v.xpos - 22.5, v.ypos - 8.5, 35, 35,player.xpos - 37, player.ypos - 30, 75, 75) and player.candamage == true then
      damageplayer(1)
      table.remove(arrows,i)
    end
  end
end

function enemy_draw()
  for i,v in ipairs(souls) do
    love.graphics.setColor(1, 1, 1, v.tint)
    love.graphics.draw(enemimg.soul,v.xpos,v.ypos,0,0.8,0.8)
    love.graphics.setColor(1, 1, 1, 1)
  end
  for i,v in ipairs(enemies) do
    if v.type == "villagerfork" then
      if v.ext >= 1 and v.ext <= 10 then
        love.graphics.draw(enemimg.vilf1, v.xpos, v.ypos,0,v.right,0.8,60,45)
      end
      if v.ext >= 11 and v.ext <= 20 then
        love.graphics.draw(enemimg.vilf2, v.xpos, v.ypos,0,v.right,0.8,60,45)
      end
      if v.ext >= 21 and v.ext <= 30 then
        love.graphics.draw(enemimg.vilf3, v.xpos, v.ypos,0,v.right,0.8,60,45)
      end
    end

    if v.type == "villagertorch" then
      if v.ext >= 1 and v.ext <= 10 then
        love.graphics.draw(enemimg.vilt1, v.xpos, v.ypos,0,v.right,0.8,45,45)
      end
      if v.ext >= 11 and v.ext <= 20 then
        love.graphics.draw(enemimg.vilt2, v.xpos, v.ypos,0,v.right,0.8,45,45)
      end
      if v.ext >= 21 and v.ext <= 30 then
        love.graphics.draw(enemimg.vilt3, v.xpos, v.ypos,0,v.right,0.8,45,45)
      end
    end

    if v.type == "knight" then
      if v.ext >= 1 and v.ext <= 10 then
        love.graphics.draw(enemimg.knight1, v.xpos, v.ypos,0,v.right,0.8,43,60)
      end
      if v.ext >= 11 and v.ext <= 20 then
        love.graphics.draw(enemimg.knight2, v.xpos, v.ypos,0,v.right,0.8,43,60)
      end
      if v.ext >= 21 and v.ext <= 30 then
        love.graphics.draw(enemimg.knight3, v.xpos, v.ypos,0,v.right,0.8,43,60)
      end
    end
    if v.type == "archer" then
      if v.ext >= 1 and v.ext <= 10 then
        love.graphics.draw(enemimg.archer1, v.xpos, v.ypos,0,v.right,0.8,43,60)
      end
      if v.ext >= 11 and v.ext <= 20 then
        love.graphics.draw(enemimg.archer2, v.xpos, v.ypos,0,v.right,0.8,43,60)
      end
      if v.ext >= 21 and v.ext <= 30 then
        love.graphics.draw(enemimg.archer3, v.xpos, v.ypos,0,v.right,0.8,43,60)
      end
    end
    if v.type == "ogre" then
      love.graphics.draw(enemimg.ogre,v.xpos,v.ypos,0,v.right,0.8,105,85)
    end
    if v.type == "assassin" then
      love.graphics.draw(enemimg.assassin, v.xpos, v.ypos, 0, v.right, 0.8,45,50)
    end
  end


  for i,v in ipairs(arrows) do
    love.graphics.draw(arrowimg,v.xpos,v.ypos,v.rad + 9.4,0.8,0.8,45,17)
  end
end
