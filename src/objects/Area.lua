--instantiate ONE per room
--manages all entities update, draw, add, remove, within a room 

Area = Object:extend()


function Area:new(room) 
    self.room = room 
    self.game_objects = {}
    self.enemyCount = 0
    self.enemyExsistFrame = true
    self.player = nil
    self.target = {}
    self.target_x = 0 
    self.target_y = 0
    self.camera_count = 0
end 

function Area:update(dt) 
    self.enemyCount = 0
    for i = #self.game_objects, 1, -1 do 
        local game_object = self.game_objects[i]
        if game_object.tag == "Enemy" and game_object.state ~= "DEAD" then 
            self.enemyCount = self.enemyCount + 1
        end 
    end  
    for i = #self.game_objects, 1, -1 do 
        local game_object = self.game_objects[i]
        if game_object.tag == "Enemy" and game_object.state ~= "DEAD" then
            --found player
            if self:CheckFound(self.player.x, self.player.y, game_object) == true then 
                game_object.foundbuffer = game_object.foundbuffer + 1
                if game_object.foundbuffer >= game_object.foundtime then 
                    game_object.state = "ATTACK"
                    self.room.state = "FOUND"
                    self.player.game = false
                    game_object.attackCount = 0
                    self.player.found = true
                    self.target_x = game_object.x
                    self.target_y = game_object.y
                end
            --found vip
            elseif self:CheckFound(self.player.vipx, self.player.vipy, game_object) == true then 
                game_object.foundbuffer = game_object.foundbuffer + 1
                if game_object.foundbuffer >= game_object.foundtime then 
                    game_object.state = "ATTACK"
                    self.room.state = "FOUND"
                    self.player.game = false
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
                self.target_x = self.player.x + self.player.camoffset_x
                self.target_y = self.player.y + self.player.camoffset_y
            end 
            if self.enemyCount <= 0.5 then
                if self.enemyExsistFrame then 
                    snd_alldead:stop()
                    snd_alldead:play()
                    self.room.music:stop()
                end 
                self.enemyExsistFrame = false
                --stop currently playing music like hotline miami
            end 
            if self.room.state == "GAME" then 
                --stop player input
                self.player.game = true
            end 

            --if vipx or vipy - playerx or player y is out of GAMEWIDTH or GAMEHEIGHT then self.room.state = "FOUND" and prompt restart
            local difx = math.abs(self.player.vipx - self.player.x)
            self.player.vipOutOfBound = false 
            if difx > GAMEWIDTH then 
                self.player.vipOutOfBound = true 
            end 


        elseif game_object.tag == "TitleScreen" then 
            camera:setFollowLerp(1.0)
            self.target_x = game_object.x + GAMEWIDTH/2
            self.target_y = game_object.y + GAMEHEIGHT/2
        elseif game_object.tag == "Door" then 
            if game_object.state == "OPEN" then 
                if self.player.x + GRID < game_object.x + (GRID*2) and
                   self.player.x + GRID > game_object.x and 
                   self.player.y + GRID < game_object.y + (GRID*2) and 
                   self.player.y + GRID > game_object.y then 
                        if self.player.state == "VIP" and self.player.hasKey then 
                            self.room.transition = true
                        end 
                end 
            end 
        elseif game_object.tag == "Key" then 
            --print(game_object.x)
            --print(self.player.x)
            if self.player.x + (GRID*0.5) < game_object.x + GRID and
                self.player.x + (GRID*0.5) > game_object.x and 
                self.player.y + (GRID*1.5) < game_object.y + GRID and 
                self.player.y + (GRID*1.5) > game_object.y then 
                    if self.player.hasKey == false then 
                        self.player.hasKey = true
                        game_object.semidead = true
                        game_object.pickuped = true
                    end 
            end 
        end 
        game_object:update(dt)
        if game_object.dead then table.remove(self.game_objects, i) end 
    end  
    self.attacked = false
    camera:follow(self.target_x, self.target_y)
