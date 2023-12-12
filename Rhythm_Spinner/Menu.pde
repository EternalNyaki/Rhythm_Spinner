class Menu {
    private Button[][] buttons;
    public Button selectedButton;
    private Index2D selectedIndex;

    public Menu(Button[][] buttons) {
        this.buttons = buttons;
        this.selectedButton = buttons[0][0];
        this.selectedIndex = new Index2D(0, 0);
    }

    public Menu(Button[][] buttons, Index2D startingIndex) {
        this.buttons = buttons;
        this.selectedButton = buttons[startingIndex.i][startingIndex.j];
        this.selectedIndex = startingIndex;
    }

    public void changeSelection(int key) {
        try {
            switch (key) {
                case KeyEvent.VK_RIGHT:
                    if(this.buttons[this.selectedIndex.i][this.selectedIndex.j + 1] != null) {
                        this.selectedIndex.moveRight();
                    }
                    break;

                case KeyEvent.VK_DOWN:
                    if(this.buttons[this.selectedIndex.i + 1][this.selectedIndex.j] != null) {
                        this.selectedIndex.moveDown();
                    }
                    break;

                case KeyEvent.VK_LEFT:
                    if(this.buttons[this.selectedIndex.i][this.selectedIndex.j - 1] != null) {
                        this.selectedIndex.moveLeft();
                    }
                    break;

                case KeyEvent.VK_UP:
                    if(this.buttons[this.selectedIndex.i - 1][this.selectedIndex.j] != null) {
                        this.selectedIndex.moveUp();
                    }
                    break;
            }
            this.selectedButton = this.buttons[this.selectedIndex.i][this.selectedIndex.j];
        } catch (Exception e) {

        }
    }

    public void draw() {
        for(int i = 0; i < this.buttons.length; i++) {
            for(int j = 0; j < this.buttons[i].length; j++) {
                if(this.buttons[i][j] != null) {
                    this.buttons[i][j].draw(i == selectedIndex.i && j == selectedIndex.j);
                }
            }
        }
    }
}