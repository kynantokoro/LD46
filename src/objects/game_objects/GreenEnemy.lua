GreenEnemy = Enemy:extend()

function GreenEnemy:new(area, x, y, animation_path, initial_tag) 
    GreenEnemy.super.new(self, area, x, y, animation_path, initial_tag)
end 

function GreenEnemy:update(dt) 
    GreenEnemy.super.update(self, dt)
end 

function GreenEnemy:draw() 
    GreenEnemy.super.draw(self)
end 