class Song {
    public int bpm;
    public float offset;
    public SoundFile songFile;
    public ArrayList<Note> chart;
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