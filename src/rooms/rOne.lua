rOne = Object:extend()

function rOne:new()
    graphicsInit()
    --initialize the room here!
    self.area = Area(self)

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rOneMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

end 

function rOne:update(dt) 
    self.area:update(dt)
    camera:update(dt)
end 

function rOne:draw() 

    camera:attach()
    
    self.area:draw()

    camera:detach()

end 