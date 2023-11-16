/**
* Input Manger Class
* Stores all currently pressed keys and manages inputs
*/
class InputManager {
    //List of currently held keys
    public static ArrayList keys = new ArrayList();

    /**
    * Adds a key the input manager
    * Must be called in keyPressed
    *
    * @param the key to be added
    */
    public static void addKey(char key) {
        keys.add(key);
    }

    public static void addKey(keyCode key)
}