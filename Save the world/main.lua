--i'm not commenting until this reaches 6473 downloads

require("player")
require("ui")
require("sound")
require("enemy")
require("mastermind")

function love.load()
  sound_load()
  player_load()
  ui_load()
  enemy_load()
  mastermind_load()
  background1 = love.graphics.newImage("assets/grass.png")
  background2 = love.graphics.newImage("assets/grass2.png")
  background3 = love.graphics.newImage("assets/grass3.png")
  background4 = love.graphics.newImage("assets/grass4.png")

end


function love.mousepressed(x, y, button)
  player_mousepressed(x,y,button)
end

function love.keypressed(key, scancode)
  if key == "escape" then
    if paused == true then
      paused = false
    else
      paused = true
    end
  end
  mastermind_keypressed(key,scancode)
end


function love.update(dt)
  mastermind_update()
  if playing == true and menu == false and paused == false then
    enemy_update(dt)
    player_update(dt)
  end
  if playing == false then
    player.xpos = 300
    player.ypos = 300
    enemies = {}
  end
  ui_update()
end

function love.draw()
  if playing == true or guide == true and deaded == false then
    if level == 1 then
      love.graphics.draw(background1)
      love.graphics.draw(background1,448)
    elseif level == 2 then
      love.graphics.draw(background2)
      love.graphics.draw(background2,450)
    elseif level == 3 then
      love.graphics.draw(background3)
      love.graphics.draw(background3,450)
    elseif level == 4 then
      love.graphics.draw(background4)
      love.graphics.draw(background4,450)
    end
  end
  if playing == true then
    enemy_draw()
    player_draw()
  end
  if menu == true or winner == true then
    love.graphics.setBackgroundColor(0.65, 1, 0, 1)
  else
    love.graphics.setBackgroundColor(0, 0, 0, 1)
  end
  if deaded == true then
    love.graphics.setBackgroundColor(1,0.4,0.4,1)
  end
  ui_draw()
  mastermind_draw()
end
