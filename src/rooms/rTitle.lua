rTitle = rGame:extend()

function rTitle:new()
    rTitle.super.new(self)

    self.next = "rOne"

    self.isTitle = true

    --initialize the room here!
    self.area = Area(self)

    local palettes = {
        "default",
        "second",
        "third",
        "fourth",
    }

    love.math.setRandomSeed(love.timer.getTime())
    local randi = math.floor(love.math.random(4))

    vEffect.dmg.palette = palettes[randi]
    
    self.area:addGameObject("TitleScreen", 0, 0, "res/atlas/TitleScreen.png")

    self.music = love.audio.newSource("res/tracker/LD46music.it", "stream")
    love.audio.stop()
    self.music:play()

    self.transition = false

    self.t = 0
    self.pixelsize = 5
end 

function rTitle:update(dt)
    rTitle.super.update(self, dt)

    self.area:update(dt)

    if input:pressed("space") then
        self.transition = true
    end 

    --[[
    local add_col = 0
    if math.random(0, 10) == 0 then add_col = math.sin(t)*5 end
    cEffect.chromasep.radius = 1 + add_col
    ]]
    camera:update(dt)
end 

function rTitle:draw() 
    vEffect(function()
        --camera:attach()
        
        self.area:draw()

        --camera:detach()
    end)
end 