import java.awt.event.KeyEvent;

Spinner spinner = new Spinner();

void setup() {
    size(1280, 1024);
    rectMode(CENTER);
    ellipseMode(RADIUS);
}

void draw() {
    updateInputs();

    spinner.draw();
}

void updateInputs() {
    spinner.update();
}

void keyPressed() {
    InputManager.addKey(keyCode);
    updateInputs();
}

void keyReleased() {
    InputManager.removeKey(keyCode);
    updateInputs();
}