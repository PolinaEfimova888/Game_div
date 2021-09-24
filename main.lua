require("vector")
require("mover")

function love.load()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	love.graphics.setBackgroundColor(128/255,128/255,128/255)



	location = Vector:create(100,height/2)

	velocity = Vector:create(0,0)
	mover = Mover:create(location,velocity)
	wmover = Mover:create(location,velocity, 5)
	wmover.size = 30


	wind = Vector:create(0.01, 0)
	isWind = false
	gravity = Vector:create(0, 0.01)
	isGravity = false
	floating = Vector:create(0, -0.02)
	isFloating = false

end


function love.update()
		mover:applyForce(gravity)
		wmover:applyForce(gravity)

		mover:applyForce(wind)
		wmover:applyForce(wind)

--		friction = (mover.velocity * -1):norm()
--		if friction then
--			friction:mul(0.005)
--			mover:applyForce(friction)
--			wmover:applyForce(friction)
--		end

	if mover.location.x + mover.size < width/2 then 
        friction = (mover.velocity  * -1):norm()
        if friction then 
            friction:mul(0.005)
            mover:applyForce(friction)
        end
    end 

    if wmover.location.x + wmover.size > width/2 then 
        friction = (wmover.velocity  * -1):norm()
        if friction then 
            friction:mul(-0,005)
            wmover:applyForce(friction)
        end
    end

		mover:update()
		mover:checkBoundaries()

		wmover:update()
		wmover:checkBoundaries()

end

function love.draw()
	
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 119/255, 190/255, 0.5)
	love.graphics.rectangle("fill", 0, 0, 400, 600)
	love.graphics.setColor(r, g, b, a)


	mover:draw()
	wmover:draw()

	love.graphics.print(tostring(mover.velocity), mover.location.x + mover.size, mover.location.y)
	love.graphics.print(tostring(wmover.velocity), wmover.location.x + mover.size, wmover.location.y)

	love.graphics.print("w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloating) )
	
end

function love.keypressed(key)
	if key == 'g' then
		isGravity = not isGravity
	end
	if key == 'f' then
		isFloating = not isFloating
	end
	if key == 'w' then
		isWind= not isWind
		if isWind then
			wind = wind * -1
		end
	end
end
