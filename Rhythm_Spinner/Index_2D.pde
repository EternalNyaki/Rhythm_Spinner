class Index2D {
    public int i;
    public int j;

    public Index2D(int i, int j) {
        this.i = i;
        this.j = j;
    }

    public void moveUp() {
        this.i--;
    }

    public void moveDown() {
        this.i++;
    }

    public void moveLeft() {
        this.j--;
    }

    public void moveRight() {
        this.j++;
    }
}