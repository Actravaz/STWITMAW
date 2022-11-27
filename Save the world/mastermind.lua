require("player")
require("enemy")
require("sound")

function waveset()
  change = true
  if wavealph >= 2 then
    change = false
  end
end

function mastermind_load()
  playing = false
  menu = true
  cutscene = false
  guide = false
  guideclip = 0
  scene = 0
  level = 0
  wave = 0
  read = false
  spawn = false
  switch = false
  wavealph = 0
  change = false
  change2 = false
  win = false
  winner = false
  deaded = false
  deaded2 = false
  paused = false
  trans = 0
  transfer = false
  --menusound:play()
end

function mastermind_keypressed(ke,scan)
  if ke == "l" then
    if deaded == true then
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

      playing = false
      menu = true
      cutscene = false
      guide = false
      guideclip = 0
      scene = 0
      level = 0
      wave = 0
      read = false
      spawn = false
      switch = false
      wavealph = 0
      change = false
      change2 = false
      win = false
      winner = false
      deaded = false
      deaded2 = false
      paused = false
      trans = 0
      transfer = false
    end
    if menu == true and playing == false and cutscene == false and guide == false and winner == false then
      cutscene = true
      scenesound:play()
      menu = false
    end
    if guide == true then
      guide = false
      playing = true
      read = true
    end

    if cutscene == true and scene == 5 then
      cutscene = false
      scenesound:stop()
      menu = false
      level = 1
      guide = true
    end

    if cutscene == true and scene == 8 then
      cutscene = false
      scenesound:stop()
      level = 100
      menu = false
      guide = false
      playing = false
      winner = true
    end

    if cutscene == true then
      switch = true
    end
  end
end

