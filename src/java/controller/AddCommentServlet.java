package controller;

import dal.MovieDAO;
import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Review;

@WebServlet(name = "AddCommentServlet", urlPatterns = {"/addComment"})
public class AddCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            int customerId = Integer.parseInt(request.getParameter("CustomerID"));
            int movieId = Integer.parseInt(request.getParameter("movieId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

           
            // Tạo đối tượng Review
            Review review = new Review();
            review.setMovieID(movieId);
            review.setCustomerID(customerId);
            review.setRating(rating);
            review.setComment(comment);
            review.setReviewDate(new Date());

            // Lưu vào database
            MovieDAO movieDAO = new MovieDAO();
            movieDAO.addReview(review);

            // Chuyển hướng lại trang chi tiết phim
            response.sendRedirect("movieDetails?movieId=" + movieId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Chuyển hướng đến trang lỗi nếu có lỗi xảy ra
        }
    }
}