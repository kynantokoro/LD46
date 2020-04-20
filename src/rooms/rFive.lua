rFive = rGame:extend()

function rFive:new()
    rFive.super.new(self)

    self.next = "rSix"
    --initialize the room here!
    self.area = Area(self)

    vEffect.dmg.palette = "default"

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rFiveMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

    camera:setBounds(current_map:getBounds())
end 

function rFive:update(dt) 
    rFive.super.update(self, dt)

    self.area:update(dt)
    
    camera:setFollowStyle("LOCKON")
    camera:update(dt)
    camera:setFollowLerp(0.15)

    if input:pressed("enter") then 
        gotoRoom("rFive")
    end 
end 

function rFive:draw() 
    vEffect(function()
        camera:attach()
        
        self.area:draw()

        camera:detach()

        rFive.super.draw(self)
    end)
end 