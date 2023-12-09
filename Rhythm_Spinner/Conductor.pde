/**
* Conductor class
* Controls timing for rhythm elements
* Taken from https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/
*/
static class Conductor {
    //Beat per minute of the song currently being played
    private static int bpm;
    //Length of a beat of the song currently being played (in seconds)
    private static float crotchet;
    //Time before the song actually starts in the audio file (to account for space required for metadata) (in seconds)
    private static float offset;

    private static float countIn;

    private static float startTime;

    //Position in the current song (in beats)
    public static float songPosition;
    //Audio file for the song currently being played
    private static SoundFile songFile;

    public static ArrayList<Note> chart = new ArrayList<Note>();

    private static boolean playing = false;

    public static float curTime;

    /**
    * Update method
    * Runs in updateInputs()
    */
    public static void update() {
        if(songFile != null) {
            if(playing && !songFile.isPlaying() && curTime - startTime > countIn * crotchet) {
                println(curTime - startTime);
                println(countIn * crotchet);
                songFile.play();
            }
            songPosition = (songFile.position() + offset) / crotchet;
        }
    }

    /**
    * Set Song method
    * Sets the current song being played
    *
    * @param song to be played
    */
    public static void setSong(Song song) {
        bpm = song.bpm;
        crotchet = (float) 60 / song.bpm;
        offset = song.offset;
        countIn = song.countIn;
        songFile = song.songFile;
        chart.clear();
        for(Note note : song.chart) {
            chart.add(note);
        }
    }

    public static void playSong() {
        if(!playing && songFile != null) {
            startTime = curTime;
            playing = true;
        }
    }
}