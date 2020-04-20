rFour = rGame:extend()

function rFour:new()
    rFour.super.new(self)

    self.next = "rFive"
    --initialize the room here!
    self.area = Area(self)

    vEffect.dmg.palette = "fourth"

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rFourMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

    camera:setBounds(current_map:getBounds())
end 

function rFour:update(dt) 
    rFour.super.update(self, dt)

    self.area:update(dt)
    
    camera:setFollowStyle("LOCKON")
    camera:update(dt)
    camera:setFollowLerp(0.15)

    if input:pressed("enter") then 
        gotoRoom("rFour")
    end 

    if input:pressed("space") and self.area.player.game == false then 
        gotoRoom("rFour")
    end 

end 

function rFour:draw() 
    vEffect(function()
        camera:attach()
        
        self.area:draw()

        camera:detach()

        rFour.super.draw(self)
    end)
end 