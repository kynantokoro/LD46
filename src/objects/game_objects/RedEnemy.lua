RedEnemy = Enemy:extend()

function RedEnemy:new(area, x, y, animation_path, initial_tag) 
    RedEnemy.super.new(self, area, x, y, animation_path, initial_tag)
end 

function RedEnemy:update(dt) 
    RedEnemy.super.update(self, dt)
end 

function RedEnemy:draw() 
    RedEnemy.super.draw(self)
end 