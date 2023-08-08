import pygame
import random
import math

pygame.init()

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

WHITE = (255, 255, 255)
GREEN = (0, 128, 0)

screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("AVOID IT MATE :)")


#PROPERTIES
player_size = 50
player_x = SCREEN_WIDTH // 2
player_y = SCREEN_HEIGHT - player_size
player_speed = 20

player_sprite = pygame.image.load("player.png")
player_sprite = pygame.transform.scale(player_sprite, (player_size, player_size))


obstacle_width = 50
obstacle_height = 30
obstacle_speed = 20
obstacle_radius = 20
obstacles = []

clock = pygame.time.Clock()

#LOOP 
running = True
score = 0

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    screen.blit(player_sprite, (player_x, player_y))
    pygame.display.flip()

    keys = pygame.key.get_pressed()
    if keys[pygame.K_a] and player_x > 0:
        player_x -= player_speed
    if keys[pygame.K_d] and player_x < SCREEN_WIDTH - player_size:
        player_x += player_speed

    # Generate new obstacles randomly
    if random.randint(1, 100) < 5:
        obstacles.append((random.randint(0, SCREEN_WIDTH), 0))

    # Move obstacles
    for obstacle in obstacles:
        obstacle_y = obstacle[1] + obstacle_speed
        if obstacle_y > SCREEN_HEIGHT:
            obstacles.remove(obstacle)
            score += 1
        else:
            obstacles[obstacles.index(obstacle)] = (obstacle[0], obstacle_y)

    for obstacle in obstacles:
        distance = math.sqrt((obstacle[0] - player_x)**2 + (obstacle[1] - player_y)**2)
        if distance < obstacle_radius:
            running = False

    screen.fill(WHITE)


    for obstacle in obstacles:
        pygame.draw.circle(screen, GREEN, obstacle, obstacle_radius)



    clock.tick(30)

print("Game Over Noob! Your score:", score)

pygame.quit()


#EXPERIMENT THE CODES AND MAKE IT A FULL GAME! :> -SK7LL