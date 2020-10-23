local snake = {}

local base = require("base")

local Direction = base.Direction

local Snake = { 
  blocks = {},
  direction = Direction.right,
}

function Snake:head()
  return self.blocks[1]
end

function Snake:x()
  return self:head().x
end

function Snake:y()
  return self:head().y
end

function Snake:fmt()
  local blocks = "["
  for _, block in ipairs(self.blocks) do
    blocks = blocks .. block:fmt() .. ", "
  end
  blocks = blocks .. "]"
  
  return string.format("Snake(blocks=%s, direction=%s)", blocks, Direction.fmt(self.direction))
end

function Snake:move()
  local new_blocks = {}
  local next_direction = self.direction
  
  for idx, block in ipairs(self.blocks) do
    local new_block = block:adjacent(next_direction)
    new_blocks[idx] = new_block
    
    if self.blocks[idx + 1] then
      next_direction = block:is_adjacent(self.blocks[idx + 1])
      assert(next_direction, "Snake blocks must be adjacent")
    end
  end
  
  self.blocks = new_blocks
end

function Snake:grow()
  local last_block = self.blocks[#self.blocks]
  self:move()
  self.blocks[#self.blocks + 1] = last_block
end

function Snake:change(direction)
  self.direction = direction
end

function Snake:draw(grid)
  grid:draw_blocks(self.blocks)
end

function snake.create(grid, x, y, direction)
  local self = {}
  setmetatable(self, { __index = Snake })
  
  self.blocks = { grid:get(x, y) }
  self.direction = direction
  
  return self
end

return snake