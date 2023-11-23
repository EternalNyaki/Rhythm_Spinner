import java.awt.event.KeyEvent;
import processing.sound.*;

Spinner spinner = new Spinner();
SoundFile testFile;
ArrayList<Note> testChart = new ArrayList<Note>();
Song testSong;

void setup() {
    size(1280, 1024);
    rectMode(CENTER);
    ellipseMode(RADIUS);

    testFile = new SoundFile(this, "Test Song.wav");

    testChart.add(new Note(0, 1));
    testChart.add(new Note(4, 2));
    testChart.add(new Note(0, 3.5));
    testChart.add(new Note(4, 4));

    testSong = new Song(120, 0.002, testFile, testChart, "Test Song", "Me");
}

void draw() {
    background(255);

    updateInputs();

    spinner.draw();

    for(Note note : testSong.chart) {
        note.draw();
    }
}

void updateInputs() {
    spinner.update();
    Conductor.update();

    for(Note note : testSong.chart) {
        note.update();
    }
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
    InputManager.addKey(keyCode);
    updateInputs();

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

    if(keyCode == 32) {
        Conductor.setSong(testSong);
        testSong.songFile.play();
        println(Conductor.crotchet);
    }
}

void keyReleased() {
    InputManager.removeKey(keyCode);
    updateInputs();
}