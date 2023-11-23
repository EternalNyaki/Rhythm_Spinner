import java.awt.event.KeyEvent;
import processing.sound.*;

//Central spinner for rhythm game
Spinner spinner = new Spinner();

//Test song file
SoundFile testFile;
//Chart for test song
ArrayList<Note> testChart = new ArrayList<Note>();
//Test song
Song testSong;

void setup() {
    //Setup screen
    size(1280, 1024);

    //Set shape display modes
    rectMode(CENTER);
    ellipseMode(RADIUS);

    //Load sound files
    testFile = new SoundFile(this, "Test Song.wav");

    //Create chart
    testChart.add(new Note(0, 1));
    testChart.add(new Note(4, 2));
    testChart.add(new Note(0, 3.5));
    testChart.add(new Note(4, 4));

    //Initialize songs
    testSong = new Song(120, 0.002, testFile, testChart, "Test Song", "Me");
}

void draw() {
    //Clear screen
    background(255);

    updateInputs();

    //Draw spinner
    spinner.draw();

    //Draw notes
    for(Note note : testSong.chart) {
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
    for(Note note : testSong.chart) {
        note.update();
    }

    //Remove missed notes
    for(int i = 0; i < testSong.chart.size(); i++) {
        while(true) {
            if(testSong.chart.size() <= 0) {
                break;
            }
            if(Conductor.songPosition > testSong.chart.get(i).beat + 0.25) {
                testSong.chart.remove(i);
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
        for(int i = 0; i < testSong.chart.size(); i++) {
            if(testSong.chart.get(i).beat < Conductor.songPosition + 0.25 &&
               testSong.chart.get(i).beat > Conductor.songPosition - 0.25 &&
               testSong.chart.get(i).lane == spinner.selectedSegment) {
                testSong.chart.remove(i);
                println("Hit!");
            }
        }
    }

    //If space is pressed, start song (for debugging and testing only, will be removed in future)
    if(keyCode == 32) {
        Conductor.setSong(testSong);
        testSong.songFile.play();
    }
}

void keyReleased() {
    //Update inputs
    InputManager.removeKey(keyCode);
    updateInputs();
}