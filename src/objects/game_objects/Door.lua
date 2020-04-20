Door = Entity:extend()

function Door:new(area, x, y, initial_tag)
    Door.super.new(self, area, x, y)
    self.tag = "Door"
    self.state = initial_tag
    self.notOpen = true
    self.played = false 
    self.sprite = peachy.new("res/sprite/Door.json", initial_tag)
    self.lock = peachy.new("res/sprite/key.json", "LOCK")
    self.drawLock = true
end 

function Door:update(dt)

    if self.area.room.dontDrawKey == true then 
        self.drawLock = false 
    end 

    if self.state == "OPEN" and self.notOpen then 
        self.sprite:setTag("CLOSE")
        self.lock:update(dt)
        self.sprite:update(dt)
    elseif self.state == "OPEN" and self.notOpen == false then
        if self.played == false then 
            snd_door:stop() 
            snd_door:play() 
            self.played = true
        end
        
        self.sprite:setTag("OPEN")
        self.sprite:update(dt)
    end 
end 

function Door:draw()
    self.sprite:draw(self.x, self.y)
    if self.state == "OPEN" and self.notOpen and self.drawLock then 
        self.lock:draw(self.x + 4, self.y - GRID)
    end 
end 