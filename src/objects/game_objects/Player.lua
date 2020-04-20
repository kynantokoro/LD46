Player = Entity:extend()

function Player:new(area, x, y, animation_path, animation_tag)
    Player.super.new(self, area, x, y)

    self.tag = "Player"
    self.game = false
    self.colmap = current_map
    self.sprite = peachy.new(animation_path, animation_tag)
    self.thankyou = love.graphics.newImage("res/atlas/sheishei.png")
    self.sheishei = false
    self.arrow = peachy.new("res/sprite/key.json", "DOWNARROW")
    self.arrow_anim = false
    self.bullet = peachy.new("res/sprite/bullet.json", "BULLET")
    self.bullet_anim = false
    self.bullet:onLoop(function()
        self.bullet_anim = false
    end )
    self.end_room = false
    self.play_found = true    
    self.image_xscale = 1 
    self.image_yscale = 1
    self.hasKey = false
    self.gun = peachy.new("res/sprite/gun.json", "hold")
    self.gun_anim = false 
    self.gun:onLoop(function ()
        self.gun_anim = false
    end)
    self.gunframe = 0
    self.guninitial = 30
    self.vipx = self.x 
    self.vipy = self.y
    self.vipfacing = 1
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
    self.stabs_cooldown = 0
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
    self.vipOutOfBound = false 
    self.states = {}
    local VIP = {
        update = function(dt) 

            self.arrow_anim = false

            self.max_hsp = 2
            self.walk_spd = 0.2
            
            self:calculateMovement()

            if self:onGround() then self.jumps = self.VIPjumps_initial end
            if input:pressed("up") and self.game == true then 
                self:VIPjumped()
            end 

            if self.hsp ~= 0 then 
                snd_walking:play()
            end 

            self:Collisions()

            if self.game == true then 
                self.sprite:update(dt)
                self.vipx = self.x 
                self.vipy = self.y
                self.offset_buffer_y = 0
            end 
        end,
        draw = function()
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + (GRID*2) end
            self.sprite:draw(draw_x, self.y, 0, self.facing*self.image_xscale, self.image_yscale)
        end 
    }
    local IDLE = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2

            self.arrow_anim = true

            self:calculateMovement()

            if self:onGround() then self.jumps = self.jumps_initial end
            if input:pressed("up") and self.game == true then 
                self:jumped()
            end 

            self:Collisions()

            if self.hsp ~= 0 then 
                self.state = "WALK"
            end 

            if self.game == true then 
                self.sprite:update(dt)
                self.vipimage:update(dt)
            end 
        end, 
        draw = function() 
            local draw_x = self.vipx 
            if self.vipfacing < 0 then draw_x = self.vipx + (GRID*2) end
            self.vipimage:draw(draw_x, self.vipy, 0, self.vipfacing)
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing*self.image_xscale, self.image_yscale)
        end 
    }
    local WALK = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2

            self.arrow_anim = true

            snd_walking:play()

            self:calculateMovement()

            if self:onGround() then self.jumps = self.jumps_initial end
            if input:pressed("up") and self.game == true then 
                self:jumped()
            end 

            self:Collisions()

            if self.hsp == 0 then 
                self.state = "IDLE"
            end 

            if self.game == true then 
                self.sprite:update(dt)
                self.vipimage:update(dt)
            end 
        end, 
        draw = function() 
            local draw_x = self.vipx 
            if self.vipfacing < 0 then draw_x = self.vipx + (GRID*2) end
            self.vipimage:draw(draw_x, self.vipy, 0, self.vipfacing)
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing*self.image_xscale, self.image_yscale)
        end 
    }
    local JUMP = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2

            self.arrow_anim = true

            self:calculateMovement() 

            if self:onGround() then self.jumps = self.jumps_initial end
            if input:pressed("up") and self.game == true then 
                self:jumped()
            end

            if self:onGround() then 
                self.state = "IDLE" 
                snd_landing:stop()
                snd_landing:play()
            end

            self:Collisions()
            if self.game == true then 
                self.sprite:update(dt)
                self.vipimage:update(dt)
            end 
        end, 
        draw = function() 
            local draw_x = self.vipx 
            if self.vipfacing < 0 then draw_x = self.vipx + (GRID*2) end
            self.vipimage:draw(draw_x, self.vipy, 0, self.vipfacing)
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing*self.image_xscale, self.image_yscale)
        end 
    }
    local VIPJUMP = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2

            self.arrow_anim = false

            self:calculateMovement() 

            if self:onGround() then self.jumps = self.VIPjumps_initial end
            if input:pressed("up") and self.game == true then 
                self:VIPjumped()
            end

            if self:onGround() then 
                self.state = "VIP" 
                snd_landing:stop()
                snd_landing:play()
            end

            self:Collisions()

            if self.game == true then 
                self.sprite:update(dt)
                self.vipimage:update(dt)
            end 
        end, 
        draw = function() 
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + (GRID*2) end
            self.sprite:draw(draw_x, self.y, 0, self.facing*self.image_xscale, self.image_yscale)
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
    if input:pressed("down") and self.game == true and self.end_room == false then
        if self.state == "VIP" and self:onGround() then
            self.state = "IDLE"
            snd_pickdown:play()
            self.sprite:setTag("IDLE")
        elseif self.state == "IDLE" then
            self.arrow:draw(self.vipx, self.vipy)
            if self.x > self.vipx - (GRID*2) and self.x < self.vipx + (GRID*2) and self.y >= self.vipy - GRID and self.y <= self.vipy + GRID then 
                self.state = "VIP"
                self.x = self.vipx 
                snd_pickup:play()
                self.sprite:setTag("VIP")
            end 
        end 
    elseif input:pressed("down") and self.end_room == true then 
        if self.x >= self.vipx - (GRID*2) and self.x <= self.vipx + (GRID*2) and self.y >= self.vipy - GRID and self.y <= self.vipy + GRID then  
            snd_thankyou:play()
            self.sheishei = true
            Timer.after(2, function () 
                self.sheishei = false
            end )
        end 
    end 

    self.attacked = false
    if input:pressed("space") then 
        if self.state ~= "VIP" and self.state ~= "VIPJUMP" and self.game == true then 
            self.gun_anim = true
            self.gun:setTag("fire")
            self.bullet_anim = true 
            self:stabbed()
            self.bullet:setFrame(1)
        end 
    end  

    if self.gun_anim == false then 
        self.gun:setTag("hold")
    end 

    if self.bullet_anim == true then  
        self.bullet:update(dt)
    end 

    self.gun:update(dt)
    self.arrow:update(dt)

    self.states[self.state].update(dt)

    if self.vipOutOfBound then 
        if self.found == false then 
            local dif = (math.abs(self.x - self.vipx) - GAMEWIDTH) * 0.08
            vEffect.pixelate.size = 0.0001 + dif
        else 
            vEffect.pixelate.size = 0.0001 
        end 
    end 

    if self.found == true then 
        if self.play_found then
            snd_found:stop()
            snd_found:play()
        end 
        self.play_found = false
        cEffect.desaturate.strength = 0.5
        camera.rotation = math.sin(t*0.1) * 0.01
        camera.scale = 1 + math.sin(t*0.175) * 0.01
    end 

    self.stabs_time = self.stabs_time + 1

