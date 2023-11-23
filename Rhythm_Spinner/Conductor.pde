/**
* Conductor class
* Taken from https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/
*/
static class Conductor {
    private static int bpm;
    private static float crotchet;
    private static float offset;
    public static float songPosition;
    private static SoundFile songFile;

    public static void update() {
        if(songFile != null) {

            songPosition = (songFile.position() - offset) / crotchet;
        }
    }

    public static void setSong(Song song) {
        bpm = song.bpm;
        crotchet = (float) 60 / song.bpm;
        offset = song.offset;
        songFile = song.songFile;
    }
}