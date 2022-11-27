
function sound_load()
  menusound = love.audio.newSource("audio/Menu.wav", "stream")
  winsound = love.audio.newSource("audio/Menu.wav", "stream")
  scenesound = love.audio.newSource("audio/cutscene.wav", "stream")
  hornsound = love.audio.newSource("audio/Horn.wav", "static")
  drumsound = love.audio.newSource("audio/Drum.wav", "static")
  flutesound = love.audio.newSource("audio/Flute.wav", "static")
  victorysound = love.audio.newSource("audio/Victory.wav","static")
  losesound = love.audio.newSource("audio/Lose.wav", "static")
  bulsound = {
    love.audio.newSource("audio/GunFire.wav", "static"),
    love.audio.newSource("audio/GunFire.wav", "static"),
    love.audio.newSource("audio/GunFire.wav", "static"),
    tick = 1
  }
  relsound = {
    love.audio.newSource("audio/Reload.wav", "static"),
    love.audio.newSource("audio/Reload.wav", "static"),
    love.audio.newSource("audio/Reload.wav", "static"),
    tick = 1
  }
  bowsound = {
    love.audio.newSource("audio/BowFire.wav", "static"),
    love.audio.newSource("audio/BowFire.wav", "static"),
    love.audio.newSource("audio/BowFire.wav", "static"),
    love.audio.newSource("audio/BowFire.wav", "static"),
    love.audio.newSource("audio/BowFire.wav", "static"),
  }
  dmgsound = {
    armourdestroy = {
      love.audio.newSource("audio/ArmourDestroy.wav", "static"),
      love.audio.newSource("audio/ArmourDestroy.wav", "static"),
      love.audio.newSource("audio/ArmourDestroy.wav", "static"),
      love.audio.newSource("audio/ArmourDestroy.wav", "static"),
      love.audio.newSource("audio/ArmourDestroy.wav", "static"),
      tick = 1
    },
    hit = {
      love.audio.newSource("audio/Hit.wav", "static"),
      love.audio.newSource("audio/Hit.wav", "static"),
      love.audio.newSource("audio/Hit.wav", "static"),
      love.audio.newSource("audio/Hit.wav", "static"),
      tick = 1
    }
  }
  for i,v in ipairs(dmgsound.armourdestroy) do
    v:setVolume(0.25)
  end
end

function Play(dir)
  dir[dir.tick]:play()
  dir.tick = dir.tick + 1
  if dir.tick > #dir - 1 then
    dir.tick = 1
  end
end
