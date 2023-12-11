static class SceneManager {
    public static final Scene[] scenes = new Scene[];

    public static Scene currentScene = scenes[0];

    public static void setScene(int sceneID) {
        try{
            currentScene = scenes[sceneID];
        } catch(Exception e) {
            println("Error changing scenes: " + e);
        }
    }

    public static void setScene(String sceneName) {
        for(Scene scene : scenes) {
            if(scene.name == sceneName) {
                currentScene = scene;
                return;
            }
        }
        println("Error changing scenes: No scene with name " + sceneName);
    }
}