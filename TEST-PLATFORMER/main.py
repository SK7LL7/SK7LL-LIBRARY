import pygame
import sys

#PYGAME
pygame.init()



# CONSTANTS
WIDTH, HEIGHT = 640, 480
PLAYER_SIZE = 40
GROUND_HEIGHT = 20
GRAVITY = 0.5   
JUMP_VELOCITY = -10

player_sprite = pygame.image.load("D:\Cean files\Coding\PROGRAMMING\PYTHON\TEST-PLATFORMER\player_sprite.png")
player_sprite = pygame.transform.scale(player_sprite, (PLAYER_SIZE, PLAYER_SIZE))



# PLAYER_PROPERTIES
player_x = WIDTH // 2 - PLAYER_SIZE // 2
player_y = HEIGHT - GROUND_HEIGHT - PLAYER_SIZE
player_vel_y = 0
is_jumping = False


# SCREEN
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Simple Platformer")


# WHILE LOOP
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
            
            
    screen.blit(player_sprite, (player_x, player_y))

    # Draw the ground and update the display
    pygame.draw.rect(screen, (0, 0, 0), (0, HEIGHT - GROUND_HEIGHT, WIDTH, GROUND_HEIGHT))
    pygame.display.flip()


    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT]:
        player_x -= 5
    if keys[pygame.K_RIGHT]:
        player_x += 5
    if keys[pygame.K_SPACE] and not is_jumping:
        player_vel_y = JUMP_VELOCITY
        is_jumping = True

    # PLAYER_GRAVITY
    player_vel_y += GRAVITY
    player_y += player_vel_y

    # CHECK COLLISIONS
    if player_y >= HEIGHT - GROUND_HEIGHT - PLAYER_SIZE:
        player_y = HEIGHT - GROUND_HEIGHT - PLAYER_SIZE
        is_jumping = False

    # DRAW
    screen.fill((255, 255, 255))


    # FRAMERATE
    pygame.time.Clock().tick(60)


#EXPERIMENTING :))