
package controller;

import dal.MovieDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="DeleteCommentServlet", urlPatterns={"/DeleteCommentServlet"})
public class DeleteCommentServlet extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        int movieId = Integer.parseInt(request.getParameter("movieId"));

        MovieDAO movieDAO = new MovieDAO();
        //movieDAO.deleteReview(reviewId);

        response.sendRedirect("movieDetails?movieId=" + movieId);
    }
}
