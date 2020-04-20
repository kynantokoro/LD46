rOne = rGame:extend()

function rOne:new()
    rOne.super.new(self)

    self.next = "rTwo"
    --initialize the room here!
    self.area = Area(self)

    vEffect.dmg.palette = "default"

    current_map = self.area:addGameObject("Tilemap", 0, 0, "res/maps/rOneMap")

    self.music = love.audio.newSource("res/tracker/LD46bgm.it", "stream")
    self.music:setEffect("myReverb")
    love.audio.stop()
    self.music:play()

    self.area.player.vipx = 178
    self.area.player.vipy = self.area.player.y - (GRID*2)
    self.area.player.vipfacing = -1

    self.area.player.hasKey = true
    self.dontDrawKey = true

    camera:setBounds(current_map:getBounds())
end 

function rOne:update(dt) 
    rOne.super.update(self, dt)
     
    self.area:update(dt) 
    
    camera:setFollowStyle("LOCKON")
    camera:update(dt)
    camera:setFollowLerp(0.15)

    if input:pressed("enter") then 
        gotoRoom("rOne")
    end 

    if input:pressed("space") and self.area.player.game == false then 
        gotoRoom("rOne")
    end 

end 

function rOne:draw() 
    vEffect(function()
        camera:attach()
        
        self.area:draw()

        camera:detach()

        rOne.super.draw(self)
    end)
end 