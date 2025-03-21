package controller;

import dal.MovieDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Review;

@WebServlet(name = "EditCommentServlet", urlPatterns = {"/editComment"})
public class EditCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            MovieDAO movieDAO = new MovieDAO();
            Review review = movieDAO.getReviewById(reviewId);
            if (review != null) {
                review.setRating(rating);
                review.setComment(comment);
                movieDAO.updateReview(review);
            }

            response.sendRedirect("movieDetails?movieId=" + review.getMovieID());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}