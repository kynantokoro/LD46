Player = Entity:extend()

function Player:new(area, x, y, animation_path, animation_tag)
    Player.super.new(self, area, x, y)

    self.tag = "Player"
    self.colmap = current_map
    self.sprite = peachy.new(animation_path, animation_tag)
    self.vipx = self.x 
    self.vipy = self.y
    self.vipimage = peachy.new("res/sprite/Vip.json", "IDLE")
    self.facing = 1
    self.walk_spd = 0.3
    self.hsp = 0
    self.max_hsp = 4
    self.vsp = 0
    self.drag = 0.35
    self.hsp_decimal = 0
    self.vsp_decimal = 0
    self.attacked = false
    self.stabs = 0
    self.stabs_time = 0
    self.stabs_cooldown = 120
    self.jumps = 0
    self.jump_spd = -3.8
    self.VIPjump_spd = -2.8
    self.jumps_initial = 3 
    self.VIPjumps_initial = 1
    self.found = false
    self.camoffset_x = 0
    self.camoffset_y = 0
    self.offset_buffer = 0 
    self.offset_buffer_y = 0 
    self.collision_buffer = 0
    self.collision_buffer_y = 0
    self.states = {}
    local VIP = {
        update = function(dt) 

            self.max_hsp = 2
            self.walk_spd = 0.2
            
            self:calculateMovement()

            if self:onGround() then self.jumps = self.VIPjumps_initial end
            if input:pressed("up") then 
                self:VIPjumped()
            end 

            if self.hsp ~= 0 then 
                snd_walking:play()
            end 

            self:Collisions()

            self.sprite:update(dt)
            self.vipx = self.x 
            self.vipy = self.y
            self.offset_buffer_y = 0
        end,
        draw = function()
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + (GRID*2) end
            self.sprite:draw(draw_x, self.y, 0, self.facing)
        end 
    }
    local IDLE = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2

            self:calculateMovement()

            if self:onGround() then self.jumps = self.jumps_initial end
            if input:pressed("up") then 
                self:jumped()
            end 

            self:Collisions()

            if self.hsp ~= 0 then 
                self.state = "WALK"
            end 

            self.sprite:update(dt)
            self.vipimage:update(dt)
        end, 
        draw = function() 
            self.vipimage:draw(self.vipx, self.vipy)
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing)
        end 
    }
    local WALK = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2



            snd_walking:play()

            self:calculateMovement()

            if self:onGround() then self.jumps = self.jumps_initial end
            if input:pressed("up") then 
                self:jumped()
            end 

            self:Collisions()

            if self.hsp == 0 then 
                self.state = "IDLE"
            end 

            self.sprite:update(dt)
            self.vipimage:update(dt)
        end, 
        draw = function() 
            self.vipimage:draw(self.vipx, self.vipy)
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing)
        end 
    }
    local JUMP = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2

            self:calculateMovement() 

            if self:onGround() then self.jumps = self.jumps_initial end
            if input:pressed("up") then 
                self:jumped()
            end

            if self:onGround() then 
                self.state = "IDLE" 
                snd_landing:stop()
                snd_landing:play()
            end

            self:Collisions()

            self.sprite:update(dt)
            self.vipimage:update(dt)
        end, 
        draw = function() 
            self.vipimage:draw(self.vipx, self.vipy)
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing)
        end 
    }
    local VIPJUMP = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2

            self:calculateMovement() 

            if self:onGround() then self.jumps = self.VIPjumps_initial end
            if input:pressed("up") then 
                self:VIPjumped()
            end

            if self:onGround() then 
                self.state = "VIP" 
                snd_landing:stop()
                snd_landing:play()
            end

            self:Collisions()

            self.sprite:update(dt)
            self.vipimage:update(dt)
        end, 
        draw = function() 
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + (GRID*2) end
            self.sprite:draw(draw_x, self.y, 0, self.facing)
        end 
    }
    self.states["VIP"] = VIP 
    self.states["IDLE"] = IDLE 
    self.states["WALK"] = WALK 
    self.states["JUMP"] = JUMP
    self.states["VIPJUMP"] = VIPJUMP
    self.state = animation_tag
