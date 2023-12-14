/**
* Temporary Text class
* Stores and controls attributes related to text that should disappear within a set amount of time
*/
class TempText {
    //The position of the text
    private PVector position;
    //The text to be displayed
    private String text;
    //How many frames before the text should disappear
    public int timer;

    public TempText(PVector position, String text) {
        this.position = position;
        this.text = text;
        this.timer = 30;
    }
    
    public TempText(PVector position, String text, int duration) {
        this.position = position;
        this.text = text;
        this.timer = duration;
    }

    /**
    * Tick method
    * Decrements the timer
    */
    public void tick() {
        this.timer--;
    }

    /**
    * Draw method
    * Draw the text
    */
    public void draw() {
        textAlign(CENTER);
        textSize(12);
        fill(0);
        text(text, position.x, position.y);
        textSize(32);
    }
}