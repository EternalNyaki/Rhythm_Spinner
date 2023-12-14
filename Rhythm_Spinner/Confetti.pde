/**
* Confetti class
* Stores values relating to a piece of confetti
*/
class Confetti {
    //The current position of the confetti
    private PVector position;
    //The current velocity of the confetti
    private PVector velocity;
    //Acceleration due to gravity
    private final PVector gravity = new PVector(0, 0.1);
    //Terminal velocity, to stop the confetti from accelerating downward forever
    private final float terminalVelocity = 2.5;

    //Radius of the confetti
    private final float radius = 8;
    
    //Color of the confetti
    private color confettiColor;

    public Confetti() {
        this.position = new PVector(screenCenter.x, 1048);

        float angle = radians(random(255, 285));
        this.velocity = PVector.fromAngle(angle).mult(random(11, 13));

        color[] colors = {0xFFFF0000, 0xFFA0FF00, 0xFF00FF00, 0xFF0000FF, 0xFFFF00FF};
        int index = (int) random(colors.length);
        this.confettiColor = colors[index];
    }

    /**
    * Move method
    * Moves the confetti based on its velocity and does physics calculations
    */
    public void move() {
        this.position.add(this.velocity);
        if(this.velocity.y < this.terminalVelocity) {
            this.velocity.add(this.gravity);
        }
    }

    /**
    * Draw method
    * Draws the confetti
    */
    public void draw() {
        fill(this.confettiColor);
        ellipse(this.position.x, this.position.y, this.radius, this.radius);
    }
}