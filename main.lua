local mobdebug = require("mobdebug")

local base = require("base")
local block = require("block")
local food = require("food")
local grid = require("grid")
local snake = require("snake")

local Direction = base.Direction

local State = { hz = 1 / 15, dt = 0, score = 0, grid = nil, snake = nil, food = {} }

local function random_food()
  return food.random(State.grid.blocks_x, State.grid.blocks_y, 20)
end

function love.load()
  mobdebug.start()
  io.stdout:setvbuf("no")
  math.randomseed(os.time())
  
  State.grid = grid.create(10, love.graphics.getWidth(), love.graphics.getHeight(), 40, 40)
  State.snake = snake.create(State.grid, 10, 10, Direction.right)
  State.food = random_food()
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    love.event.quit()
  end
  
  local direction = State.snake.direction
  
  if     (key == "w" or key == "up")    and direction ~= Direction.down  then State.snake:change(Direction.up)
  elseif (key == "d" or key == "right") and direction ~= Direction.left  then State.snake:change(Direction.right)
  elseif (key == "s" or key == "down")  and direction ~= Direction.up    then State.snake:change(Direction.down)
  elseif (key == "a" or key == "left")  and direction ~= Direction.right then State.snake:change(Direction.left)
  end
end

function love.update(dt)
  State.dt = State.dt + dt
  
  if State.dt > State.hz then
    State.dt = State.dt - State.hz
  else
    return
  end

  if State.food.block:is_equal(State.snake:head()) then
    State.food = random_food()
    State.hz = State.hz * 0.9
    State.score = State.score + 1
    State.snake:grow()
  else
    State.snake:move()
  end
  
  if not State.grid:is_in_bounds(State.snake:x(), State.snake:y()) then
    love.event.quit()
  end
end

function love.draw()
  State.grid:draw_border()
  State.food:draw(State.grid)
  State.snake:draw(State.grid)
  love.graphics.print("Score: " .. State.score, 30, 30)
end