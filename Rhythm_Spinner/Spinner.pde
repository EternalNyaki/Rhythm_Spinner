class Spinner {
    private PVector position = new PVector(640, 512);
    private float radius = 80;
    private color mainColor = color(255, 150, 150);
    private color selectedColor = color(255, 150, 255);
    public int selectedSegment = 0;

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