function mastermind_update()
  if player.dead == true and #souls == 0 and deaded2 == false then
    deaded = true
    losesound:play()
    playing = false
    deaded2 = true
  end
  if wavealph >= 2 and win == false then
    change = false
  elseif wavealph >= 2 and win == true then
    playing = false
    enemies = {}
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
    guide = false
    cutscene = false
    menu = false
    win = false
    wave = 0
    change = false

    wavealph = 0
  end

  if win == true then
    transfer = true
  end

  if playing == false and guide == false and cutscene == false and menu == false and deaded == false and level <= 4 then
    guide = true
    read = false
    spawn = false
    level = level + 1
  end

  if level == 5 then
    cutscene = true
    guide = false
    menu = false
    playing = false
    scenesound:play()
    scene = 6
    level = 0
  end


  if menu == false then
    menusound:stop()
  else
    menusound:play()
  end

  if winner == false then
    winsound:stop()
  else
    winsound:play()
  end

  if #enemies == 0 and read == true and playing == true and win == false then
    spawn = true
    read = false
  end

  if transfer == true then
    if wavealph > 1 and trans < 1.5 then
      trans = trans + 0.02
    end
    if trans >= 1.5 then
      transfer = false
    end
  else
    if trans > 0 then
      trans = trans - 0.02
    end
  end

  if spawn == true and playing == true and win == false then
    spawn = false
    wave = wave + 1
    if wave < 4 then
      if level == 1 then
        hornsound:play()
      end
      if level == 2 then
        flutesound:play()
      end
      if level == 3 then
        drumsound:play()
      end
      if level == 4 then
        flutesound:play()
        hornsound:play()
        drumsound:play()
      end
    end
    waveset()
    if level == 1 then
      if wave == 1 then
        for i = 1,5 do
            addenemy((200 * i) + 100, 2200, 1, "villagerfork",237)
        end
      end

      if wave == 2 then
        for i = 1,4 do
            addenemy((200 * i) + 100, 2500, 1, "villagerfork",237)
        end
        for i = 1,2 do
          addenemy((200 * i) + 100, 2000, 1, "villagertorch",190)
        end
      end

      if wave == 3 then
        for i = 1,5 do
            addenemy((200 * i) + 100, 2500, 1, "villagerfork",237)
        end
        for i = 1,3 do
          addenemy((200 * i) + 100, 2000, 1, "villagertorch",190)
        end
      end
    end

    if level == 2 then
      if wave == 1 then
        for i = 1,5 do
          addenemy((200 * i) + 100, -2200, 2, "knight",237)
        end
        for i = 1,1 do
          addenemy((200 * i) + 100, -2800, 1, "archer",320)
        end
      end

      if wave == 2 then
        for i = 1,6 do
          addenemy((200 * i) + 100, -2800, 1, "archer",320)
        end
      end

      if wave == 3 then
        for i = 1,7 do
          addenemy((200 * i) + 100, -2200, 2, "knight",237)
        end
        for i = 1,3 do
          addenemy((200 * i) + 100, -2800, 1, "archer",320)
        end
      end
    end

    if level == 3 then
      if wave == 1 then
        for i = 1,4 do
          addenemy((200 * i) + 100, -2600, 1, "assassin",340)
        end
        for i = 1,1 do
          addenemy((200 * i) + 150, -1500, 3, "ogre", 190)
        end
      end

      if wave == 2 then
        for i = 1,7 do
          addenemy((200 * i) + 100, -2800, 1, "assassin",340)
        end
      end

      if wave == 3 then
        for i = 1,5 do
          addenemy((200 * i) + 100, -2800, 1, "assassin",340)
        end
        for i = 1,3 do
          addenemy((200 * i) + 150, -2000, 3, "ogre", 190)
        end
      end
    end

    if level == 4 then
      if wave == 1 then
        for i = 1,3 do
          addenemy((200 * i) + 100, 2200, 1, "villagerfork",237)
          addenemy((200 * i) + 150, 2200, 2, "knight",237)
          addenemy((200 * i) + 200, 1500, 3, "ogre", 190)
        end
      end

      if wave == 2 then
        for i = 1,3 do
            addenemy((200 * i) + 100, 2000, 1, "villagertorch",190)
            addenemy((200 * i) + 150, 2800, 1, "archer",320)
            addenemy((200 * i) + 200, 2600, 1, "assassin",340)
        end
      end

      if wave == 3 then
        for i = 1,2 do
          addenemy((200 * i) + 100, 2200, 1, "villagerfork",237)
          addenemy((200 * i) + 150, 2200, 2, "knight",237)
          addenemy((200 * i) + 200, 1500, 3, "ogre", 190)
          addenemy((200 * i) + 250, 2000, 1, "villagertorch",190)
          addenemy((200 * i) + 300, 2800, 1, "archer",320)
          addenemy((200 * i) + 350, 2600, 1, "assassin",340)
        end
      end
    end

    if wave > 3 then
      win = true
      victorysound:play()
    end
  end
  if #enemies == 0 and win == false then
    read = true
  end
end

function mastermind_draw()
  if change == true then
    wavealph = wavealph + 0.01
    love.graphics.setColor(1,0,0,wavealph)
    if wave ~= 3 and (wave > 3) == false then
      love.graphics.print("Wave "..wave,love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    elseif wave == 3 then
      love.graphics.print("Final wave",love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    elseif wave > 3 then
      love.graphics.setColor(0,1,0,wavealph)
      love.graphics.print("You won",love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    end
    love.graphics.setColor(1, 1, 1, 1)
  elseif change == false and playing == true then
    love.graphics.setColor(1,0,0,wavealph)
    if wavealph > 0 then
      wavealph = wavealph - 0.01
    end
    if wave ~= 3 and (wave > 3) == false then
      love.graphics.print("Wave "..wave,love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    elseif wave == 3 then
      love.graphics.print("Final wave",love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

    love.graphics.setColor(1, 1, 1, 1)
  end
end
  love.graphics.setColor(0, 0, 0, trans)
  love.graphics.rectangle("fill", 0, 0, 3000, 3000)
  love.graphics.setColor(1,1,1,1)
end
