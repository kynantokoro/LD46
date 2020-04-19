Enemy = Entity:extend() 

function Enemy:new(area, x, y, animation_path, initial_tag)
    Enemy.super.new(self, area, x, y)
    
    self.tag = "Enemy"
    self.colmap = current_map
    self.sprite = peachy.new(animation_path, initial_tag)
    self.facing = 1
    self.walk_spd = 0.3
    self.hsp = 0
    self.max_hsp = 1
    self.vsp = 0
    self.drag = 0.35
    self.hsp_decimal = 0
    self.vsp_decimal = 0
    self.foundbuffer = 0
    self.foundtime = 5
    self.stopcount = 0
    self.stoptime = 120
    self.attackCount = 0
    self.attackCooldown = 60
    self.states = {}

    local IDLE = {
        update = function (dt) 

            self:calculateMovement()

            self.hsp = 0

            self.stopcount = self.stopcount + 1 
            if self.stopcount > self.stoptime then
                if self.facing > 0 then self.facing = -1 elseif self.facing < 0 then self.facing = 1 end 
                self.state = "MOVE"
                self.stopcount = 0
            end 

            self:Collisions()

        end,
        draw = function ()
            self.sprite:draw(self.x, self.y)
        end 
    }
    local MOVE = {
        update = function (dt) 

            self:calculateMovement()

            self:Collisions()
            
            if self.stop == true then 
                self.state = "IDLE"
                self.stop = false
            end 

        end,
        draw = function ()
            self.sprite:draw(self.x, self.y)
        end 
    }
    local ATTACK = {
        update = function (dt) 
            self.attackCount = self.attackCount + 1 
            if self.attackCount > self.attackCooldown then 
                self.state = "IDLE"
            end 
            if self.foundbuffer <= 0 then 
                self.state = "IDLE"
            end 
        end,
        draw = function ()
            love.graphics.setColor(1, 0,0,1)
            self.sprite:draw(self.x, self.y)
            love.graphics.setColor(1, 1,1,1)
        end 
    }
    local DEAD = {
        update = function (dt) 

        end,
        draw = function ()
            
        end 
    }
    self.states["IDLE"] = IDLE 
    self.states["MOVE"] = MOVE 
    self.states["ATTACK"] = ATTACK 
    self.states["DEAD"] = DEAD 
    self.state = "MOVE"
end 


function Enemy:update(dt) 
    self.states[self.state].update(dt)
end 

function Enemy:draw() 
    self.states[self.state].draw()
    
    love.graphics.print(self.facing, self.x, self.y)
    love.graphics.print(self.state, self.x+10, self.y)
    love.graphics.line(self.x, self.y + (GRID*2) - 1, self.x + 10, self.y + (GRID*2) - 1)
end 

function Enemy:calculateMovement()
    
    local isDrag = false

    --calculate horizontal movement
    
    if self.facing < 0 then 
        self.hsp = self.hsp - self.walk_spd
        isDrag = false 
    elseif self.facing > 0 then 
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

function Enemy:Collisions() 
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
    --also check if falling of ledge
    local t1 = self.colmap:getAtPixel(side + self.hsp, self.y+(GRID*2)-1)
    local t2 = self.colmap:getAtPixel(side + self.hsp, self.y+(GRID*2)+1)
    
    if t1 ~= 0 or t2 == 0 then 
        --collision found 
        if self.hsp > 0 then 
            if self.x % GRID ~= 0 then 
                self.x = self.x - (self.x % GRID) + GRID
            else 
                self.x = self.x
            end 
        else self.x = self.x - (self.x % GRID) - (side - self.x) end 
        self.hsp = 0
        self.stop = true 
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

function Enemy:onGround()
    local side = self.y + (GRID*2) 
    local t1 = self.colmap:getAtPixel(self.x, side + 1)
    local t2 = self.colmap:getAtPixel(self.x + GRID, side + 1)
    
    if t1 ~= 0 or t2 ~= 0 then 
        return true 
    else 
        return false 
    end 
end 