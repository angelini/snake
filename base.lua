local base = {}

local Dir = { up = 1, right = 2, down = 3, left = 4 }
base.Direction = Dir

function base.Direction.fmt(direction)
  if     direction == Dir.up    then return "up"
  elseif direction == Dir.right then return "right"
  elseif direction == Dir.down  then return "down"
  elseif direction == Dir.left  then return "left"
  end
end

return base