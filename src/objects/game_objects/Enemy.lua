Enemy = Entity:extend() 

function Enemy:new(area, x, y, animation_path, initial_tag)
    Enemy.super.new(self, area, x, y)
    
    self.tag = "Enemy"
    self.colmap = current_map
    self.sprite = peachy.new(animation_path, initial_tag)
    self.particle = ParticleSystem(self.area, self.x, self.y, "res/FX/particle.png", "FIRE")
    self.exclamation = peachy.new("res/sprite/key.json", "FOUND")
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
    self.stop = false
    self.stopcount = 0
    self.stoptime = 0
    self.attackCount = 0
    self.attackCooldown = 60
    self.semidead = false
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
                self.stoptime = 30
            end 

            self.sprite:update(dt)

            self:Collisions()

        end,
        draw = function ()
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing)
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

            self.sprite:update(dt)

        end,
        draw = function ()
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing)
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
            local draw_x = self.x 
            if self.facing < 0 then draw_x = self.x + GRID end
            self.sprite:draw(draw_x, self.y, 0, self.facing)
        end 
    }
    local DEAD = {
        update = function (dt) 
            Timer.after(0.5, function() 
                self.semidead = true
            end)
            Timer.after(8, function() 
                self.dead = true
            end)
            self.particle:update(dt, self.x, self.y, self.facing)
        end,
        draw = function ()
            if self.semidead == false then 
                local draw_x = self.x 
                if self.facing < 0 then draw_x = self.x + GRID end
                self.sprite:draw(draw_x, self.y, 0, self.facing)
            end 
            self.particle:draw()
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
    self.exclamation:update(dt)
end 

function Enemy:draw() 
    self.states[self.state].draw()

    if self.state == "ATTACK" then 
        self.exclamation:draw(self.x - math.abs(math.sin(t*0.1)) * 4 , self.y - (GRID*2) - math.abs(math.sin(t*0.1)*4 ), 0, 1 + math.abs(math.sin(t*0.1)), 1 + math.abs(math.sin(t*0.1)))
    end 
    
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