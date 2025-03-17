package controller;

import com.google.gson.Gson;
import dal.MovieDAO;
import model.Review;

import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddCommentServlet", urlPatterns = {"/addComment"})
public class AddCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int movieId = Integer.parseInt(request.getParameter("movieId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            int customerId = (int) request.getSession().getAttribute("customerId"); // Lấy từ session

            Review review = new Review();
            review.setMovieID(movieId);
            review.setCustomerID(customerId);
            review.setRating(rating);
            review.setComment(comment);
            review.setReviewDate(new Date());

            MovieDAO movieDAO = new MovieDAO();
            movieDAO.addReview(review);

            // Trả về JSON
            String customerName = movieDAO.getCustomerNameById(customerId); // Lấy tên khách hàng
            response.getWriter().write(new Gson().toJson(new JsonResponse(true, customerName, rating, comment)));
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write(new Gson().toJson(new JsonResponse(false, null, 0, null)));
        }
    }

    private static class JsonResponse {
        boolean success;
        String customerName;
        int rating;
        String comment;

        public JsonResponse(boolean success, String customerName, int rating, String comment) {
            this.success = success;
            this.customerName = customerName;
            this.rating = rating;
            this.comment = comment;
        }
    }
}