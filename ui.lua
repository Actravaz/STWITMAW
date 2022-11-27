require("player")
require("enemy")
require("mastermind")

function settrans()
  if transparency < 1 then
    transparency = transparency + 0.01
  end
end

function drawcutscene(text,img) --img should be 64 x 32
  love.graphics.setColor(1, 1, 1, transparency)
  love.graphics.print(text,30,750)
  love.graphics.draw(img,200,50)
  love.graphics.setColor(1,1,1,1)
end

function ui_load()
  cutsceneimg = {
    love.graphics.newImage("assets/cut1.png"),
    love.graphics.newImage("assets/cut2.png"),
    love.graphics.newImage("assets/cut3.png"),
    love.graphics.newImage("assets/cut4.png"),
    love.graphics.newImage("assets/cut5.png"),
    love.graphics.newImage("assets/cut6.png"),
    love.graphics.newImage("assets/cut7.png"),
    love.graphics.newImage("assets/cut7.png"),
    love.graphics.newImage("assets/cut7.png")
  }
  cutscenetext = {
    "Once upon a time, a young knight wanted to follow the same quest \n as his 512 well known siblings that saved the world from the xaranq",
    "When people heard of his quest, they laughed at him. they didn't\n think he would succeed considering how weak he was",
    "But that all changed when he stumbled upon an odd looking weapon",
    "A glock, a weapon of the outside world",
    "The knight was going to prove them all wrong once and for all",
    "As you walk into the castle, you feel a sense of pride. You're going\n to fight the xaranq after this long journey.",
    "You enter the treasure room and.... the xaranq isn't there?",
    "turns out the xaranq was too scared of your gun to fight you? I guess\n you saved the world???",
    ""
  }
  guidetext = {
    "As you begin your quest it looks like the villagers are pissed\n off that you're still trying.\n\n\n\n If a village with a pitchfork hits you, your helmet should\n protect you for a hit but if they have a torch then you're out\n of luck, But they do move slower since they need to be\n careful with their torch.\n\n\n R to reload, Lclick to fire, Shift to slow down and q to cancel\n reload. Good luck.",
    "A little while after you exit the village, you stumble upon the\n outside of a castle. It turns out the kingdom set out on the\n same quest as you but only one can claim the glory.\n\n\n\n The kingdom has archers and knights. The knights can resist\n a bullet and the archers are ranged. Good luck.",
    "After your well asserted dominance at the castle, you travel\n through the forest in hopes of reaching xaranq, but you soon\n discover that the forbidden green cuboids lie here.\n\n\n\n There are assasins which are faster than you and brutes that\n will smash you into the ground in one hit. Good luck?",
    "As you reach the castle xaranq resides in, it seems to be that\n everyone is teaming up to stop you. But why? Xaranq is so\n close yet so far",
  }
  titletext = {
    "Level 1: The Village",
    "Level 2: The Castle",
    "Level 3: The Forest",
    "Level 4: The Castle",
    ""
  }
  font = love.graphics.newFont("assets/Minecraft.ttf",40)
  font2 = love.graphics.newFont("assets/Minecraft.ttf",30)
  sign = love.graphics.newImage("assets/Sign.png")
  hp = love.graphics.newImage("assets/Health.png")
  hparmour = love.graphics.newImage("assets/HealthArmour.png")
  menuimg = love.graphics.newImage("assets/Menu.png")
  guideimg = love.graphics.newImage("assets/Guide.png")
  pauseimg = love.graphics.newImage("assets/Paused.png")
  winimg = love.graphics.newImage("assets/Win.png")
  loseimg = love.graphics.newImage("assets/Died.png")
  transparency = 0
end

function ui_update()
  if cutscene == true and switch == false then
    settrans()
  end
  if switch == true then
    switch = false
    transparency = 0
    scene = scene + 1
  end
end

function ui_draw()
  love.graphics.setFont(font)
  if playing == true then
    for i,v in ipairs(enemies) do
      for i = 1, v.health do
        if i == 1 then
          love.graphics.draw(hp,(v.xpos - 75) + (i * 20), v.ypos + 20,0,0.2,0.2)
        else
          love.graphics.draw(hparmour,(v.xpos - 75) + (i * 20), v.ypos + 20,0,0.2,0.2)
        end
      end
    end
    love.graphics.draw(sign,0,0,0,0.8,0.8)
    love.graphics.setColor(0.5, 0.3, 0, 1)
    love.graphics.print(player.ammo.."/6",125,120)
    love.graphics.setColor(1, 1, 1, 1)
    for i = 1, player.health do
      if i == 1 then
        love.graphics.draw(hp,300 + (75 * i), 20,0,0.8,0.8)
      else
        love.graphics.draw(hparmour,300 + (75 * i), 20,0,0.8,0.8)
      end
    end
  end
  if playing == false and menu == true then
    love.graphics.draw(menuimg,180,-150,0)
    love.graphics.setColor(0, 0.5, 0.35, 1)
    love.graphics.print("press L to play",570,750)
    love.graphics.setColor(1, 1, 1, 1)
  end
  if playing == false and winner == true then
    love.graphics.draw(winimg,490,120,0)
    love.graphics.setColor(0, 0.5, 0.35, 1)
    love.graphics.print("wow amazing you saved the world now buy our 30 sequels",140,750)
    love.graphics.setColor(1, 1, 1, 1)
  end
  if cutscene == true then
    drawcutscene(cutscenetext[scene],cutsceneimg[scene])
  end
  if guide == true then
    love.graphics.draw(guideimg,200,-25)
    love.graphics.setFont(font2)
    love.graphics.setColor(0.7, 0.3, 0, 1)
    love.graphics.print(guidetext[level],275,200)
    love.graphics.setFont(font)
    love.graphics.print(titletext[level],550,130)
    love.graphics.setColor(1, 1, 1, 1)
  end
  if paused == true then
    love.graphics.setColor(0,0,0,0.5)
    love.graphics.rectangle("fill", 0, 0, 3000, 3000)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(pauseimg,(love.graphics.getWidth() / 2) - 50,(love.graphics.getHeight() / 2) - 50)
  end
  if deaded == true then
    love.graphics.draw(loseimg,180)
    love.graphics.setColor(0.7, 0, 0, 1)
    love.graphics.print("Oh no you died well that sucks. press L to try again",140,750)
    love.graphics.setColor(1, 1, 1, 1)
  end
end
