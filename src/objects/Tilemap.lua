--Base class for tilemap 

Tilemap = Entity:extend()

function Tilemap:new(area, x, y, map_path) 
    
    --get the path to the mapdata exported from tiled (with tileset embeded mode) 
    self.map_path = map_path

    current_map = self

    self.tag = "Tilemap"

    self.collisionlayer = nil

    self.area = area

    self.x = x 
    self.y = y

    self.map = require(self.map_path) 
    self.map_width = self.map.width 
    self.map_height = self.map.height 
    self.tile_width = self.map.tilewidth 
    self.tile_height = self.map.tileheight

    --get the tileset for the map
    self.tileset = self.map.tilesets[1]
    local tileset = self.tileset
    self.image = love.graphics.newImage("res/maps/" .. tileset.image)

    --set quads for the tileset image 
    self.quads = {}
    for y = 0, (self.tileset.imageheight / self.tileset.tileheight) - 1 do
        for x = 0, (self.tileset.imagewidth / self.tileset.tilewidth) - 1 do 
            local quad = love.graphics.newQuad(
                x * self.tileset.tilewidth,
                y * self.tileset.tileheight,
                self.tileset.tilewidth,
                self.tileset.tileheight,
                self.tileset.imagewidth, 
                self.tileset.imageheight
            )
            table.insert(self.quads, quad)
        end
    end 

    self.ForegroundBatch = love.graphics.newSpriteBatch(self.image, 128, "static")
    self.collisionBatch = love.graphics.newSpriteBatch(self.image, 128, "dynamic")
    self.BackgroundBatch = love.graphics.newSpriteBatch(self.image, 128, "static")

    --parse the tiled map data and create a single SpriteBatch drawable
    self.mapBatch = love.graphics.newSpriteBatch(self.image, 128, "static")
    for i, layer in ipairs(self.map.layers) do 
        if layer.type == "tilelayer" then 
            if layer.name == "Collision" then 
                self.collisionlayer = layer 
                for y = 0, layer.height - 1 do 
                    for x = 0, layer.width - 1 do 
                        local index = (x + y * layer.width) + 1
                        local tid = layer.data[index] 
                        --if index == self.enemymap[i] then tid = 1 end
                        
                        if tid ~= 0 then 
                            local quad = self.quads[tid]
                            local xx = x * self.tileset.tilewidth 
                            local yy = y * self.tileset.tileheight
                            
                            self.collisionBatch:add(
                                quad,
                                xx, 
                                yy
                            )
                            
                        end 
                    end 
                end 
            elseif layer.name == "Background" then 
                self.backgroundlayer = layer 
                for y = 0, layer.height - 1 do 
                    for x = 0, layer.width - 1 do 
                        local index = (x + y * layer.width) + 1
                        local tid = layer.data[index] 
                        
                        if tid ~= 0 then 
                            local quad = self.quads[tid]
                            local xx = x * self.tileset.tilewidth 
                            local yy = y * self.tileset.tileheight
                            
                            self.BackgroundBatch:add(
                                quad,
                                xx, 
                                yy
                            )
                            
                        end 
                    end 
                end 
            elseif layer.name == "Foreground" then 
                self.backgroundlayer = layer 
                for y = 0, layer.height - 1 do 
                    for x = 0, layer.width - 1 do 
                        local index = (x + y * layer.width) + 1
                        local tid = layer.data[index] 
                        
                        if tid ~= 0 then 
                            local quad = self.quads[tid]
                            local xx = x * self.tileset.tilewidth 
                            local yy = y * self.tileset.tileheight
                            
                            self.ForegroundBatch:add(
                                quad,
                                xx, 
                                yy
                            )
                            
                        end 
                    end 
                end 
            end
    
            --add objectgroup layer's object to the room
        elseif layer.type == "objectgroup" then 
            for i, object in ipairs(layer.objects) do 
                local game_object = object.type 
                local etype = object.properties["etype"]
                local animation_path = object.properties["animation_path"]
                local initial_tag = object.properties["initial_tag"]
                if game_object == "Player" then 
                    area:addGameObject(game_object, object.x, object.y, animation_path, initial_tag)
                elseif game_object == "Enemy" then 
                    if etype == "Red" then 
                        area:addGameObject("RedEnemy", object.x, object.y, animation_path, initial_tag)
                    elseif etype == "Green" then
                        area:addGameObject("GreenEnemy", object.x, object.y, animation_path, initial_tag)
                    end 
                elseif game_object == "Door" then 
                    area:addGameObject(game_object, object.x, object.y, initial_tag)
                elseif game_object == "Key" then 
                    area:addGameObject(game_object, object.x, object.y)
                end 
            end 
        end
    end

end 

function Tilemap:update(dt)

end 

function Tilemap:draw()
    love.graphics.draw(self.BackgroundBatch, math.floor(camera.x*0.5) - 50)
    love.graphics.draw(self.collisionBatch)
end 

function Tilemap:drawFront()
    love.graphics.draw(self.ForegroundBatch)
end 

function Tilemap:getAtPixel(x, y)
    local tx = math.floor(x / GRID)
    local ty = math.floor(y / GRID)
    local base_layer = self.collisionlayer
    if self.collisionlayer == nil then print("collision layer is nil") end 
    local index = (tx + ty * base_layer.width) + 1
    return base_layer.data[index]
end 

function Tilemap:getBounds() 
    return self.x, self.y, self.map.width * self.map.tilewidth, self.map.height * self.map.tileheight
end 