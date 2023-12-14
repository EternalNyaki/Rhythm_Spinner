/**
* Button class
* Stores all attributes related to UI buttons
*/
class Button {
    //Parameters of the rectangle representing the button
    private PVector position;
    private PVector size;

    //Color of the button when not selected
    private color baseColor;
    //Color of the button when selected
    private color selectedColor;

    //Text to be displayed on the button
    private String label;

    //Function to be called when the button is pressed
    private Runnable onPressedFunction;

    public Button(PVector position, PVector size, color baseColor, color selectedColor, String label, Runnable onPressedFunction) {
        this.position = position;
        this.size = size;
        this.baseColor = baseColor;
        this.selectedColor = selectedColor;
        this.label = label;
        this.onPressedFunction = onPressedFunction;
    }

    /**
    * Draw method
    * Draws the button
    * Changes color based on whether or not the button is selected
    *
    * @param Whether or not the button is currently selected
    */
    public void draw(boolean selected) {
        if(selected) {
            fill(this.selectedColor);
        } else {
            fill(this.baseColor);
        }
        rect(this.position.x, this.position.y, this.size.x, this.size.y);
        fill(0);
        textAlign(CENTER, CENTER);
        text(this.label, this.position.x, this.position.y, this.size.x, this.size.y);
    }

    /**
    * Press method
    * Calls the button's on pressed function
    */
    public void press() {
        this.onPressedFunction.run();
        buttonClickFX.play();
    }
}