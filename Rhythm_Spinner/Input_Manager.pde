/**
* Input Manger Class
* Stores all currently pressed keys and manages inputs
*/
class InputManager {
    public enum keyCode {
        SHIFT: 16,
        CTRL: 17,
        ALT: 18,
        SPACE: 32,
        LEFT: 37,
        UP: 38,
        RIGHT: 39,
        DOWN: 40,
        KEY_5: 53,
        KEY_C: 67,
        KEY_X: 87,
        KEY_Z: 89
    }

    //List of currently held keys
    public static ArrayList<int> keys = new ArrayList<int>();

    /**
    * Adds a key to the input manager
    * Must be called in keyPressed
    *
    * @param the key to be added
    */
    public static void addKey(int key) {
        keys.add(key);
    }

    /**
    * Removes a key from the input manager
    * Must be called in keyPressed
    *
    * @param the key to be added
    */
    public static void removeKey(int key) {
        keys.remove(key);
    }
}