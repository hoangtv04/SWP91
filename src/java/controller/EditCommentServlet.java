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
            // Lấy dữ liệu từ request
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            // Tạo đối tượng DAO để xử lý
            MovieDAO movieDAO = new MovieDAO();

            // Lấy review từ database
            Review review = movieDAO.getReviewById(reviewId);
            if (review != null) {
                // Cập nhật thông tin review
                review.setRating(rating);
                review.setComment(comment);

                // Lưu thay đổi vào database
                movieDAO.updateReview(review);

                // Chuyển hướng về trang chi tiết phim
                response.sendRedirect("movieDetails?movieId=" + review.getMovieID());
            } else {
                // Nếu không tìm thấy review, chuyển hướng đến trang lỗi
                response.sendRedirect("error.jsp");
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi định dạng số
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            // Xử lý các lỗi khác
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}