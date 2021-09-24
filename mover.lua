Mover = {}
Mover.__index = Mover

function Mover:create(x,y)
    local mover = {}
    setmetatable(mover,Mover)
    mover.location = location
    mover.velocity = velocity
    mover.acceleration = Vector:create(0,0)
    mover.size = 20
    mover.weight = weight or 1  


    return mover
end

function Mover:applyForce(force)
    self.acceleration:add(force / self.weight)
end

function Mover:checkBoundaries()
    if self.location.x > width - self.size then 
        self.location.x = width - self.size
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < self.size then 
        self.location.x = self.size
        self.velocity.x = -1 * self.velocity.x 
    end
    if self.location.y > height - self.size then 
        self.location.y = height - self.size
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.size then 
        self.location.y = self.size
        self.velocity.y = -1 * self.velocity.y 
    end
end

function Mover:draw()
    love.graphics.circle("fill", self.location.x, self.location.y, self.size )
end

function Mover:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.acceleration:mul(0)


end

