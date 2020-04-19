rTitle = Object:extend()

function rTitle:new()


    --initialize the room here!
    self.area = Area(self)
    
    self.area:addGameObject("TitleScreen", 0, 0, "res/atlas/TitleScreen.png")

    self.music = love.audio.newSource("res/tracker/LD46music.it", "stream")
    love.audio.stop()
    self.music:play()

    self.state = "VIEW"

end 

function rTitle:update(dt) 
    self.area:update(dt)

    if input:pressed("reset") then 
        Timer.after(1, function() 
            self.state = "CHANGE"
        end)
    end 

    if self.state == "CHANGE" then 
        roomInit()
        gotoRoom("rOne")
    end 

    --[[
    local add_col = 0
    if math.random(0, 10) == 0 then add_col = math.sin(t)*5 end
    cEffect.chromasep.radius = 1 + add_col
    ]]
    camera:update(dt)
end 

function rTitle:draw() 

    camera:attach()
    
    self.area:draw()

    camera:detach()

end 