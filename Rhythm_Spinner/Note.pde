class Note {
    private int lane;
    private float beat;
    public PVector position;

    Note(int lane, float beat) {
        this.lane = lane;
        this.beat = beat;
    }

    public void update() {
        this.position = new PVector(sin(radians(this.lane * 45)) * ((this.beat - Conductor.songPosition) * 100 + spinner.radius) + 640,
                                    cos(radians(this.lane * 45)) * ((this.beat - Conductor.songPosition) * 100 + spinner.radius) + 512);
    }

    public void draw() {
        float radius = dist(640, 512, this.position.x, this.position.y);
        noFill();
        arc(640, 512, radius, radius, radians(-22.5 + (this.lane * 45)), radians(-22.5 + ((this.lane + 1) * 45)));
    }
}