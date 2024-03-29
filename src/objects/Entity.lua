--all dynamic class extends this class 
--which are player, enemy, item, anything with a position within the world

Entity = Object:extend()

function Entity:new(area, x, y, image_path)
    --add optional arguments as a table, and convert it in to a self.foo = value 
    --local opts = opts or {}
    --if opts then for k, v in pairs(opts) do self[k] = v end end 

    self.area = area 
    self.x = x 
    self.y = y 
    if image_path ~= nil then
        self.image = love.graphics.newImage(image_path)
    end 
    self.id = UUID()
    self.dead = false 
end 

function Entity:update(dt)
    
end 

function Entity:draw()
    
end 