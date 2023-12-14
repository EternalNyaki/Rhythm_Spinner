/**
* Note class
* Keeps track of and draws an individual note
*/
class Note {
    //Lane that the note is in (0-indexed from right, increments clockwise)
    private int lane;
    //Timing of the note (in beats)
    private float beat;

    //Position of the note on the screen
    public PVector position;

    Note(int lane, float beat) {
        this.lane = lane;
        this.beat = beat;
    }

    /**
    * Update method
    * Called in updateInputs
    */
    public void update() {
        this.position = new PVector(cos(radians(this.lane * 45)) * ((this.beat - Conductor.songPosition) * 200 + spinner.radius) + screenCenter.x,
                                    sin(radians(this.lane * 45)) * ((this.beat - Conductor.songPosition) * 200 + spinner.radius) + screenCenter.y);
    }

    /**
    * Draw method
    * Draws the note to the screen
    * Runs in draw()
    */
    public void draw() {
        float radius = dist(screenCenter.x, screenCenter.y, this.position.x, this.position.y);
        noFill();
        stroke(0xFF50FFFF);
        strokeWeight(10);
        arc(screenCenter.x, screenCenter.y, radius, radius, radians(-22.5 + (this.lane * 45) + 2.5), radians(-22.5 + ((this.lane + 1) * 45) - 2.5));
        stroke(0);
        strokeWeight(1);
    }
}