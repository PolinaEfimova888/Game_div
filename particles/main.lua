require("vector")
require("particle")

math.randomseed(os.time())

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    touchx = 0
    touchy = 0

    system = ParticleSystem:create(Vector:create(width / 2, height / 2), 20)
    gravity = Vector:create(0, 0.1)
    
end

function love.update(dt)
    x, y = love.mouse.getPosition()
   
    system:update()
    local part = system:getPerticles()

    for k, v in pairs(part) do
        if touchx >= v.location.x and touchx <= v.location.x + v.a and
        touchy >= v.location.y and touchy <= v.location.y + v.a then
            v.status = 3
        end
        v:update(dt)
    end

end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        touchx = x
        touchy = y
     end
end

function love.draw()
    local part = system:getPerticles()
    system:draw()
    for k, v in pairs(part) do
        v:draw()
    end
end

