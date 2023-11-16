/**
* Input Manger Class
* Stores all currently pressed keys and manages inputs
*/
class InputManager {
    //List of currently held keys
    public static ArrayList keys = new ArrayList();

    /**
    * Updates the input manager
    * Must be called every frame
    */
    public static void update() {
        if(keyPressed) {
            if(key == CODED) {
                keys.add(keyCode);
            } else {
                keys.add(key);
            }
        }

        if(keyReleased) {
            if(key == CODED) {
                keys.remove(keys.indexOf(keyCode));
            } else {
                keys.remove(keys.indexOf(keyCode));
            }
        }
    }
}