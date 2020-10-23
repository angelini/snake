local block = {}

local base = require("base")

local Direction = base.Direction

local Block = { 
  x = 0, 
  y = 0, 
  width = 0, 
  height = 0 
}

function Block:adjacent(direction)
  local offset_x = 0
  local offset_y = 0
  
  if     direction == Direction.up    then offset_y = -1
  elseif direction == Direction.left  then offset_x = -1
  elseif direction == Direction.down  then offset_y = 1
  elseif direction == Direction.right then offset_x = 1
  end
  
  return block.create(self.x + offset_x, self.y + offset_y, self.width, self.height) 
end

function Block:is_adjacent(other)
  if     self.x == other.x and self.y - 1 == other.y then return Direction.down
  elseif self.x == other.x and self.y + 1 == other.y then return Direction.up
  elseif self.x - 1 == other.x and self.y == other.y then return Direction.right
  elseif self.x + 1 == other.x and self.y == other.y then return Direction.left
  end
end

function Block:is_equal(other)
  return self.x == other.x and self.y == other.y  
end

function Block:px_x()
  return self.width * self.x
end

function Block:px_y()
  return self.height * self.y
end

function Block:fmt()
  return string.format("Block(x=%d, y=%d, width=%d, height=%d)", self.x, self.y, self.width, self.height)
end

function Block:draw()
  love.graphics.rectangle("fill", self:px_x(), self:px_y(), self.width, self.height)
end

function block.create(x, y, width, height)
  local self = {}
  setmetatable(self, { __index = Block })
  
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  
  return self
end

return block