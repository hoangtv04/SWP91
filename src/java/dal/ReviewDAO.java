package dao;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Review;
import java.util.Date;

public class ReviewDAO extends DBContext {
    
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.ReviewID, c.CustomerID, c.CustomerName, m.MovieID, m.Title, r.Rating, r.Comment, r.ReviewDate " +
                     "FROM Review r " +
                     "JOIN Customer c ON r.CustomerID = c.CustomerID " +
                     "JOIN Movie m ON r.MovieID = m.MovieID";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
        while (rs.next()) {
            Review review = new Review(
                rs.getInt("ReviewID"),
                rs.getInt("CustomerID"),
                rs.getString("CustomerName"), // Lấy tên khách hàng
                rs.getInt("MovieID"),
                rs.getString("Title"), // Lấy tên phim
                rs.getInt("Rating"),
                rs.getString("Comment"),
                new Date(rs.getTimestamp("ReviewDate").getTime())
            );
            reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
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

    public List<Review> getReviewsByMovie(int movieID) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.ReviewID, c.CustomerID, c.CustomerName, m.MovieID, m.Title, r.Rating, r.Comment, r.ReviewDate " +
                     "FROM Review r " +
                     "JOIN Customer c ON r.CustomerID = c.CustomerID " +
                     "JOIN Movie m ON r.MovieID = m.MovieID " +
                     "WHERE r.MovieID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review(
                        rs.getInt("ReviewID"),
                        rs.getInt("CustomerID"),
                        rs.getString("CustomerName"),
                        rs.getInt("MovieID"),
                        rs.getString("Title"),
                        rs.getInt("Rating"),
                        rs.getString("Comment"),
                        rs.getTimestamp("ReviewDate")
                    );
                    reviews.add(review);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }
}