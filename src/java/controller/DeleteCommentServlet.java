package controller;

import dal.MovieDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteCommentServlet", urlPatterns = {"/deleteComment"})
public class DeleteCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy reviewId từ request
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));

            // Gọi DAO để xóa comment
            MovieDAO movieDAO = new MovieDAO();
            movieDAO.deleteReview(reviewId);

            // Chuyển hướng về trang chi tiết phim
            String movieId = request.getParameter("movieId");
            response.sendRedirect("movieDetails?movieId=" + movieId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}