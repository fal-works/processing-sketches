def change_target_position(particle):
    particle["target_x"] = random(width)
    particle["target_y"] = random(height)


def update_draw_particle(particle):
    prev_x = particle["x"]
    prev_y = particle["y"]
    next_x = prev_x + (particle["target_x"] - prev_x) / 4
    next_y = prev_y + (particle["target_y"] - prev_y) / 4
    line(prev_x, prev_y, next_x, next_y)
    particle["x"] = next_x
    particle["y"] = next_y


def setup():
    size(800, 800)
    fill(252, 32)
    strokeWeight(8)
    
    global particles
    particles = [{"x": 0, "y": 0, "target_x": 0, "target_y": 0}
                 for i in range(32)]


def draw():
    square(0, 0, 800)
    for particle in particles:
        if frameCount % 30 == 0:
            change_target_position(particle)
        update_draw_particle(particle)
