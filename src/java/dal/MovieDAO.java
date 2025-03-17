package dal;

import model.Movie;
import model.Showtime;
import model.Review;
import model.Cinema;
import model.Screen;
import model.Seat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.Admin;

public class MovieDAO extends DBContext {

    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM Movie";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Movie movie = new Movie();
                movie.setMovieID(rs.getInt("MovieID"));
                movie.setTitle(rs.getString("Title"));
                movie.setGenre(rs.getString("Genre"));
                movie.setDuration(rs.getInt("Duration"));
                movie.setReleaseDate(rs.getDate("ReleaseDate"));
                movie.setDescription(rs.getString("Description"));
                movies.add(movie);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movies;
    }

    public Movie getMovieById(int movieID) {
        Movie movie = null;
        String sql = "SELECT * FROM Movie WHERE movieID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    movie = new Movie();
                    movie.setMovieID(rs.getInt("movieID"));
                    movie.setTitle(rs.getString("title"));
                    movie.setGenre(rs.getString("genre"));
                    movie.setDuration(rs.getInt("duration"));
                    movie.setReleaseDate(rs.getDate("releaseDate"));
                    movie.setDescription(rs.getString("description"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movie;
    }

    public List<Showtime> getShowtimesByMovieId(int movieID) {
        List<Showtime> showtimes = new ArrayList<>();
        String sql = "SELECT s.*, sc.*, c.*, a.* FROM Showtime s " +
                     "JOIN Screen sc ON s.ScreenID = sc.ScreenID " +
                     "JOIN Cinema c ON sc.CinemaID = c.CinemaID " +
                     "JOIN Admin a ON s.AdminID = a.AdminID " +
                     "WHERE s.MovieID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Showtime showtime = new Showtime();
                    showtime.setShowtimeID(rs.getInt("ShowtimeID"));
                    showtime.setStartTime(rs.getTimestamp("StartTime"));
                    showtime.setEndTime(rs.getTimestamp("EndTime"));

                    Screen screen = new Screen();
                    screen.setScreenID(rs.getInt("ScreenID"));
                    screen.setScreenName(rs.getString("ScreenName"));
                    screen.setTotalSeat(rs.getInt("TotalSeat"));

                    Cinema cinema = new Cinema();
                    cinema.setCinemaID(rs.getInt("CinemaID"));
                    cinema.setCinemaName(rs.getString("CinemaName"));
                    cinema.setLocation(rs.getString("Location"));
                    cinema.setNumberOfScreen(rs.getInt("NumberOfScreen"));

                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("AdminID"));
                    admin.setName(rs.getString("Name"));
                    admin.setEmail(rs.getString("Email"));
                    admin.setPassword(rs.getString("Password"));

                    screen.setCinemaID(cinema);
                    showtime.setScreenID(screen);
                    showtime.setAdminID(admin);

                    showtimes.add(showtime);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    public List<Review> getReviewsByMovieId(int movieID, Map<Integer, String> customerNames) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, c.CustomerName FROM Review r JOIN Customer c ON r.CustomerID = c.CustomerID WHERE r.MovieID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewID(rs.getInt("ReviewID"));
                    review.setCustomerID(rs.getInt("CustomerID"));
                    review.setMovieID(rs.getInt("MovieID"));
                    review.setRating(rs.getInt("Rating"));
                    review.setComment(rs.getString("Comment"));
                    review.setReviewDate(rs.getDate("ReviewDate"));
                    customerNames.put(review.getCustomerID(), rs.getString("CustomerName"));
                    reviews.add(review);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public void addReview(Review review) {
        String sql = "INSERT INTO Review (CustomerID, MovieID, Rating, Comment, ReviewDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getCustomerID());
            ps.setInt(2, review.getMovieID());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            ps.setDate(5, new java.sql.Date(review.getReviewDate().getTime()));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteReview(int reviewID) {
        String sql = "DELETE FROM Review WHERE ReviewID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Review getReviewById(int reviewID) {
        Review review = null;
        String sql = "SELECT * FROM Review WHERE ReviewID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    review = new Review();
                    review.setReviewID(rs.getInt("ReviewID"));
                    review.setCustomerID(rs.getInt("CustomerID"));
                    review.setMovieID(rs.getInt("MovieID"));
                    review.setRating(rs.getInt("Rating"));
                    review.setComment(rs.getString("Comment"));
                    review.setReviewDate(rs.getDate("ReviewDate"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;
    }

    public void updateReview(Review review) {
        String sql = "UPDATE Review SET Rating = ?, Comment = ?, ReviewDate = ? WHERE ReviewID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getRating());
            ps.setString(2, review.getComment());
            ps.setDate(3, new java.sql.Date(review.getReviewDate().getTime()));
            ps.setInt(4, review.getReviewID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public String getCustomerNameById(int customerId) {
        String sql = "SELECT Name FROM Customer WHERE CustomerID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("Name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
}