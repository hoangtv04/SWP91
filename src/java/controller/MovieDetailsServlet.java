/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.MovieDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Movie;
import model.Review;
import model.Showtime;


@WebServlet(name="MovieDetailsServlet", urlPatterns={"/movieDetails"})
public class MovieDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieIdStr = request.getParameter("movieId");
        if (movieIdStr != null) {
            int movieId = Integer.parseInt(movieIdStr);
            MovieDAO movieDAO = new MovieDAO();
            Movie movie = movieDAO.getMovieById(movieId);
            List<Showtime> showtimes = movieDAO.getShowtimesByMovieId(movieId);
            Map<Integer, String> customerNames = new HashMap<>();
            List<Review> reviews = movieDAO.getReviewsByMovieId(movieId, customerNames);

            // Tính trung bình cộng các đánh giá
            double averageRating = 0;
            if (!reviews.isEmpty()) {
                int totalRating = 0;
                for (Review review : reviews) {
                    totalRating += review.getRating();
                }
                averageRating = (double) totalRating / reviews.size();
            }

            request.setAttribute("movie", movie);
            request.setAttribute("showtimes", showtimes);
            request.setAttribute("reviews", reviews);
            request.setAttribute("customerNames", customerNames);
            request.setAttribute("averageRating", String.format("%.1f", averageRating));
            request.getRequestDispatcher("movieDetails.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
