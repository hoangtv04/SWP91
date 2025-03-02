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
import java.util.Date;
import model.Review;

/**
 *
 * @author Admin
 */
@WebServlet(name="EditCommentServlet", urlPatterns={"/editComment"})
public class EditCommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));

        MovieDAO movieDAO = new MovieDAO();
        Review review = movieDAO.getReviewById(reviewId);

        request.setAttribute("review", review);
        request.getRequestDispatcher("editComment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review review = new Review();
        review.setReviewID(reviewId);
        review.setRating(rating);
        review.setComment(comment);
        review.setReviewDate(new Date());

        MovieDAO movieDAO = new MovieDAO();
        movieDAO.updateReview(review);

        response.sendRedirect("movieDetails?movieId=" + review.getMovieID());
    }
}
