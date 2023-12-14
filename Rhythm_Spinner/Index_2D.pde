/**
* Index 2D class
* Stores an index into a 2D array
*/
class Index2D {
    //Indecies
    public int i;
    public int j;

    public Index2D(int i, int j) {
        this.i = i;
        this.j = j;
    }

    /**
    * Move Up method
    * Moves the index up one row
    */
    public void moveUp() {
        this.i = max(this.i - 1, 0);
    }

    /**
    * Move Down method
    * Moves the index down one row
    */
    public void moveDown() {
        this.i++;
    }

    /**
    * Move Left method
    * Moves the index left one column
    */
    public void moveLeft() {
        this.j = max(this.j - 1, 0);
    }

    /**
    * Move Right method
    * Moves the index right one column
    */
    public void moveRight() {
        this.j++;
    }
}