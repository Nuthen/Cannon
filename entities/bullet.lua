Bullet = class('Bullet')

function Bullet:initialize(x, y, dx, dy)
	self.body = love.physics.newBody(game.world, x, y, 'dynamic')
	self.shape = love.physics.newCircleShape(10)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	
	self.body:setBullet(true)
	self.fixture:setRestitution(.5)
	self.body:applyLinearImpulse(dx, dy)
	
	self.t = 0
	self.disableMask = 3
end

function Bullet:update(dt)
	self.t = self.t + dt
	if self.t >= self.disableMask then
		--self.fixture:setMask()
	end
end

function Bullet:draw()
	local x, y = self.body:getPosition()
	local r = self.shape:getRadius()
	
	love.graphics.circle('line', x, y, r)
end