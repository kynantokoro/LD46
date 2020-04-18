--instantiate ONE per room
--manages all entities update, draw, add, remove, within a room 

Area = Object:extend()


function Area:new(room) 
    self.room = room 
    self.game_objects = {}
    self.player = nil
    self.target = {}
    self.target_x = 0 
    self.target_y = 0
    self.camera_count = 0
end 

function Area:update(dt) 
    for i = #self.game_objects, 1, -1 do 
        local game_object = self.game_objects[i]
        if game_object.tag == "Enemy" then 
            if self:CheckFound(self.player, game_object) then 
                game_object.foundbuffer = game_object.foundbuffer + 1
                if game_object.foundbuffer >= game_object.foundtime then 
                    game_object.state = "ATTACK"
                    game_object.attackCount = 0
                    self.player.found = true
                    self.target_x = game_object.x
                    self.target_y = game_object.y
                end
            else
                game_object.foundbuffer = 0
            end 
        elseif game_object.tag == "Player" then 
            if self.player.found == false then 
                self.target_x = self.player.x
                self.target_y = self.player.y
            end 
        elseif game_object.tag == "TitleScreen" then 
            camera:setFollowLerp(1.0)
            self.target_x = game_object.x + GAMEWIDTH/2 + 12
            self.target_y = game_object.y + GAMEHEIGHT/2 + 16
        end 
        game_object:update(dt)
        if game_object.dead then table.remove(self.game_objects, i) end 
    end  
    camera:follow(self.target_x, self.target_y)

end 

function Area:draw() 
    for _, game_object in ipairs(self.game_objects) do game_object:draw() end 
end 

function Area:addGameObject(game_object_type, x, y, a, b, c, d, e)
    local opts = opts or {}
    local game_object = _G[game_object_type](self, x or 0, y or 0,  a, b, c, d, e)
    if game_object_type == "Player" then self.player = game_object end
    table.insert( self.game_objects, game_object)
    return game_object
end 

function Area:getGameObjects(callback)
    local match_objects = {}
    for i = #self.game_objects, 1, -1 do 
        local game_object = self.game_objects[i]
        if callback(game_object) == true then table.insert(match_objects, game_object) end 
    end
    return match_objects
end 

function Area:CheckFound(player, game_object)
    local player = player 
    local enemy = game_object
    local px = player.x 
    local py = player.y
    local ex = enemy.x
    local ey = enemy.y 
    if py + (GRID*2) - 1 >= ey and py + GRID <= ey + (GRID*2) - 1 then 
        if enemy.facing < 0 and px < ex then 
            local dif = (ex - (ex % GRID)) - (px - (px % GRID))
            local dift = dif/GRID
            print(dift)
            for i=1, dift-1 do 
                local tid = current_map:getAtPixel(px+i*GRID, py)
                if tid ~= 0 then 
                    return false
                end 
            end 
            return true
        elseif enemy.facing > 0 and px > ex then 
            local dif = (px - (px % GRID)) - (ex - (ex % GRID))
            local dift = dif/GRID
            print(dift)
            for i=1, dift-1 do 
                local tid = current_map:getAtPixel(ex+i*GRID, py)
                if tid ~= 0 then 
                    return false
                end 
            end 
            return true
        end 
    end
end 