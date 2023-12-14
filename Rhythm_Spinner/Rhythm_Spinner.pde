import java.awt.event.KeyEvent;
import java.lang.Runnable;
import processing.sound.*;

//Position of the center of the screen (for easy alignment)
final PVector screenCenter = new PVector(640, 512);

//Central spinner for rhythm game
Spinner spinner = new Spinner();

//Sound effects
SoundFile buttonClickFX;
SoundFile noteHitFX;

//Song audio files
SoundFile topOfTheWaveFile;
SoundFile cloudsFile;
SoundFile tonightFile;

//Song charts
Note[] topOfTheWaveChart;
Note[] cloudsChart;
Note[] tonightChart;

//Song cover images
PImage topOfTheWaveCover;
PImage cloudsCover;
PImage tonightCover;

//Songs
Song topOfTheWave;
Song clouds;
Song tonight;

//How far off the beat the player can be to still hit a note perfectly (in beats)
final float tolerance = 0.15;

//Volume values
float musicVolume = 1;
float sfxVolume = 1;

//Score and accuracy, reset on each play
int score = 0;
float accuracy;

//Array for storing the confetti in the S-rank confetti effect
Confetti[] confettiEffect;

//Array for storing all currently displaying timing indicators
ArrayList<TempText> timingIndicators = new ArrayList<TempText>();

//Scene manager, for keeping track of the current scene
SceneManager sceneManager = new SceneManager(new Scene[7]);

//Button layouts of each menu
Button[][] startMenuButtons = {{new Button(new PVector(screenCenter.x, 432), new PVector(640, 160), 0xFFFF9696, 0xFFFF96FF, "START", () -> sceneManager.setScene("Song-Select"))},
                               {new Button(new PVector(screenCenter.x, 656), new PVector(640, 160), 0xFFFF9696, 0xFFFF96FF, "OPTIONS", () -> sceneManager.setScene("Options-Menu"))},
                               {new Button(new PVector(screenCenter.x, 880), new PVector(640, 160), 0xFFFF9696, 0xFFFF96FF, "EXIT", () -> exit())}};

Button[][] songSelectButtons = {{new Button(new PVector(928, 128), new PVector(704, 128), 0xFFFF9696, 0xFFFF96FF, "", () -> {
                                    Conductor.setSong(topOfTheWave);
                                    sceneManager.setScene("Main-Game");
                                    Conductor.playSong();
                                    score = 0;
                                })},
                                {new Button(new PVector(928, 320), new PVector(704, 128), 0xFFFF9696, 0xFFFF96FF, "", () -> {})},
                                {new Button(new PVector(928, 512), new PVector(704, 128), 0xFFFF9696, 0xFFFF96FF, "", () -> {
                                    Conductor.setSong(clouds);
                                    sceneManager.setScene("Main-Game");
                                    Conductor.playSong();
                                    score = 0;
                                })},
                                {new Button(new PVector(928, 704), new PVector(704, 128), 0xFFFF9696, 0xFFFF96FF, "", () -> {
                                    Conductor.setSong(tonight);
                                    sceneManager.setScene("Main-Game");
                                    Conductor.playSong();
                                    score = 0;
                                })},
                                {new Button(new PVector(928, 896), new PVector(704, 128), 0xFFFF9696, 0xFFFF96FF, "", () -> {})}};

Button[][] optionsMenuButtons = {{new Button(new PVector(352, 224), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "0%", () -> musicVolume = 0),
                                  new Button(new PVector(544, 224), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "25%", () -> musicVolume = 0.25),
                                  new Button(new PVector(736, 224), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "50%", () -> musicVolume = 0.5),
                                  new Button(new PVector(928, 224), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "75%", () -> musicVolume = 0.75),
                                  new Button(new PVector(1120, 224), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "100%", () -> musicVolume = 1)},
                                 {new Button(new PVector(352, 320), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "0%", () -> sfxVolume = 0),
                                  new Button(new PVector(544, 320), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "25%", () -> sfxVolume = 0.25),
                                  new Button(new PVector(736, 320), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "50%", () -> sfxVolume = 0.5),
                                  new Button(new PVector(928, 320), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "75%", () -> sfxVolume = 0.75),
                                  new Button(new PVector(1120, 320), new PVector(128, 64), 0xFFFF9696, 0xFFFF96FF, "100%", () -> sfxVolume = 1)},
                                 {null,
                                  null,
                                  null,
                                  new Button(new PVector(928, 544), new PVector(192, 64), 0xFFFF9696, 0xFFFF96FF, "Change", () -> sceneManager.setScene("Button-Change-Select")),
                                  null},
                                 {null,
                                  null,
                                  null,
                                  new Button(new PVector(928, 672), new PVector(192, 64), 0xFFFF9696, 0xFFFF96FF, "Change", () -> sceneManager.setScene("Button-Change-Back")),
                                  null}};