end 

function Player:update(dt)
    if input:pressed("down") then
        if self.state == "VIP" and self:onGround() then
            self.state = "IDLE"
            snd_pickdown:play()
            self.sprite:setTag("IDLE")
        elseif self.state == "IDLE" then 
            if self.x >= self.vipx - GRID and self.x <= self.vipx + GRID and self.y >= self.vipy - GRID and self.y <= self.vipy + GRID then 
                self.state = "VIP" 
                snd_pickup:play()
                self.sprite:setTag("VIP")
            end 
        end 
    end 

    if input:pressed("space") then 
        if self.state ~= "VIP" and self.state ~= "VIPJUMP" then 
            self:stabbed()
        end 
    end 

    self.states[self.state].update(dt)

    if self.found == true then 
        cEffect.desaturate.strength = 0.5
        camera.rotation = math.sin(t*0.1) * 0.1
        camera.scale = 1 + math.sin(t*0.175) * 0.05
    end 

    self.stabs_time = self.stabs_time + 1

    print(self.stabs_time)

end 

function Player:draw()
    self.states[self.state].draw()
    love.graphics.print(self.state, self.x, self.y)
    love.graphics.print(self.jumps, self.x, self.y+10)
    love.graphics.line(self.x, self.y + (GRID*2) - 1, self.x+10, self.y + (GRID*2) - 1)
    love.graphics.line(self.x, self.y + (GRID) + 5, self.x+10, self.y + (GRID) + 5)
end 

function Player:calculateMovement()
    
    local isDrag = false

    --calculate horizontal movement
    if input:down("left") and input:down("right") then 
        isDrag = true
    elseif input:down("left") then 
        self.hsp = self.hsp - self.walk_spd
        isDrag = false 
    elseif input:down("right") then 
        self.hsp = self.hsp + self.walk_spd
        isDrag = false 
    else 
        isDrag = true
    end 
    --apply gravity 
    self.vsp = self.vsp + GRAVITY 

    --stop if hsp is low
    if math.abs(self.hsp) <= 0.1 then self.hsp = 0 end 

    --drag the charactor (as if on ice)
    if isDrag == true then self.hsp = lerp(self.hsp, 0, self.drag) end 

    --calculate face
    if self.hsp ~= 0 then self.facing = sign(self.hsp) end 

    --limit speed 
    self.hsp  = math.min(math.abs(self.hsp), self.max_hsp) * self.facing
end 

