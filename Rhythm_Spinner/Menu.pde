class Menu {
    public Button[][] buttons;
    public Index2D selectedIndex;

    public Menu(Button[][] buttons) {
        this.buttons = buttons;
        this.selectedIndex = new Index2D(0, 0);
    }

    public Menu(Button[][] buttons, Index2D startingIndex) {
        this.buttons = buttons;
        this.selectedIndex = startingIndex;
    }

    public void changeSelection(int direction) {
        switch (direction) {
            case 0:
                this.selectedIndex.moveRight();
                break;

            case 1:
                this.selectedIndex.moveDown();
                break;

            case 2:
                this.selectedIndex.moveLeft();
                break;

            case 3:
                this.selectedIndex.moveUp();
                break;
        }
    }

    public void draw() {
        for(int i = 0; i < buttons.Length; i++) {
            for(int j = 0; j < buttons[i].Length; j++) {
                buttons[i][j].draw(i == selectedIndex.i && j == selectedIndex.j);
            }
        }
    }
}