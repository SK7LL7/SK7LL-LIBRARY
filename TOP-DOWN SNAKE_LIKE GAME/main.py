import pygame
import sys
import random

pygame.init()

#SCREEB DISPLAY
width, height = 800, 600
screen = pygame.display.set_mode((width, height))
pygame.display.set_caption("SIMPLE TOP DOWN SNAKE-LIKE GAME")

#COLORS :P
WHITE = (255, 255, 255)
RED = (255, 0, 0)
GREEN = (0, 255, 0)

#PLAYER_PROPERTIES
character_size = 50
character_x = width // 2 - character_size // 2
character_y = height // 2 - character_size // 2
character_speed = 2


goal_size = 30
goal_x = random.randint(0, width - goal_size)
goal_y = random.randint(0, height - goal_size)

#SCORE
score = 0
font = pygame.font.Font(None, 36)

#RESET THE GREEN POSITION :]
def reset_goal_position():
    global goal_x, goal_y
    goal_x = random.randint(0, width - goal_size)
    goal_y = random.randint(0, height - goal_size)

#WHILE LOOP
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    keys = pygame.key.get_pressed()

    if keys[pygame.K_LEFT]:
        character_x -= character_speed
    if keys[pygame.K_RIGHT]:
        character_x += character_speed
    if keys[pygame.K_UP]:
        character_y -= character_speed
    if keys[pygame.K_DOWN]:
        character_y += character_speed

    character_x = max(0, min(width - character_size, character_x))
    character_y = max(0, min(height - character_size, character_y))

    if (
        character_x < goal_x + goal_size
        and character_x + character_size > goal_x
        and character_y < goal_y + goal_size
        and character_y + character_size > goal_y
    ):
        score += 1
        reset_goal_position()

    screen.fill(WHITE)

    pygame.draw.rect(screen, RED, (character_x, character_y, character_size, character_size))

    pygame.draw.rect(screen, GREEN, (goal_x, goal_y, goal_size, goal_size))

    score_text = font.render("Score: " + str(score), True, RED)
    screen.blit(score_text, (10, 10))

    #UPDATE
    pygame.display.update()


#TEST THE SCENE!
#NOT FULLY BUILD YET 
#-SK7LL
