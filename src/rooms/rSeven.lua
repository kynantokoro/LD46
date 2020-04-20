rSeven = rGame:extend()

function rSeven:new()
    rSeven.super.new(self)

    self.next = "rEnd"
    --initialize the room here!
    self.area = Area(self)

    vEffect.dmg.palette = "third"

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rSevenMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

    camera:setBounds(current_map:getBounds())
end 

function rSeven:update(dt) 
    rSeven.super.update(self, dt)

    self.area:update(dt)
    
    camera:setFollowStyle("LOCKON")
    camera:update(dt)
    camera:setFollowLerp(0.15)

    if input:pressed("enter") then 
        gotoRoom("rSeven")
    end 

    if input:pressed("space") and self.area.player.game == false then 
        gotoRoom("rSeven")
    end 

end 

function rSeven:draw() 
    vEffect(function()
        camera:attach()
        
        self.area:draw()

        camera:detach()

        rSeven.super.draw(self)
    end)
end 