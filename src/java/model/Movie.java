/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author tovie
 */
public class Movie {
    private int movieId;
    private String title;
    private String genre;
    private int duration;
    private Date releaseDate;
    private String description;
    private String status;
    

   
    public Movie() {
    }

    
    public Movie(int movieId, String title, String genre, int duration, Date releaseDate, String description, String status) {
        this.movieId = movieId;
        this.title = title;
        this.genre = genre;
        this.duration = duration;
        this.releaseDate = releaseDate;
        this.description = description;
        this.status = status;
        
    }

    
    public int getMovieID() {
        return movieId;
    }

    public void setMovieID(int movieId) {
        this.movieId = movieId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Movie{" + "movieId=" + movieId + ", title=" + title + ", genre=" + genre + ", duration=" + duration + ", releaseDate=" + releaseDate + ", description=" + description + ", status=" + status + '}';
    }

   

   

    

    
}
