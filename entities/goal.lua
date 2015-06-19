Goal = class('Goal')

function Goal:initialize()
	local x, y = 600, 200
	
	self.body = love.physics.newBody(game.world, x, y, 'static')
	local w, h = 50, 30
	self.shape = love.physics.newChainShape(false, -w/2, -h/2, -w/2, h/2, w/2, h/2, w/2, -h/2)
	self.fixture = love.physics.newFixture(self.body, self.shape)
end

function Goal:update(dt)
	if love.mouse.isDown('m') then
		self.body:setPosition(love.mouse:getX(), love.mouse:getY())
	end
end

function Goal:draw()
	local x, y = self.body:getPosition()
	
	local x1, y1, x2, y2, x3, y3, x4, y4 = self.shape:getPoints()
	love.graphics.line(x+x1, y+y1, x+x2, y+y2, x+x3, y+y3, x+x4, y+y4)
end