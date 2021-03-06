local DPBR = require("love-DPBR")

local scene = DPBR.newScene(1280,720,50,10,10*9/16)
scene:setToneMapping("filmic")
scene:setAntiAliasing("FXAA")

local t_albedo = love.graphics.newImage("scene_albedo.jpg")
local t_normal = love.graphics.newImage("scene_normal.png")
local t_DE = love.graphics.newImage("scene_DE.exr")
local t_MR = love.graphics.newImage("scene_MR.jpg")

local function tick(dt)
end

local function draw()
  local time = love.timer.getTime()
  local x,y = love.mouse.getPosition()

  scene:bindMaterialPass()
  scene:bindMaterialN(t_normal)
  scene:bindMaterialMR(t_MR)
  scene:bindMaterialDE(t_DE)
  love.graphics.draw(t_albedo,0,0)

  scene:bindLightPass()

  scene:drawAmbientLight(0.2)
  scene:drawEmissionLight()

  scene:drawDirectionalLight(time%10/10*2-1,1,1,1)
  love.graphics.setColor(HSL(time/50%1, 1, 0.5))
  scene:drawPointLight(x/scene.w*10,y/scene.h*10*9/16,2,100,20)
  scene:drawPointLight(x/scene.w*10,y/scene.h*10*9/16,15,100,20)
  love.graphics.setColor(1,1,1)

  scene:render(0,0,0,1)
end

return tick, draw, "3D baked scene.\n\nModel by Andrew Maximov.\n(http://artisaverb.info/PBT.html)"
