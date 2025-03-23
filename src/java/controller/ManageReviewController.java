/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.MovieDAO;
import dao.ReviewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Movie;
import model.Review;

/**
 *
 * @author troqu
 */
@WebServlet(name="ManageReviewController", urlPatterns={"/reviews"})
public class ManageReviewController extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieIDParam = request.getParameter("movieID");
        List<Review> reviews;

        if (movieIDParam != null && !movieIDParam.isEmpty()) {
            int movieID = Integer.parseInt(movieIDParam);
            reviews = reviewDAO.getReviewsByMovie(movieID);
        } else {
            reviews = reviewDAO.getAllReviews();
        }
        MovieDAO movieDAO = new MovieDAO();
        List<Movie> movies = movieDAO.getAllMovies();
        request.setAttribute("movies", movies);

        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("manageReviews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int reviewID = Integer.parseInt(request.getParameter("reviewID"));
            reviewDAO.deleteReview(reviewID);
        }
        response.sendRedirect("reviews");
    }
}
