--Base class for any kind of particle effects (fire, trail, etc..)

ParticleSystem = Entity:extend()

function ParticleSystem:new(area, x, y, image_path, preset_name) 
    ParticleSystem.super.new(self, area, x, y)
    self.image = love.graphics.newImage(image_path)
    self.facing = 1
    self.presets = {}
    local FIRE = {
        init = function ()
            local particleTexture = self.image
            local quads = {}

            for i=1, particleTexture:getWidth()/GRID do 
                quads[i] = love.graphics.newQuad(GRID*(i-1), 0, GRID, GRID, particleTexture:getDimensions())
            end 

            self.psystem = love.graphics.newParticleSystem(particleTexture, 128)
            self.psystem:setQuads(quads[1], quads[2], quads[3], quads[4], quads[5])
            self.psystem:setParticleLifetime(0.2, 1.0) --Particles live at least 2d and 
            self.psystem:setEmissionRate(100)
            self.psystem:setDirection(2)
            self.psystem:setEmissionArea("normal", 0.3, 0.3)
            self.psystem:setSizeVariation(0)
            self.psystem:setSpin(0.1)
            self.psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- fade to transparant
            self.psystem:start()
        end,
        update = function (dt)
            self.psystem:update(dt)
            self.psystem:setLinearAcceleration(-100, 0, -100, 30)
            if self.facing < 0 then 
                self.psystem:setLinearAcceleration(100, 0, 100, 30)
            end 
            self.psystem:setPosition( self.x, self.y + GRID)
            Timer.after(0.2, function ()
                self.psystem:stop()
            end)
        end, 
        draw = function () 
            love.graphics.draw(self.psystem)
        end 
    }
    self.preset = preset_name
    self.presets["FIRE"] = FIRE
    self.presets[self.preset].init()
end 

function ParticleSystem:update(dt, x, y, facing)
    self.x = x
    self.y = y
    self.facing = facing
    self.presets[self.preset].update(dt)
end 

function ParticleSystem:draw()
    self.presets[self.preset].draw()
end
