package model;

public class Cinema {
    private int cinemaID;
    private String cinemaName;
    private String location;
    private int numberOfScreen;
    private Admin adminID;

    public Cinema() {}

    

    public int getCinemaID() {
        return cinemaID;
    }

    public void setCinemaID(int cinemaID) {
        this.cinemaID = cinemaID;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getNumberOfScreen() {
        return numberOfScreen;
    }

    public void setNumberOfScreen(int numberOfScreen) {
        this.numberOfScreen = numberOfScreen;
    }

    public Admin getAdminID() {
        return adminID;
    }

    public void setAdminID(Admin adminID) {
        this.adminID = adminID;
    }

    
}
