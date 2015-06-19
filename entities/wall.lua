Wall = class('Wall')

function Wall:initialize(x1, y1, x2, y2)
	local midx, midy = math.midpoint(x1, y1, x2, y2)
	local dist = math.dist(x1, y1, x2, y2)
	local angle = math.angle(x1, y1, x2, y2)
	
	self.body = love.physics.newBody(game.world, 0, 0, 'static')
	local w, h = dist, 10
	self.shape = love.physics.newRectangleShape(midx, midy, w, h, angle)
	self.fixture = love.physics.newFixture(self.body, self.shape)
end

function Wall:draw()
	love.graphics.polygon('fill', self.shape:getPoints())
end

function Wall:destroy()
	self.body:destroy()
end