//Menus for each scene
Menu startMenu = new Menu(startMenuButtons);
Menu songSelectMenu = new Menu(songSelectButtons);
Menu optionsMenu = new Menu(optionsMenuButtons);

//Scenes
Scene startMenuScene = new Scene("Start-Menu", () -> {}, () -> {
    //DRAW FUNCTION
    //Draw menu
    startMenu.draw();

    //Draw Title
    textAlign(CENTER, CENTER);
    textSize(96);
    text("RHYTHM SPINNER!", screenCenter.x, 160, 1088, 192);
    textSize(32);
}, () -> {
    //KEY PRESSED FUNCTION
    //Update menu
    startMenu.changeSelection(keyCode);
    if(keyCode == InputManager.selectButton) {
        startMenu.selectedButton.press();
    }
});

Scene songSelectScene = new Scene("Song-Select", () -> {}, () -> {
    //DRAW FUNCTION
    //Draw menu
    songSelectMenu.draw();

    //Draw songs titles and artists on buttons
    textAlign(LEFT, CENTER);
    text(topOfTheWave.title, 1024, 96, 512, 64);
    text(topOfTheWave.artist, 1024, 160, 512, 64);
    text("", 1024, 288, 512, 64);
    text("", 1024, 352, 512, 64);
    text(clouds.title, 1024, 480, 512, 64);
    text(clouds.artist, 1024, 544, 512, 64);
    text(tonight.title, 1024, 672, 512, 64);
    text(tonight.artist, 1024, 736, 512, 64);
    text("", 1024, 864, 512, 64);
    text("", 1024, 928, 512, 64);

    //Draw song difficult on buttons
    textAlign(CENTER, CENTER);
    text("6", 640, 128, 128, 128);
    text("N", 640, 320, 128, 128);
    text("9", 640, 512, 128, 128);
    text("3", 640, 704, 128, 128);
    text("N", 640, 896, 128, 128);

    //Display song info based on selected song
    switch(songSelectMenu.selectedIndex.i) {
        case 0:
            image(topOfTheWave.cover, 288, 288, 288, 288);
            text(topOfTheWave.title, 288, 576, 384, 64);
            text(topOfTheWave.artist, 288, 656, 384, 64);
            text("6/10", 288, 736, 384, 64);
            text(topOfTheWave.bpm + " BPM", 288, 816, 384, 64);
            break;
        
        case 1:
            text("", 288, 576, 384, 64);
            text("", 288, 656, 384, 64);
            text("N/10", 288, 736, 384, 64);
            text("" + " BPM", 288, 816, 384, 64);
            break;

        case 2:
            image(clouds.cover, 288, 288, 288, 288);
            text(clouds.title, 288, 576, 384, 64);
            text(clouds.artist, 288, 656, 384, 64);
            text("9/10", 288, 736, 384, 64);
            text(clouds.bpm + " BPM", 288, 816, 384, 64);
            break;

        case 3:
            image(tonight.cover, 288, 288, 288, 288);
            text(tonight.title, 288, 576, 384, 64);
            text(tonight.artist, 288, 656, 384, 64);
            text("3/10", 288, 736, 384, 64);
            text(tonight.bpm + " BPM", 288, 816, 384, 64);
            break;

        case 4:
            text("", 288, 576, 384, 64);
            text("", 288, 656, 384, 64);
            text("N/10", 288, 736, 384, 64);
            text("" + " BPM", 288, 816, 384, 64);
            break;
    }
}, () -> {
    //KEY PRESSED FUNCTION
    //Update menu
    songSelectMenu.changeSelection(keyCode);
    if(keyCode == InputManager.selectButton) {
        songSelectMenu.selectedButton.press();
    }
    if(keyCode == InputManager.backButton) {
        sceneManager.setScene("Start-Menu");
    }
});

