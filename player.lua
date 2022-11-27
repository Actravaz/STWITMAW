require("sound")

function collide(x1,y1,w1,h1, x2,y2,w2,h2) --totally not copy and pasted from the love2d wiki mhm yup
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function createbullet(xpos,ypos,rad)
  bullet = {
    xpos = xpos,
    ypos = ypos,
    rad = rad,
    speedx = math.cos(rad) * 13,
    speedy = math.sin(rad) * 13
  }
  table.insert(bullets,bullet)
end


function player_load()
  love.window.setFullscreen(true)
  mousex = love.mouse.getX()
  mousey = love.mouse.getY()



  bullets = {}

  soundtick = 1
  soundtick2 = 1
  bulimg = love.graphics.newImage("assets/Bullet.png")
  firecd = false
  firetim = 0
  reloadcd = false
  reloadtim = 0



  player = {
    hand = love.graphics.newImage("assets/Hand.png"),
    img = love.graphics.newImage("assets/Knight.png"),
    soul = love.graphics.newImage("assets/Soul.png"),
    right = 0.8,
    ammo = 6,
    xpos = 0,
    ypos = 0,
    speed = 315,
    health = 2,
    candamage = true,
    dead = false,
    dmgcd = 0,
    angle = 0
  }


  player.angle = math.atan2(mousey - player.ypos, mousex - player.xpos)
end


function player_mousepressed(x, y, button)
  if firecd == false and player.ammo > 0 and player.dead == false then
    player.ammo = player.ammo - 1
    firecd = true
    Play(bulsound)
    createbullet(player.xpos + (math.cos(player.angle) * 30), ((player.ypos + 30) + (math.sin(player.angle) * 30)) - 15,player.angle)
  end
end


function player_update(dt)

  --Input stuff

  mousex = love.mouse.getX()
  mousey = love.mouse.getY()
  player.angle = math.atan2(mousey - player.ypos, mousex - player.xpos)
  if mousex > player.xpos then
    right = 0.8
  else
    right = -0.8
  end
  if love.keyboard.isDown("w") then
    player.ypos = player.ypos - player.speed * dt
  end
  if love.keyboard.isDown("s") then
    player.ypos = player.ypos + player.speed * dt
  end
  if love.keyboard.isDown("a") then
    player.xpos = player.xpos - player.speed * dt
  end
  if love.keyboard.isDown("d") then
    player.xpos = player.xpos + player.speed * dt
  end
  if love.keyboard.isDown("r") and reloadcd == false and player.dead == false then
    reloadcd = true
    firecd = true
    player.speed = 120
  end
  if love.keyboard.isDown("q") and reloadcd == true and player.dead == false then
    reloadcd = false
    reloadtim = 0
    firecd = false
    player.speed = 315
  end
  if love.keyboard.isDown("lshift") and reloadcd == false and player.dead == false then
    player.speed = 185
  elseif reloadcd == false then
    player.speed = 315
  end


  --Cd stuff


  if reloadcd == true and player.dead == false then
    reloadtim = reloadtim + 57 * dt
    if reloadtim >= 30 then
      Play(relsound)
      player.ammo = player.ammo + 1
      reloadtim = 0
    end
    if player.ammo >= 6 then
      player.speed = 315
      reloadcd = false
      reloadtim = 0
    end
  end
  if firecd == true and reloadcd == false and player.dead == false then
    firetim = firetim + 1
    if firetim == 10 then
      firecd = false
      firetim = 0
    end
  end

  if player.candamage == false and player.dead == false then
    player.dmgcd = player.dmgcd + 57 * dt
    if player.dmgcd >= 46 then
      player.candamage = true
      player.dmgcd = 0
    end

  end

  if player.health <= 0 then
    player.dead = true
  end

  --Ipair stuff

  for i,v in ipairs(bullets) do
    v.xpos = v.xpos + v.speedx
    v.ypos = v.ypos + v.speedy
    --[[if collide(player.xpos - 37, player.ypos - 30, 75, 75,v.xpos, v.ypos, 8, 8) then

    end]]
  end




  if player.xpos - 37 < 0 then
    player.xpos = 37
  end
  if player.xpos + 37 > love.graphics.getWidth() then
    player.xpos = love.graphics.getWidth() - 37
  end
  if player.ypos - 30 < 0 then
    player.ypos = 30
  end
  if player.ypos + 37 > love.graphics.getHeight() then
    player.ypos = love.graphics.getHeight() - 37
  end
end

function player_draw()

  for i,v in ipairs(bullets) do
    love.graphics.draw(bulimg,v.xpos,v.ypos,v.rad)
  end
  if player.dead == false then
    love.graphics.draw(player.img,player.xpos,player.ypos,0,right,0.8,43,60)
    love.graphics.draw(player.hand,player.xpos + (math.cos(player.angle) * 30),(player.ypos + 30) + (math.sin(player.angle) * 30),player.angle,0.8,right,20,28)
  end

end
