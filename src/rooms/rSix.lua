rSix = rGame:extend()

function rSix:new()
    rSix.super.new(self)

    self.next = "rSeven"
    --initialize the room here!
    self.area = Area(self)

    vEffect.dmg.palette = "second"

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rSixMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

    camera:setBounds(current_map:getBounds())
end 

function rSix:update(dt) 
    rSix.super.update(self, dt)

    self.area:update(dt)
    
    camera:setFollowStyle("LOCKON")
    camera:update(dt)
    camera:setFollowLerp(0.15)

    if input:pressed("enter") then 
        gotoRoom("rSix")
    end 
end 

function rSix:draw() 
    vEffect(function()
        camera:attach()
        
        self.area:draw()

        camera:detach()

        rSix.super.draw(self)
    end)
end 