Scene optionsMenuScene = new Scene("Options-Menu", () -> {}, () -> {
    //DRAW FUNCTION
    //Draw menu
    optionsMenu.draw();

    //Draw menu titles
    textAlign(CENTER, CENTER);
    text("Volume", screenCenter.x, 96, 512, 96);
    text("Controls", screenCenter.x, 416, 512, 96);

    textAlign(LEFT, CENTER);
    text("Music: " + musicVolume * 100 + "%", 144, 224, 256, 64);
    text("SFX: " + sfxVolume * 100 + "%", 144, 320, 256, 64);
    text("Select: " + InputManager.selectButton, 144, 544, 256, 64);
    text("Back: " + InputManager.backButton, 144, 672, 256, 64);
}, () -> {
    //KEY PRESSED FUNCTION
    //Update menu
    optionsMenu.changeSelection(keyCode);
    if(keyCode == InputManager.selectButton) {
        optionsMenu.selectedButton.press();
    }
    if(keyCode == InputManager.backButton) {
        sceneManager.setScene("Start-Menu");
    }
});

Scene buttonChangeSelectScene = new Scene("Button-Change-Select", () -> {}, () -> {
    //DRAW FUNCTION
    //Draw info text
    textAlign(CENTER, CENTER);
    text("Press button to set as select button", screenCenter.x, screenCenter.y, 256, 256);
}, () -> {
    //KEY PRESSED FUNCTION
    //Make pressed button the select button
    InputManager.selectButton = keyCode;
    buttonClickFX.play();
    sceneManager.setScene("Options-Menu");
});

Scene buttonChangeBackScene = new Scene("Button-Change-Back", () -> {}, () -> {
    //DRAW FUNCTION
    //Draw info text
    textAlign(CENTER, CENTER);
    text("Press button to set as back button", screenCenter.x, screenCenter.y, 256, 256);
}, () -> {
    //KEY PRESSED FUNCTION
    //Make pressed button the back button
    InputManager.backButton = keyCode;
    buttonClickFX.play();
    sceneManager.setScene("Options-Menu");
});

