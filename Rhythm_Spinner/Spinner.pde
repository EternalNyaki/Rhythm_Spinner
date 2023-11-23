/**
* Spinner class
* Handles displaying the central spinner that the player controls
*/
class Spinner {
    //The position of the center of the spinner
    private PVector position = new PVector(640, 512);
    //The radius of the spinner (in pixels)
    public float radius = 80;

    //The colour of unselected segments of the spinner
    private color mainColor = color(255, 150, 150);
    //The colour of the selected segment of teh spinner
    private color selectedColor = color(255, 150, 255);

    //The currently selected segment of the spinner (0 is the east segment, increments clockwise from there)
    public int selectedSegment = 0;

    /**
    * Update method
    * Runs in updateInputs()
    */
    public void update() {
        selectedSegment = InputManager.getDirection();
    }

    /**
    * Draw method
    * Draws the spinner to the screen
    * Runs in draw()
    */
    public void draw() {
        for(int i = 0; i < 8; i++) {
            if(i == selectedSegment) {
                fill(selectedColor);
            } else {
                fill(mainColor);
            }

            arc(position.x, position.y, radius, radius, radians(-22.5 + (i * 45)), radians(-22.5 + ((i + 1) * 45)), PIE);
        }
    }
}
