class Spinner {
    private PVector position = new PVector(640, 512);
    private int selectedSegment = 0;
    private Spinner instance;
    
    public static Spinner getInstance() {
        if(instance == null) {
            instance = new Spinner();
        }

        return instance;
    }

    
}