Scene mainGameScene = new Scene("Main-Game", () -> {
    //UPDATE FUNCTION
    //Update objects
    spinner.update();
    Conductor.update();
    if(Conductor.chart != null) {
        for(Note note : Conductor.chart) {
            note.update();
        }
    }

    //Tick timing indicators
    //I finally found a use for a while loop that isn't vile and disgusting!!!!
    int counter = 0;
    while(counter < timingIndicators.size()) {
        timingIndicators.get(counter).tick();
        if(timingIndicators.get(counter).timer < 0) {
            timingIndicators.remove(counter);
        } else {
            counter++;
        }
    }

    //Remove missed notes
    for(int i = 0; i < Conductor.chart.size(); i++) {
        while(true) {
            if(Conductor.chart.size() <= 0) {
                break;
            }
            if(Conductor.songPosition > Conductor.chart.get(i).beat + tolerance * 2) {
                timingIndicators.add(new TempText(Conductor.chart.get(i).position, "Miss"));
                Conductor.chart.remove(i);
            } else {
                break;
            }
        }
    }

    //Go to results screen if song is over
    if(!Conductor.songFile.isPlaying() && !Conductor.inCountIn) {
        sceneManager.setScene("Results");
        accuracy = (float) score / (Conductor.songData.chart.length * 100);
        if(accuracy > 0.95) {
            confettiEffect = new Confetti[25];
            for(int i = 0; i < confettiEffect.length; i++) {
                confettiEffect[i] = new Confetti();
            }
        }
    }
}, () -> {
    //DRAW FUNCTION
    //Draw spinner
    spinner.draw();
    
    //Draw notes
    for(Note note : Conductor.chart) {
        note.draw();
    }

    //Draw timing indicators
    for(TempText text : timingIndicators) {
        text.draw();
    }

    //Draw song info
    textAlign(LEFT, CENTER);
    fill(0);
    text(score + "", 288, 64, 256, 64);
    text(Conductor.songData.title, 288, 864, 256, 64);
    text(Conductor.songData.artist, 288, 928, 256, 64);
}, () -> {
    //KEY PRESSED FUNCTION
    //If an arcade button is pressed, check if a note has been hit
    if(InputManager.isArcadeButton(keyCode)) {
        for(int i = 0; i < Conductor.chart.size(); i++) {
            if(Conductor.chart.get(i).beat < Conductor.songPosition + tolerance &&
               Conductor.chart.get(i).beat > Conductor.songPosition - tolerance &&
               Conductor.chart.get(i).lane == spinner.selectedSegment) {
                //Perfect judgement
                timingIndicators.add(new TempText(Conductor.chart.get(i).position, "Perfect!"));
                Conductor.chart.remove(i);
                score += 100;
                noteHitFX.play();
                break;
            } else if(Conductor.chart.get(i).beat < Conductor.songPosition + tolerance * 2 &&
               Conductor.chart.get(i).beat > Conductor.songPosition &&
               Conductor.chart.get(i).lane == spinner.selectedSegment) {
                //Early judgement
                timingIndicators.add(new TempText(Conductor.chart.get(i).position, "Early"));
                Conductor.chart.remove(i);
                score += 50;
                noteHitFX.play();
                break;
            } else if(Conductor.chart.get(i).beat < Conductor.songPosition &&
               Conductor.chart.get(i).beat > Conductor.songPosition - tolerance * 2 &&
               Conductor.chart.get(i).lane == spinner.selectedSegment) {
                //Late judgement
                timingIndicators.add(new TempText(Conductor.chart.get(i).position, "Late"));
                Conductor.chart.remove(i);
                score += 50;
                noteHitFX.play();
                break;
            } else if(Conductor.chart.get(i).beat < Conductor.songPosition + tolerance * 3 &&
               Conductor.chart.get(i).beat > Conductor.songPosition &&
               Conductor.chart.get(i).lane == spinner.selectedSegment) {
                //Miss judgement
                timingIndicators.add(new TempText(Conductor.chart.get(i).position, "Miss"));
                Conductor.chart.remove(i);
                break;
            }
        }
    }
});

Scene resultsScene = new Scene("Results", () -> {
    //UPDATE FUNCTION
    //Update confetti
    if(confettiEffect != null) {
        for(Confetti confetti : confettiEffect) {
            confetti.move();
        }
    }
}, () -> {
    //DRAW FUNCTION
    //Draw confetti
    if(confettiEffect != null) {
        for(Confetti confetti : confettiEffect) {
            confetti.draw();
        }
    }

    //Draw grade
    textAlign(CENTER, CENTER);
    String grade;
    color gradeColor;
    if(accuracy < 0.7) {
        grade = "F";
        gradeColor = 0xFF404040;
    } else if(accuracy < 0.8) {
        grade = "D";
        gradeColor = 0xFFFF50FF;
    } else if(accuracy < 0.85) {
        grade = "C";
        gradeColor = 0xFF5050FF;
    } else if(accuracy < 0.9) {
        grade = "B";
        gradeColor = 0xFF50FFFF;
    } else if(accuracy < 0.95) {
        grade = "A";
        gradeColor = 0xFF50FF50;
    } else {
        grade = "S";
        gradeColor = 0xFFA0FF50;
    }
    textSize(128);
    fill(gradeColor);
    text(grade, screenCenter.x, 352, 128, 128);

    //Draw score and accuracy
    textSize(32);
    fill(0);
    text(score + "", screenCenter.x, 576, 256, 64);
    text(accuracy * 100 + "%", screenCenter.x, 672, 256, 64);
}, () -> {
    //KEY PRESSED FUNCTION
    //Exit screen when a button is pressed
    if(InputManager.isArcadeButton(keyCode)) {
        sceneManager.setScene("Song-Select");
        confettiEffect = null;
    }
});

