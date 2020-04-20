Key = Entity:extend()

function Key:new(area, x, y)
    Key.super.new(self, area, x, y)
    self.tag = "Key"
    self.sprite = peachy.new("res/sprite/Key.json", "INITIAL")
    self.pickuped = false
    self.semidead = false
end 

function Key:update(dt)
    self.sprite:update(dt)
    if self.pickuped == true then 
        snd_key:stop()
        snd_key:play()
        self.pickuped = false
    end 
end 

function Key:draw()
    if self.semidead == false then 
        self.sprite:draw(self.x, self.y)
    end 
end 