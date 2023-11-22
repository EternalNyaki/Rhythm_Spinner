/**
* Input Manger Class
* Stores all currently pressed keys and manages inputs
*/
static class InputManager {

    //List of currently held keys
    public static ArrayList<Integer> keys = new ArrayList<Integer>();

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