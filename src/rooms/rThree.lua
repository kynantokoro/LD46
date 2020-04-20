rThree = rGame:extend()

function rThree:new()
    rThree.super.new(self)

    self.next = "rFour"
    --initialize the room here!
    self.area = Area(self)

    vEffect.dmg.palette = "third"

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rThreeMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

    camera:setBounds(current_map:getBounds())
end 

function rThree:update(dt) 
    rThree.super.update(self, dt)

    self.area:update(dt)
    
    camera:setFollowStyle("LOCKON")
    camera:update(dt)
    camera:setFollowLerp(0.15)

    if input:pressed("enter") then 
        gotoRoom("rThree")
        --roomInit()
    end 
end 

function rThree:draw() 
    vEffect(function()
        camera:attach()
        
        self.area:draw()

        camera:detach()

        rThree.super.draw(self)

    end)
end 