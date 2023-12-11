class Button {
    private PVector position;
    private PVector size;
    private color baseColor;
    private color selectedColor;
    private String label;

    private Function<void, void> onPressedFunction;

    public Button(PVector position, PVector size, color baseColor, color selectedColor, String label, Function<void, void> onPressedFunction) {
        this.position = position;
        this.size = size;
        this.baseColor = baseColor;
        this.selectedColor = selectedColor;
        this.label = label;
        this.onPressedFunction = onPressedFunction;
    }

    public void draw(boolean selected) {
        if(selected) {
            fill(this.selectedColor);
        } else {
            fill(this.baseColor);
        }
        rect(this.position.x, this.position.y, this.size.x, this.size.y);
        text(this.label, this.position.x, this.position.y, this.size.x, this.size.y);
    }

    public void press() {
        this.onPressedFunction.apply();
    }
}