end 

function Area:draw() 
    for _, game_object in ipairs(self.game_objects) do 
        if game_object.tag == "Tilemap" then game_object:draw() end 
    end 
    for _, game_object in ipairs(self.game_objects) do 
        if game_object.tag == "TitleScreen" or game_object.tag == "Door" or game_object.tag == "Key" then game_object:draw() end 
    end 
    for _, game_object in ipairs(self.game_objects) do 
        if game_object.tag == "Enemy" then game_object:draw() end 
    end 
    for _, game_object in ipairs(self.game_objects) do 
        if game_object.tag == "Player" then game_object:draw() end 
    end 
end 

function Area:addGameObject(game_object_type, x, y, a, b, c, d, e)
    local opts = opts or {}
    local game_object = _G[game_object_type](self, x or 0, y or 0,  a, b, c, d, e)
    if game_object_type == "Player" then self.player = game_object end
    --if game_object.tag == "Enemy" then self.enemyCount = self.enemyCount + 1 end
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

function Area:CheckFound(player_x, player_y, game_object)
    local enemy = game_object
    local px = player_x 
    local py = player_y
    local ex = enemy.x
    local ey = enemy.y 
    local max_check_distance = 16
    if py + (GRID*2) - 1 >= ey and py + GRID + 5 <= ey + (GRID*2) - 1 then 
        if enemy.facing < 0 and px < ex and enemy.state ~= "DEAD" then 
            local dif = (ex - (ex % GRID)) - (px - (px % GRID))
            local dift = dif/GRID
            if dift > max_check_distance then return false end 
            for i=1, dift-1 do 
                local tid = current_map:getAtPixel((px - (px % GRID))+(i*GRID), py + GRID + (GRID/2))
                if tid ~= 0 then 
                    return false
                end 
            end 
            return true
            
        elseif enemy.facing > 0 and px > ex and enemy.state ~= "DEAD" then 
            local dif = (px - (px % GRID)) - (ex - (ex % GRID))
            local dift = dif/GRID
            if dift > max_check_distance then return false end 
            for i=1, dift-1 do 
                local tid = current_map:getAtPixel(ex+(i*GRID), py + GRID + 1)
                if tid ~= 0 then 
                    return false
                end 
            end 
            return true

        elseif self.player.attacked == true and enemy.facing > 0 and px < ex then 
            local max_check_distance = 8
            local dif = (ex - (ex % GRID)) - (px - (px % GRID))
            local dift = dif/GRID
            print("dift :" .. dift .. " facing :" .. enemy.facing .. "id : " .. enemy.id)
            local succes = true
            if dift > max_check_distance then succes = false end 
            if succes == true then 
                for i=1, dift-1 do 
                    local tid = current_map:getAtPixel((px - (px % GRID))+(i*GRID), py + GRID + (GRID/2))
                    if tid ~= 0 then 
                        succes = false
                    end 
                end 
            end 
            if succes then 
                --attack succes
                enemy.state = "DEAD"
                snd_dead:stop()
                snd_dead:play()
            else

            end 
            
        elseif self.player.attacked == true and enemy.facing < 0 and px > ex then 
            local max_check_distance = 8
            local dif = (px - (px % GRID)) - (ex - (ex % GRID))
            local dift = dif/GRID
            print("dift :" .. dift .. " facing :" .. enemy.facing .. "id : " .. enemy.id)
            local succes = true
            if dift > max_check_distance then succes = false end 
            if succes == true then 
                for i=1, dift-1 do 
                    local tid = current_map:getAtPixel(ex+(i*GRID), py + GRID + 1)
                    if tid ~= 0 then 
                        succes = false
                    end 
                end 
            end 
            if succes then 
                enemy.state = "DEAD"
                snd_dead:stop()
                snd_dead:play()
            else 

            end 
        end 
    end
end 