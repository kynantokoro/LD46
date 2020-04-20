rEnd = rGame:extend()

function rEnd:new()
    rEnd.super.new(self)

    self.next = "rTitle"
    --initialize the room here!
    self.area = Area(self)

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rEndMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

    camera:setBounds(current_map:getBounds())
end 

function rEnd:update(dt) 
    rEnd.super.update(self, dt)

    self.area:update(dt)
    
    camera:setFollowStyle("LOCKON")
    camera:update(dt)
    camera:setFollowLerp(0.15)

    if input:pressed("enter") then 
        gotoRoom("rEnd")
    end 
end 

function rEnd:draw() 

    camera:attach()
    
    self.area:draw()

    camera:detach()

end 