package model;

public class Screen {
    private int screenID;
    private Cinema cinemaID;
    private String screenName;
    private int totalSeat;

    public Screen() {}

    

    public int getScreenID() {
        return screenID;
    }

    public void setScreenID(int screenID) {
        this.screenID = screenID;
    }

    public Cinema getCinemaID() {
        return cinemaID;
    }

    public void setCinemaID(Cinema cinemaID) {
        this.cinemaID = cinemaID;
    }

    

    public String getScreenName() {
        return screenName;
    }

    public void setScreenName(String screenName) {
        this.screenName = screenName;
    }

    public int getTotalSeat() {
        return totalSeat;
    }

    public void setTotalSeat(int totalSeat) {
        this.totalSeat = totalSeat;
    }
}
