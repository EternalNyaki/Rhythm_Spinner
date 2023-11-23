/**
* Song class
* Stores all data related to a song
*/
class Song {
    //Beats per minute
    public int bpm;
    //Time before the song actually starts in the audio file (to account for space required for metadata) (in seconds)
    public float offset;

    //Audio file associated with song
    public SoundFile songFile;
    //Chart associated with song
    public ArrayList<Note> chart;

    //Name of song and artist (not currently used)
    public String title, artist;

    Song(int bpm, float offset, SoundFile songFile, ArrayList<Note> chart, String title, String artist) {
        this.bpm = bpm;
        this.offset = offset;
        this.songFile = songFile;
        this.chart = chart;
        this.title = title;
        this.artist = artist;
    }
}