end 

function Player:draw()
    self.states[self.state].draw()

    if self.arrow_anim == true then 
        self.arrow:draw(self.vipx + 4, self.vipy - GRID - 2)
    end 

    local draw_x = self.x 
    if self.bullet_anim == true then 
        if self.facing > 0 then draw_x = self.x + GRID end
        self.bullet:draw(draw_x, self.y + GRID, 0, self.facing)
    end 

    local draw_x = self.x 
    if self.state ~= "VIP" and self.state ~= "VIPJUMP" then 
        if self.end_room == true and self.sheishei == true then 
            love.graphics.draw(self.thankyou, self.vipx - GRID, self.vipy - (GRID*4))
        end 
        if self.facing > 0 then draw_x = self.x + GRID end
        self.gun:draw(draw_x, self.y+GRID+1, 0, self.facing)
    end 
end 

function Player:calculateMovement()
    
    local isDrag = false

    if self.game == true then 
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
    else 
        self.hsp = 0 
        self.vsp = 0
        idDrag = true 
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
        if self.state ~= "JUMP" or self.state ~= "VIPJUMP" then self.offset_buffer = self.offset_buffer + 1 end 
        if self.hsp > 0 then 
            if self.x % GRID ~= 0 then 
                self.x = self.x - (self.x % GRID) + GRID
            else 
                self.x = self.x
            end 
            if self.state ~= "JUMP" or self.state ~= "VIPJUMP" then 
                self.camoffset_x = 0   --????        
                if self.offset_buffer > 5 then
                    self.camoffset_x = GRID * 12            
                end 
            end 
        elseif self.hsp < 0 then 
            self.x = self.x - (self.x % GRID) - (side - self.x) 
            if self.state ~= "JUMP" or self.state ~= "VIPJUMP" then
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
    
    if self.game == true then 
        self.x = self.x + self.hsp
    end 

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
        --collision found 
        if self.vsp > 0 then
            if self.y % GRID ~= 0 then 
                self.y = self.y - (self.y % GRID) + GRID
            else 
                self.y = self.y
            end 
            if self.state ~= "VIP" and input:down("down") then
                self.offset_buffer_y = self.offset_buffer_y + 1 
                if self.offset_buffer_y > 10 then
                    self.camoffset_y = 100            
                end 
            else 
                self.camoffset_y = 0
                self.offset_buffer_y = 0
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

    if self.game == true then
        self.y = self.y + self.vsp
    end 
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
        snd_gun:stop()
        snd_gun:play()
        print("stab")
        self.attacked = true 
        self.stabs_time = 0
    end 
end 