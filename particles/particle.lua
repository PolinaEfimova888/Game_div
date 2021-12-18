Particle = {}
Particle.__index = Particle

function Particle:create(location, old_x, old_y)
    local particle = {}
    setmetatable(particle, Particle)
    particle.location = location

    particle.start = math.random(10, 60)

    particle.crash_line = CrashLine:create(old_x, old_y, particle.start)

    particle.a = particle.start
    particle.status = 1

    particle.time = 0
    particle.frameTime = 0.008
    
    return particle
end

function Particle:update(dt)
    
    if self.status == 3 then
        if self.a > 1 then
            if self.time > self.frameTime then
                self.location.x = self.location.x + 0.1
                self.location.y = self.location.y + 0.1
                self.a = self.a - 0.2
                self.time = 0
            end
        end
    end

    if self.a < 1 and self.status ~=2 then
        self.status = 2
    end

    if self.status == 2 then
        self.crash_line:update()
    end

    self.time = self.time + dt
end

function Particle:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(255/255, 255/255, 255/255, 1)

    if (self.status == 3) then love.graphics.setColor(255/255, 0/255, 76/255, 1) end

    if self.status == 1 or self.status == 3 then
        love.graphics.rectangle("line", self.location.x, self.location.y, self.a, self.a)
    end

   if self.status == 2 then
    self.crash_line:draw()
   end

   love.graphics.setColor(r, g, b, a)
end

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, n, cls)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = origin
    system.n = n or 10
    system.cls = cls or Particle
    system.particles = {}
    system.index = 1
    return system
end

function ParticleSystem:draw()
end

function ParticleSystem:update()
    if #self.particles < self.n then
        local l = Vector:create(math.random(0, width-100), math.random(0, height-100))
        self.particles[self.index] = Particle:create(l, l.x, l.y)
        self.index = self.index + 1
    end
end

function ParticleSystem:getPerticles()
    return self.particles
end

CrashLine = {}
CrashLine.__index = CrashLine

function CrashLine:create(x, y, size)
    local crashline = {}
    setmetatable(crashline, CrashLine)
    crashline.location = Vector:create(x, y)
    crashline.location_sec = Vector:create(x, y)
    crashline.size = size
    return crashline
end


function CrashLine:update()
    self.location = self.location + Vector:create(-math.random(1, 6),-math.random(1, 6))
    self.location_sec = self.location_sec + Vector:create(math.random(1, 6),math.random(1, 6))
end

function CrashLine:draw()
    love.graphics.setColor(255/255, 0/255, 76/255, 1)
    love.graphics.line(self.location.x, self.location.y, self.location.x, self.location.y + self.size)
    love.graphics.line(self.location.x, self.location.y, self.location.x + self.size, self.location.y)

    love.graphics.line(self.location_sec.x + self.size, self.location_sec.y, self.location_sec.x + self.size, self.location_sec.y + self.size)
    love.graphics.line(self.location_sec.x, self.location_sec.y + self.size, self.location_sec.x + self.size, self.location_sec.y + self.size)
end
