package model;

import java.security.Timestamp;
import java.util.Date;

public class Showtime {

    private int showtimeID;
    private Movie movieID;
    private Screen screenID;
    private Date startTime;
    private Date endTime;
    private Admin adminID;

    public Showtime() {
    }

    public int getShowtimeID() {
        return showtimeID;
    }

    public void setShowtimeID(int showtimeID) {
        this.showtimeID = showtimeID;
    }

    public Movie getMovieID() {
        return movieID;
    }

    public void setMovieID(Movie movieID) {
        this.movieID = movieID;
    }

    public Screen getScreenID() {
        return screenID;
    }

    public void setScreenID(Screen screenID) {
        this.screenID = screenID;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Admin getAdminID() {
        return adminID;
    }

    public void setAdminID(Admin adminID) {
        this.adminID = adminID;
    }

    public Showtime(int showtimeID, int movieID, int screenID, Date startTime, Date endTime, int adminID) {
        this.showtimeID = showtimeID;
        this.movieID = new Movie();
        this.movieID.setMovieID(movieID);
        this.screenID = new Screen();
        this.screenID.setScreenID(screenID);

        // Chuyển đổi Timestamp sang Date
        this.startTime = startTime;
        this.endTime = endTime;
        this.adminID = new Admin();
        this.adminID.setAdminId(adminID);
    }


}
