class Song {
    public int bpm;
    public float offset;
    public SoundFile songFile;

    Song(int bpm, float offset, SoundFile songFile) {
        this.bpm = bpm;
        this.offset = offset;
        this.songFile = songFile;
    }
}