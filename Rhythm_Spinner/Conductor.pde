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

    //Time to wait before starting the song (in beats)
    private static float countIn;
    //Time at which the song began playing (start of count in) (in seconds)
    private static float startTime;
    //The current program time (in seconds)
    public static float curTime;


    //Position in the current song (in beats)
    public static float songPosition;
    //Audio file for the song currently being played
    public static SoundFile songFile;
    //Song object of the song currently being played, for accessing extra information
    public static Song songData;

    //A copy of the chart of the current song (must be a copy, as notes will be removed from this version during runtime)
    public static ArrayList<Note> chart = new ArrayList<Note>();

    //Whether or not the song is currently in count in, to ensure songs don't end before they start
    public static boolean inCountIn = false;

    /**
    * Update method
    * Updates the conductor
    */
    public static void update() {
        if(songFile != null) {
            if(inCountIn) {
                if(!songFile.isPlaying() && curTime - startTime > countIn * crotchet) {
                    //End count in, start playing the song
                    songFile.play();
                    inCountIn = false;
                }

                //Set song position
                songPosition = ((curTime - startTime) / crotchet) - countIn - (offset / crotchet);
            } else {
                //Update song position
                songPosition = (songFile.position() - offset) / crotchet;
            }
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
        songData = song;
        chart.clear();
        for(Note note : song.chart) {
            chart.add(note);
        }
    }

    /**
    * Play Song method
    * Begins playing the current song
    */
    public static void playSong() {
        if(!inCountIn && songFile != null) {
            startTime = curTime;
            inCountIn = true;
        }
    }
}