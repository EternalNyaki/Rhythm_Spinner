import java.awt.event.KeyEvent;
import processing.sound.*;

//Central spinner for rhythm game
Spinner spinner = new Spinner();

//Test song file
SoundFile testFile;
SoundFile topOfTheWaveFile;
//Chart for test song
Note[] testChart;
Note[] topOfTheWaveChart;
//Test song
Song testSong;

Song topOfTheWave;

float offset = 0;

float tolerance = 0.1;

void setup() {
    //Setup screen
    size(1280, 1024);

    //Set shape display modes
    rectMode(CENTER);
    ellipseMode(RADIUS);

    //Load sound files
    testFile = new SoundFile(this, "Test Song.wav");
    topOfTheWaveFile = new SoundFile(this, "Songs/Top-of-the-Wave-(Vlad-Gluschenko)/vlad-gluschenko-top-of-the-wave.wav");

    //Load charts
    JSONObject json = loadJSONObject("Songs/Top-of-the-Wave-(Vlad-Gluschenko)/chart.json");
    JSONArray chart = json.getJSONArray("chart");
    topOfTheWaveChart = new Note[chart.size()];
    for(int i = 0; i < chart.size(); i++) {
        topOfTheWaveChart[i] = new Note(chart.getJSONObject(i).getInt("lane"), chart.getJSONObject(i).getFloat("beat"));
    }

    //Initialize songs
    topOfTheWave = new Song(126, 1.2, 2.5, topOfTheWaveFile, topOfTheWaveChart, "Top of the Wave", "Vlad Gluschenko");

    Conductor.setSong(topOfTheWave);
}

void draw() {
    //Clear screen
    background(255);

    updateInputs();

    //Draw spinner
    spinner.draw();

    //Draw notes
    for(Note note : Conductor.chart) {
        note.draw();
    }
}

/**
* Update Inputs function
* For anything that want's to be run more than once a frame
* Function runs in draw and whenever inputs are updated (keyPressed() and keyReleased())
*/
void updateInputs() {
    //Update objects
    spinner.update();
    Conductor.update();
    Conductor.curTime = (float) millis() / 1000;
    if(Conductor.chart != null) {
        for(Note note : Conductor.chart) {
            note.update();
        }
    }

    //Remove missed notes
    for(int i = 0; i < Conductor.chart.size(); i++) {
        while(true) {
            if(Conductor.chart.size() <= 0) {
                break;
            }
            if(Conductor.songPosition > Conductor.chart.get(i).beat + tolerance) {
                Conductor.chart.remove(i);
                println("Miss :.(");
            } else {
                break;
            }
        }
    }
}

void keyPressed() {
    //Update inputs
    InputManager.addKey(keyCode);
    updateInputs();

    //If an arcade button is pressed, check if a note has been hit
    if(InputManager.isArcadeButton(keyCode)) {
        for(int i = 0; i < Conductor.chart.size(); i++) {
            if(Conductor.chart.get(i).beat < Conductor.songPosition + tolerance &&
               Conductor.chart.get(i).beat > Conductor.songPosition - tolerance &&
               Conductor.chart.get(i).lane == spinner.selectedSegment) {
                Conductor.chart.remove(i);
                println("Hit!");
            }
        }
    }

    //If space is pressed, start song (for debugging and testing only, will be removed in future)
    if(keyCode == 32) {
        Conductor.playSong();
    }
}

void keyReleased() {
    //Update inputs
    InputManager.removeKey(keyCode);
    updateInputs();
}