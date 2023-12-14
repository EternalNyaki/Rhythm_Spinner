/**
* Scene class
* Stores data related to an in-game scene
*/
class Scene {
    //The name of the scene
    public String name;

    //Functions to be called for to update the scene
    private Runnable updateFunction; //Should be used for anything that needs to run every frame that doesn't involve displaying objects
    private Runnable drawFunction; //Should only be used for displaying objects
    private Runnable keyPressedFunction;
    private Runnable keyReleasedFunction;

    public Scene(String name, Runnable updateFunction, Runnable drawFunction) {
        this.name = name;
        this.updateFunction = updateFunction;
        this.drawFunction = drawFunction;
        this.keyPressedFunction = () -> {};
        this.keyReleasedFunction = () -> {};
    }

    public Scene(String name, Runnable updateFunction, Runnable drawFunction, Runnable keyPressedFunction) {
        this.name = name;
        this.updateFunction = updateFunction;
        this.drawFunction = drawFunction;
        this.keyPressedFunction = keyPressedFunction;
        this.keyReleasedFunction = () -> {};
    }

    public Scene(String name, Runnable updateFunction, Runnable drawFunction, Runnable keyPressedFunction, Runnable keyReleasedFunction) {
        this.name = name;
        this.updateFunction = updateFunction;
        this.drawFunction = drawFunction;
        this.keyPressedFunction = keyPressedFunction;
        this.keyReleasedFunction = keyPressedFunction;
    }

    /**
    * Update method
    * Calls the scene's update function
    * Should be called before the scene's draw method
    */
    public void update() {
        updateFunction.run();
    }

    /**
    * Draw method
    * Calls the scene's draw function
    * Should be called after the scene's update method
    */
    public void draw() {
        drawFunction.run();
    }

    /**
    * Key Pressed method
    * Calls the scene's key pressed function
    */
    public void keyPressed() {
        keyPressedFunction.run();
    }

    /**
    * Key Released method
    * Calls the scene's key released function
    */
    public void keyReleased() {
        keyReleasedFunction.run();
    }
}