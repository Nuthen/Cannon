Cannon = class('Cannon')

function Cannon:initialize()
	local x, y = love.graphics.getWidth()/2, love.graphics.getHeight()/2
	
	self.body = love.physics.newBody(game.world, x, y, 'static')
	self.shape = love.physics.newCircleShape(20)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	
	self.fixture:setMask(1)
	self.bullets = {}
end

function Cannon:update(dt)
	if love.mouse.isDown('r') and not love.keyboard.isDown('lshift', 'rshift') then
		self.body:setPosition(love.mouse:getX(), love.mouse:getY())
	end

	for k, bullet in pairs(self.bullets) do
		bullet:update(dt)
	end
end

function Cannon:mousepressed(mx, my, mbutton)
	if mbutton == 'l' then
		local x, y = self.body:getX(), self.body:getY()
		table.insert(self.bullets, Bullet:new(x, y, mx-x, my-y))
	end
end

function Cannon:draw()
	local x, y = self.body:getPosition()
	local r = self.shape:getRadius()
	
	love.graphics.circle('line', x, y, r)
	
	if not game.wallBuilding then
		local mx, my = love.mouse.getPosition()
		love.graphics.line(x, y, mx, my)
	end
	
	for k, bullet in pairs(self.bullets) do
		bullet:draw()
	end
end