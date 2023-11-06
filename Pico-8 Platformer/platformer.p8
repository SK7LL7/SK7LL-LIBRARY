pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- initialize player position and velocity
local player_x = 64
local player_y = 64
local player_vel_x = 0
local player_vel_y = 0
local gravity = 0.2
local jump_strength = -3.5
local is_jumping = false

-- main game loop
function _update()
    -- apply gravity
    player_vel_y = player_vel_y + gravity
    
    -- check for player input and update player velocity
    if btn(0) then  -- left arrow key
        player_vel_x = -1
    elseif btn(1) then  -- right arrow key
        player_vel_x = 1
    else
        player_vel_x = 0
    end
    
    -- check for jump input and perform jump if player is on the ground
    if btn(4) and not is_jumping then  -- z key for jump
        player_vel_y = jump_strength
        is_jumping = true
    end
    
    -- update player position based on velocity
    player_x = player_x + player_vel_x
    player_y = player_y + player_vel_y
    
    -- check for collision with the ground
    if player_y > 120 then
        player_y = 120
        player_vel_y = 0
        is_jumping = false
    end
end

-- draw game elements
function _draw()
    -- clear the screen
    cls()
    
    -- draw ground platform
    rect(0, 120, 128, 128, 12)
    
    -- draw the player character
    rect(player_x, player_y - 8, player_x + 7, player_y - 1, 8)
end


-- lua :o sk7ll
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000a0aa0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000a0aa0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000a0aa0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000aaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
