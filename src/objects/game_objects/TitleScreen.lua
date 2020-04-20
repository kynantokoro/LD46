TitleScreen = Entity:extend()

function TitleScreen:new(area, x, y, image_path) 
    TitleScreen.super.new(self, area, x, y, image_path)

    self.tag = "TitleScreen"

    self.x = self.x
end 

function TitleScreen:update(dt) 

end 

function TitleScreen:draw()
    love.graphics.draw(self.image, self.x, self.y)
end 