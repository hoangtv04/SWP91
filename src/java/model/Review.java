package model;

import java.util.Date;

public class Review {
    private int reviewID;
    private int customerID;
    private int movieID;
    private int rating;
    private String comment;
    private Date reviewDate;

    // Constructors
    public Review() {
    }

    public Review(int reviewID, int customerID, int movieID, int rating, String comment, Date reviewDate) {
        this.reviewID = reviewID;
        this.customerID = customerID;
        this.movieID = movieID;
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

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
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