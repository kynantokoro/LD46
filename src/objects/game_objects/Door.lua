Door = Entity:extend()

function Door:new(area, x, y, initial_tag)
    Door.super.new(self, area, x, y)
    self.tag = "Door"
    self.state = initial_tag
    self.sprite = peachy.new("res/sprite/Door.json", initial_tag)
end 

function Door:update(dt)
    self.sprite:update(dt)
end 

function Door:draw()
    self.sprite:draw(self.x, self.y)
end 