void setup() {
    //Setup screen
    size(1280, 1024);

    //Add scenes to scene manager
    sceneManager.scenes[0] = startMenuScene;
    sceneManager.scenes[1] = songSelectScene;
    sceneManager.scenes[2] = optionsMenuScene;
    sceneManager.scenes[3] = buttonChangeSelectScene;
    sceneManager.scenes[4] = buttonChangeBackScene;
    sceneManager.scenes[5] = mainGameScene;
    sceneManager.scenes[6] = resultsScene;

    //Set display modes
    rectMode(CENTER);
    imageMode(CENTER);
    ellipseMode(RADIUS);
    textSize(32);

    //Load sound files
    buttonClickFX = new SoundFile(this, "SFX/mixkit-single-classic-click-1116.wav");
    noteHitFX = new SoundFile(this, "SFX/Hi-Hat-Closed-Hit-C2-www.fesliyanstudios.com.wav");
    topOfTheWaveFile = new SoundFile(this, "Songs/Top-of-the-Wave-(Vlad-Gluschenko)/vlad-gluschenko-top-of-the-wave.wav");
    cloudsFile = new SoundFile(this, "Songs/Clouds-(MusicbyAden)/musicbyaden-clouds.wav");
    tonightFile = new SoundFile(this, "Songs/tonight-(Rexlambo)/rexlambo-tonight.wav");

    //Load charts
    JSONObject waveJSON = loadJSONObject("Songs/Top-of-the-Wave-(Vlad-Gluschenko)/chart.json");
    JSONObject cloudsJSON = loadJSONObject("Songs/Clouds-(MusicbyAden)/chart.json");
    JSONObject tonightJSON = loadJSONObject("Songs/tonight-(Rexlambo)/chart.json");
    
    //Convert charts
    topOfTheWaveChart = loadChartFromJSON(waveJSON);
    cloudsChart = loadChartFromJSON(cloudsJSON);
    tonightChart = loadChartFromJSON(tonightJSON);

    //Load images
    topOfTheWaveCover = loadImage("Songs/Top-of-the-Wave-(Vlad-Gluschenko)/vlad-gluschenko-top-of-the-wave.jpg");
    cloudsCover = loadImage("Songs/Clouds-(MusicbyAden)/musicbyaden-clouds.jpg");
    tonightCover = loadImage("Songs/tonight-(Rexlambo)/rexlambo-tonight.jpg");

    //Initialize songs
    topOfTheWave = new Song(126, -1.2, 2.5, topOfTheWaveFile, topOfTheWaveChart, "Top of the Wave", "Vlad Gluschenko", topOfTheWaveCover);
    clouds = new Song(120, 0, 4, cloudsFile, cloudsChart, "Clouds", "MusicbyAden", cloudsCover);
    tonight = new Song(128, 0.19, 4, tonightFile, tonightChart, "tonight", "Rexlambo", tonightCover);

    //Set starting scene
    sceneManager.setStartingScene();
}

void draw() {
    //Clear screen
    background(255);
    
    //Set time for conductor (necesary because millis() isn't a static method for some reason, so the compiler throws a fit)
    Conductor.curTime = (float) millis() / 1000;

    //Update current scene
    sceneManager.currentScene.update();

    //Set sound file volumes
    buttonClickFX.amp(sfxVolume);
    noteHitFX.amp(sfxVolume);
    topOfTheWaveFile.amp(musicVolume);
    cloudsFile.amp(musicVolume);
    tonightFile.amp(musicVolume);

    //Draw current scene
    sceneManager.currentScene.draw();
}

void keyPressed() {
    //Update inputs
    InputManager.addKey(keyCode);

    //Run the current scene's keyPressed function
    sceneManager.currentScene.keyPressed();
}

void keyReleased() {
    //Update inputs
    InputManager.removeKey(keyCode);

    //Run the current scene's keyReleased function
    sceneManager.currentScene.keyReleased();
}

/**
* Load Chart from JSON function
* Takes a chart JSON object and returns an array of notes
*
* @param JSONObject for chart to be loaded from
* @return Array of notes in the chart, or null if the JSONObject isn't a chart
*/
Note[] loadChartFromJSON(JSONObject json) {
    JSONArray chart;
    try {
        chart = json.getJSONArray("chart");
    } catch(Exception e) {
        println("Object is not a chart");
        return null;
    }
    Note[] output = new Note[chart.size()];
    for(int i = 0; i < chart.size(); i++) {
        output[i] = new Note(chart.getJSONObject(i).getInt("lane"), chart.getJSONObject(i).getFloat("beat"));
    }
    return output;
}