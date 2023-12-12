class Scene {
    public String name;

    private Runnable updateFunction;
    private Runnable drawFunction;
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

    public void update() {
        updateFunction.run();
    }

    public void draw() {
        drawFunction.run();
    }

    public void keyPressed() {
        keyPressedFunction.run();
    }

    public void keyReleased() {
        keyReleasedFunction.run();
    }
}