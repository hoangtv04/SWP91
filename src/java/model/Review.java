package model;

import java.util.Date;

public class Review {
    private int reviewID;
    private int customerID;
    private String customerName; // Thêm trường này
    private int movieID;
    private String movieTitle; // Thêm trường này
    private int rating;
    private String comment;
    private Date reviewDate;

    // Constructors
    public Review() {
    }

    public Review(int reviewID, int customerID, String customerName, int movieID, String movieTitle, int rating, String comment, Date reviewDate) {
        this.reviewID = reviewID;
        this.customerID = customerID;
        this.customerName = customerName;
        this.movieID = movieID;
        this.movieTitle = movieTitle;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
    }

    // Getters and Setters
    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() { // Getter mới
        return customerName;
    }

    public void setCustomerName(String customerName) { // Setter mới
        this.customerName = customerName;
    }

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public String getMovieTitle() { // Getter mới
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) { // Setter mới
        this.movieTitle = movieTitle;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }
}
