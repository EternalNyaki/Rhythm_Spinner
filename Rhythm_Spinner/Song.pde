class Song {
    public int bpm;
    public float offset;
    public SoundFile songFile;
    public Note[] chart;

    Song(int bpm, float offset, SoundFile songFile, Note[] chart) {
        this.bpm = bpm;
        this.offset = offset;
        this.songFile = songFile;
        this.chart = chart;
    }
}