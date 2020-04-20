GreenEnemy = Enemy:extend()

function GreenEnemy:new(area, x, y, animation_path, initial_tag) 
    GreenEnemy.super.new(self, area, x, y, animation_path, initial_tag)
    self.walk_spd = 0.11
    self.max_hsp = 3
    self.drag = 0.01
end 

function GreenEnemy:update(dt) 
    self.states[self.state].update(dt)
    self.exclamation:update(dt)
end 

function GreenEnemy:draw() 
    GreenEnemy.super.draw(self)
end 

function GreenEnemy:calculateMovement()

    local isDrag = false

    local i = t % 50    
    if i > 20 and i < 30 and self.state ~= "IDLE" then 
        self.vsp = self.vsp - 0.7
    else 
        self.vsp = 0
    end 

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
    --local t2 = self.colmap:getAtPixel(side + self.hsp, self.y+(GRID*2)+1)
    
    if t1 ~= 0 then 
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