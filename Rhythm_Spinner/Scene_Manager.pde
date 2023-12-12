class SceneManager {
    public Scene[] scenes;

    public Scene currentScene;

    public SceneManager(Scene[] scenes) {
        this.scenes = scenes;
        this.currentScene = scenes[0];
    }

    public void setStartingScene() {
        this.currentScene = scenes[0];
    }

    public void setScene(int sceneID) {
        try{
            currentScene = scenes[sceneID];
        } catch(Exception e) {
            println("Error changing scenes: " + e);
        }
    }

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