rTwo = rGame:extend()

function rTwo:new()
    rTwo.super.new(self)

    self.next = "rThree"
    --initialize the room here!
    self.area = Area(self)

    vEffect.dmg.palette = "second"

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rTwoMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

    self.area.player.hasKey = true
    self.dontDrawKey = true

    camera:setBounds(current_map:getBounds())
end 

function rTwo:update(dt) 
    rTwo.super.update(self, dt)

    self.area:update(dt)
    
    camera:setFollowStyle("LOCKON")
    camera:update(dt)
    camera:setFollowLerp(0.15)

    if input:pressed("enter") then 
        gotoRoom("rTwo")
    end 

    if input:pressed("space") and self.area.player.game == false then 
        gotoRoom("rTwo")
    end 

end 

function rTwo:draw() 
    vEffect(function()
        camera:attach()
        
        self.area:draw()

        camera:detach()

        rTwo.super.draw(self)

    end)
    
end 