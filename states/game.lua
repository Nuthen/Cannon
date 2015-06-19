game = {}

function game:enter()
	self.world = love.physics.newWorld(0, 100, false)

	local w, h = love.graphics:getDimensions()
	self.borderBody = love.physics.newBody(self.world)
	self.borderShape = love.physics.newChainShape(true, math.random(w/8), math.random(h/8), math.random(w*7/8, w), math.random(h/8), math.random(w*7/8, w), math.random(h*7/8, h), math.random(w/8), math.random(h*7/8, h))
	self.boderFixture = love.physics.newFixture(self.borderBody, self.borderShape)
    self.cannon = Cannon:new()
	
	self.goal = Goal:new()
	
	self.wallStartX = 0
	self.wallStartY = 0
	self.wallBuilding = false
	
	self.walls = {}
end

function game:update(dt)
	self.cannon:update(dt)
	self.goal:update()
	
	if not self.wallBuilding then
		if love.keyboard.isDown('lshift', 'rshift')  and not love.keyboard.isDown('l') then
			self.wallBuilding = true
		end
	elseif not love.keyboard.isDown('lshift', 'rshift') then
		self.wallBuilding = false
	end

	self.world:update(dt)
end

function game:keypressed(key, isrepeat)
    if console.keypressed(key) then
        return
    end
	
	if key == 'f1' then
		for k, wall in pairs(self.walls) do
			wall:destroy()
		end
		self.walls = {}
	end
end

function game:mousepressed(x, y, mbutton)
    if console.mousepressed(x, y, mbutton) then
        return
    end
	
	if love.keyboard.isDown('lshift', 'rshift') then
		self.wallBuilding = true
		self.wallStartX, self.wallStartY = love.mouse:getPosition()
	else
		self.cannon:mousepressed(x, y, mbutton)
	end
end

function game:mousereleased(x, y)
	if self.wallBuilding then
		self.wallBuilding = false
		table.insert(self.walls, Wall:new(self.wallStartX, self.wallStartY, x, y))
	end
end

function game:draw()
    self.cannon:draw()
	self.goal:draw()
	for k, wall in pairs(self.walls) do
		wall:draw()
	end
	
	local x1, y1, x2, y2, x3, y3, x4, y4 = self.borderShape:getPoints()
	love.graphics.line(x1, y1, x2, y2, x3, y3, x4, y4, x1, y1)
	
	if self.wallBuilding then
		love.graphics.line(self.wallStartX, self.wallStartY, love.mouse:getX(), love.mouse:getY())
	end
end