local food = {}

local block = require("block")

local Food = { block = nil }

function Food:fmt()
  return string.format("Food(block=%s)", self.block:fmt())
end

function Food:draw(grid)
  local r, g, b, a = love.graphics.getColor()
  love.graphics.setColor(1, 0, 0)
  grid:draw_blocks({self.block})
  love.graphics.setColor(r, g, b, a)
end

function food.create(x, y, size)
  local self = {}
  setmetatable(self, { __index = Food })
  
  self.block = block.create(x, y, size, size)
  
  return self
end

function food.random(blocks_x, blocks_y, size)
  return food.create(math.random(0, blocks_x - 1), math.random(0, blocks_y - 1), size)
end

return food