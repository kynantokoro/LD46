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
    self.jumps = 0
    self.jump_spd = -3.6
    self.jumps_initial = 3 
    self.found = false
    self.states = {}
    local VIP = {
        update = function(dt) 

            self.max_hsp = 2
            self.walk_spd = 0.2
            
            self:calculateMovement()

            self:Collisions()

            self.sprite:update(dt)
            self.vipx = self.x 
            self.vipy = self.y
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

            if input:pressed("up") then 
                self:jumped()
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
    local JUMP = {
        update = function(dt) 
            self.max_hsp = 3
            self.walk_spd = 0.2

            self:calculateMovement()

            if input:pressed("up") then 
                self:jumped()
            end

            self:Collisions()

            if self:onGround() then self.state = "IDLE" end 

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
    self.states["VIP"] = VIP 
    self.states["IDLE"] = IDLE 
    self.states["JUMP"] = JUMP
    self.state = animation_tag
end 

function Player:update(dt)
    if input:pressed("down") then
        if self.state == "VIP" and self:onGround() then
            self.state = "IDLE"
            self.sprite:setTag("IDLE")
        elseif self.state == "IDLE" then 
            if self.x >= self.vipx - GRID and self.x <= self.vipx + GRID and self.y >= self.vipy - GRID and self.y <= self.vipy + GRID then 
                self.state = "VIP" 
                self.sprite:setTag("VIP")
            end 
        end 
    end 
    self.states[self.state].update(dt)

    if self.found == true then 
        cEffect.desaturate.strength = 0.5
        --camera.rotation = math.sin(t*0.1) * 0.1
        --camera.scale = 1 + math.sin(t*0.175) * 0.05
    end 

end 

function Player:draw()
    self.states[self.state].draw()
    love.graphics.print(self.state, self.x, self.y)
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
    if self.state == "VIP" then multiply_size = 2 end 
    if self.hsp > 0 then side = self.x + (GRID * multiply_size) else side = self.x end 
    --set collision points (top and bottom) 
    local t1 = self.colmap:getAtPixel(side + self.hsp, self.y)
    local t2 = self.colmap:getAtPixel(side + self.hsp, self.y+(GRID*2)-1)
    local t3 = self.colmap:getAtPixel(side + self.hsp, self.y+GRID)
    
    if t1 ~= 0 or t2 ~= 0 or t3 ~= 0 then 
        print("t1 :" .. t1 .. " t2 :" .. t2 .. " t3 :" .. t3)
        --collision found 
        if self.hsp > 0 then 
            if self.x % GRID ~= 0 then 
                self.x = self.x - (self.x % GRID) + GRID
            else 
                self.x = self.x
            end 
        else self.x = self.x - (self.x % GRID) - (side - self.x) end 
        self.hsp = 0
    end

    self.x = self.x + self.hsp

    --vertical collisions
    local side 
    if self.vsp > 0 then side = self.y + (GRID*2) else side = self.y  end 
    --set collision points(left and right)
    local t1 = self.colmap:getAtPixel(self.x, side + self.vsp)
    local t2 = self.colmap:getAtPixel(self.x+(GRID-1), side + self.vsp)

    if t1 ~= 0 or t2 ~= 0 then 
        --collision found 
        if self.vsp > 0 then
            if self.y % GRID ~= 0 then 
                self.y = self.y - (self.y % GRID) + GRID
            else 
                self.y = self.y
            end 
        end 
        self.vsp = 0
    end 

    self.y = self.y + self.vsp
end 

function Player:jumped()
    if self:onGround() then self.jumps = self.jumps_initial end
    
    if self.jumps > 0 then
        self.vsp_decimal = 0
        self.state = "JUMP"
        self.vsp = self.jump_spd
        self.jumps = self.jumps - 1
    end 
end 

function Player:onGround()
    local side = self.y + (GRID*2) 
    local t1 = self.colmap:getAtPixel(self.x, side + 1)
    local t2 = self.colmap:getAtPixel(self.x + GRID, side + 1)
    
    if t1 ~= 0 or t2 ~= 0 then 
        return true 
    else 
        return false 
    end 
end 