function Player:Collisions() 
    --collisions!!
    if self.hsp == 0 then self.hsp_decimal = 0 end 
    if self.vsp == 0 then self.vsp_decimal = 0 end 

    --apply carried over decimals
    self.hsp = self.hsp + self.hsp_decimal
    self.vsp = self.vsp + self.vsp_decimal
    --floor decimals
    self.hsp_decimal = self.hsp - (math.floor(math.abs(self.hsp)) * sign(self.hsp))
    self.hsp = self.hsp - self.hsp_decimal
    self.vsp_decimal = self.vsp - (math.floor(math.abs(self.vsp)) * sign(self.vsp))
    self.vsp = self.vsp - self.vsp_decimal 

    --horizontal collisions
    local side
    local multiply_size = 1 
    if self.state == "VIP" or self.state == "VIPJUMP" then multiply_size = 2 end 
    if self.hsp > 0 then side = self.x + (GRID * multiply_size) else side = self.x end 
    --set collision points (top and bottom) 
    local t1 = self.colmap:getAtPixel(side + self.hsp, self.y)
    local t2 = self.colmap:getAtPixel(side + self.hsp, self.y+(GRID*2)-1)
    local t3 = self.colmap:getAtPixel(side + self.hsp, self.y+GRID)
    
    if t1 ~= 0 or t2 ~= 0 or t3 ~= 0 then 
        --collision found 
        if self.state ~= "JUMP" then self.offset_buffer = self.offset_buffer + 1 end 
        if self.hsp > 0 then 
            if self.x % GRID ~= 0 then 
                self.x = self.x - (self.x % GRID) + GRID
            else 
                self.x = self.x
            end 
            if self.state ~= "JUMP" then 
                self.camoffset_x = 0   --????        
                if self.offset_buffer > 5 then
                    self.camoffset_x = GRID * 12            
                end 
            end 
        elseif self.hsp < 0 then 
            self.x = self.x - (self.x % GRID) - (side - self.x) 
            if self.state ~= "JUMP" then
                self.camoffset_x = 0
                if self.offset_buffer > 5 then
                    self.camoffset_x = -(GRID * 11)            
                end
            end  
        end 
        self.hsp = 0
        self.collision_buffer = 0
    else   
        self.collision_buffer = self.collision_buffer + 1      
        if self.collision_buffer > 10 then 
            self.offset_buffer = 0
            if self.camoffset_x > 0 then 
                self.camoffset_x = self.camoffset_x - 10
            elseif self.camoffset_x < 0 then 
                self.camoffset_x = self.camoffset_x + 10
            end 
        end 
        
    end 

    self.x = self.x + self.hsp

    --vertical collisions
    local side 
    local multiply_size = 1 
    if self.state == "VIP" or self.state == "VIPJUMP" then multiply_size = 2 end 
    if self.vsp > 0 then side = self.y + (GRID*2) else side = self.y  end 
    --set collision points(left and right)
    local t1 = self.colmap:getAtPixel(self.x, side + self.vsp)
    local t2 = self.colmap:getAtPixel(self.x+((GRID*multiply_size)-1), side + self.vsp)
    local t3 = self.colmap:getAtPixel(self.x+(GRID-1), side + self.vsp)

    if t1 ~= 0 or t2 ~= 0 or t3 ~= 0 then 
        self.offset_buffer_y = self.offset_buffer_y + 1 
        --collision found 
        if self.vsp > 0 then
            if self.y % GRID ~= 0 then 
                self.y = self.y - (self.y % GRID) + GRID
            else 
                self.y = self.y
            end 
            if self.state ~= "VIP" and input:down("down") then
                if self.offset_buffer_y > 10 then
                    self.camoffset_y = 100            
                end 
            else 
                self.camoffset_y = 0
            end 
        end 
        self.vsp = 0
        self.collision_buffer_y = 0
    else    
        self.collision_buffer_y = self.collision_buffer_y + 1
        if self.collision_buffer_y > 4 then 
            self.offset_buffer_y = 0
            if self.camoffset_y > 0 then 
                self.camoffset_y = self.camoffset_y - 5
            end 
        end 
    end 

    self.y = self.y + self.vsp
end 

function Player:jumped()

    if self.jumps > 0 then
        if self.jumps == 3 then 
            snd_jump1:stop()
            snd_jump1:play()
        elseif self.jumps == 2 then 
            snd_jump2:stop()
            snd_jump2:play()
        elseif self.jumps == 1 then 
            snd_jump3:stop()
            snd_jump3:play()
        end 
        self.vsp_decimal = 0
        self.state = "JUMP"
        self.vsp = self.jump_spd
        self.jumps = self.jumps - 1
    end 
end 

function Player:VIPjumped()

    if self.jumps > 0 then 
        snd_jump1:stop()
        snd_jump1:play()
        self.vsp_decimal = 0
        self.state = "VIPJUMP"
        self.vsp = self.VIPjump_spd
        self.jumps = self.jumps - 1
    end 
end

function Player:onGround()
    local multiply_size = 1 
    if self.state == "VIP" or self.state == "VIPJUMP" then multiply_size = 2 end 
    local side = self.y + (GRID*2) 
    local t1 = self.colmap:getAtPixel(self.x, side + 1)
    local t2 = self.colmap:getAtPixel(self.x + ((GRID*multiply_size) - 1), side + 1)
    local t3 = self.colmap:getAtPixel(self.x+(GRID-1), side + self.vsp)
    
    if t1 ~= 0 or t2 ~= 0 or t3 ~= 0 then 
        return true 
    else 
        return false 
    end 
end 

function Player:stabbed() 
    if self.stabs_time > self.stabs_cooldown then 
        self.attacked = true 
        self.stabs_time = 0
    end 
end 