local grid = {}

local block = require("block")

local Grid = { 
  border_size = 0, 
  block_width = 10, 
  block_height = 10, 
  blocks_x = 10,
  blocks_y = 10,
}

function Grid:get(x, y)
  return block.create(
    x,
    y,
    self.block_width,
    self.block_height
  )
end

function Grid:frame_width()
  return self.block_width * self.blocks_x
end

function Grid:frame_height()
  return self.block_height * self.blocks_y
end

function Grid:window_width()
  return self:frame_width() + 2 * self.border_size
end

function Grid:window_height()
  return self:frame_height() + 2 * self.border_size
end

function Grid:is_in_bounds(x, y)
  return x >= 0 and x < self.blocks_x and y >= 0 and y < self.blocks_y
end

function Grid:draw_border()
  love.graphics.rectangle("fill", 0, 0, self:window_width(), self.border_size)
  love.graphics.rectangle("fill", 0, self:window_height() - self.border_size, self:window_width(), self.border_size)
  
  love.graphics.rectangle("fill", 0, 0, self.border_size, self:window_height())
  love.graphics.rectangle("fill", self:window_width() - self.border_size, 0, self.border_size, self:window_height())
end

function Grid:draw_blocks(blocks)
  local canvas = love.graphics.newCanvas(self:frame_width(), self:frame_height())
  love.graphics.setCanvas(canvas)
  love.graphics.clear()

  for _, b in ipairs(blocks) do
    b:draw()
  end
  
  love.graphics.setCanvas()
  love.graphics.draw(canvas, self.border_size, self.border_size)
end

function grid.create(border_size, window_w, window_h, blocks_x, blocks_y)
  local self = {}
  setmetatable(self, { __index = Grid })
  
  width = window_w - border_size * 2
  height = window_h - border_size * 2
  
  assert(width % blocks_x == 0, "Window width " .. width .. " cannot contain " .. blocks_x .. " horizontal blocks")
  assert(height % blocks_y == 0, "Window height " .. height .. " cannot contain " .. blocks_y .. " vertical blocks")
  
  self.border_size = border_size
  self.block_width = width / blocks_x
  self.block_height = height / blocks_y
  self.blocks_x = blocks_x
  self.blocks_y = blocks_y
  
  return self
end

return grid