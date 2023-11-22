/**
* Conductor class
* Taken from https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/
*/
static class Conductor {
    private int bpm;
    private float crotchet;
    private float offset;
    public float songPosition;
    private SoundFile songFile;

    public static void update() {

    }

    public static void setSong(Song song) {
        bpm = song.bpm;
        crotchet = 60 / song.bpm;
        offset = song.offset;
        songFile = song.songFile;
    }
}