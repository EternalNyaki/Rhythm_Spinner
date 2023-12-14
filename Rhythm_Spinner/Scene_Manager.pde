/**
* Scene Manager class
* Stores and manages scenes
* DO NOT CREATE MORE THAN ONE INSTANCE OF THIS CLASS
* (Should be static, but processing doesn't like referencing variables or functions
* from the main file in static classes)
*
* I hate processing
*/
class SceneManager {
    //Scenes in the game
    //Filled in setup() because processing doesn't like initializing non-empty arrays for some reason
    //There's also the very real chance I'm an idiot and missed something obvious but I'm not messing with it now
    public Scene[] scenes;

    //Currently playing scene
    public Scene currentScene;

    public SceneManager(Scene[] scenes) {
        this.scenes = scenes;
        this.currentScene = scenes[0];
    }

    /**
    * Set Starting Scene method
    * Sets the current scene to the first scene in the list of scenes
    * Only required because the list of scenes is populated after the array is created
    * ONLY CALL THIS ONCE AT THE END OF SETUP
    */
    public void setStartingScene() {
        this.currentScene = scenes[0];
    }

    /**
    * Set Scene method
    * Sets the current scene to the scene with the given ID
    *
    * @param The ID of the scene to be set
    */
    public void setScene(int sceneID) {
        try{
            currentScene = scenes[sceneID];
        } catch(Exception e) {
            println("Error changing scenes: " + e);
        }
    }

    /**
    * Set Scene method
    * Sets the current scene to the scene with the given name
    *
    * @param The name of the scene to be set
    */
    public void setScene(String sceneName) {
        for(Scene scene : scenes) {
            if(scene.name == sceneName) {
                currentScene = scene;
                return;
            }
        }
        println("Error changing scenes: No scene with name " + sceneName);
    }
}