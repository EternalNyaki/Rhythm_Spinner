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
        this.position = new PVector(sin(radians(this.lane * 45)) * ((this.beat - Conductor.songPosition) * 100 + spinner.radius) + 640,
                                    cos(radians(this.lane * 45)) * ((this.beat - Conductor.songPosition) * 100 + spinner.radius) + 512);
    }

    /**
    * Draw method
    * Draws the note to the screen
    * Runs in draw()
    */
    public void draw() {
        float radius = dist(640, 512, this.position.x, this.position.y);
        noFill();
        arc(640, 512, radius, radius, radians(-22.5 + (this.lane * 45)), radians(-22.5 + ((this.lane + 1) * 45)));
    }
}