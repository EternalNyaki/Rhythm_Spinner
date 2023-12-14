/**
* Input Manger Class
* Stores all currently pressed keys and manages inputs
*/
static class InputManager {

    //List of currently held keys
    public static ArrayList<Integer> keys = new ArrayList<Integer>();

    //Buttons with special functions
    public static int selectButton = KeyEvent.VK_Z;
    public static int backButton = KeyEvent.VK_X;

    /**
    * Add Key method
    * Adds a key to the input manager
    * Must be called in keyPressed
    *
    * @param the key to be added
    */
    public static void addKey(int key) {
        if(!keys.contains(key)) {
            keys.add(key);
        }
    }

    /**
    * Remove Key method
    * Removes a key from the input manager
    * Must be called in keyRemoved
    *
    * @param the key to be added
    */
    public static void removeKey(int key) {
        keys.remove(keys.indexOf(key));
    }

    /**
    * Get Direction method
    * Returns the direction that is currently pressing on the arrow keys (including diagonals)
    * Value is 0-indexed starting from the right and increasing clockwise
    *
    * @return the direction being input on the arrow keys (0-index from right, increasing clockwise)
    */
    public static int getDirection() {
        if(keys.contains(KeyEvent.VK_RIGHT) && keys.contains(KeyEvent.VK_DOWN)) {
            return 1;
        } else if(keys.contains(KeyEvent.VK_LEFT) && keys.contains(KeyEvent.VK_DOWN)) {
            return 3;
        } else if(keys.contains(KeyEvent.VK_LEFT) && keys.contains(KeyEvent.VK_UP)) {
            return 5;
        } else if(keys.contains(KeyEvent.VK_RIGHT) && keys.contains(KeyEvent.VK_UP)) {
            return 7;
        } else if(keys.contains(KeyEvent.VK_RIGHT)) {
            return 0;
        } else if(keys.contains(KeyEvent.VK_DOWN)) {
            return 2;
        } else if(keys.contains(KeyEvent.VK_LEFT)) {
            return 4;
        } else if(keys.contains(KeyEvent.VK_UP)) {
            return 6;
        }

        return -1;
    }

    /**
    * Is Arcade Button method
    * Returns whether of not the key being pressed in one of the buttons on the arcade cabinet
    * (Buttons are assigned to ctrl, alt, space, shift, z, x, c, and 5)
    *
    * @return true if key is an arcade cabinet button, otherwise false
    */
    public static boolean isArcadeButton(int key) {
        return (key == KeyEvent.VK_CONTROL ||
                key == KeyEvent.VK_ALT ||
                key == KeyEvent.VK_SPACE ||
                key == KeyEvent.VK_SHIFT ||
                key == KeyEvent.VK_Z ||
                key == KeyEvent.VK_X ||
                key == KeyEvent.VK_C ||
                key == KeyEvent.VK_5);
    }
}