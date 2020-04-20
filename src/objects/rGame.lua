rGame = Object:extend()

function rGame:new()
    roomInit()

    self.transition = false
    self.state = "TRANSITION"
    self.t = 0
    self.pixelsize = 5

    self.key = peachy.new("res/sprite/key.json", "INITIAL")

end 

function rGame:update(dt) 

    if self.state == "TRANSITION" then 
        self.t = self.t + 0.1
        local size = self.pixelsize - self.t
        size = math.max(size, 0.0001)
        vEffect.pixelate.size = size
        if size == 0.0001 then 
            self.state = "GAME"
        end 
    end 

    if self.state == "FOUND" then 
        self.music:pause()
    end 

    self.key:update(dt)

    if self.transition == true then 
        self.t = self.t + 0.2 
        local size = math.min(self.t, self.pixelsize)
        vEffect.pixelate.size = size
        if size == self.pixelsize then
            self.state = "CHANGE"
        end 
    end

    if self.state == "CHANGE" then 
        roomInit()
        gotoRoom(self.next)
    end
end 

function rGame:draw() 
    if self.area.player.hasKey == true then 
        self.key:draw(10, 10)
    end 
end     