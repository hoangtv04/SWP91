<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.Review, model.Movie" %>
<%@page import="model.Admin"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Manage Reviews</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .header {
                background-color: #2980b9;
                color: white;
                padding: 10px 0;
                text-align: center;
                position: relative;
            }
            .logout-btn {
                position: absolute;
                top: 10px;
                right: 20px;
                background-color: #333;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
            }
            .logout-btn:hover {
                background-color: #ddd;
                color: black;
            }
            .navbar {
                overflow: hidden;
                background-color: #333;
                display: flex;
                justify-content: center;
            }
            .navbar a {
                float: left;
                display: block;
                color: white;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }
            .navbar a:hover {
                background-color: #ddd;
                color: black;
            }

            .container {
                padding: 20px;
            }
            .table-container {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #2980b9;
                color: white;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            .header p {
                text-align: left;
                margin-left: 20px;
            }
        </style>
        <script>
            function confirmDelete(reviewID) {
                if (confirm('Are you sure you want to delete this review?')) {
                    document.getElementById('deleteForm-' + reviewID).submit();
                }
            }
        </script>
    </head>
    <body>
        <div class="header">
            <h1>Admin Dashboard - Manage Reviews</h1>
            <p>Xin chào, <%= admin.getName() %>!</p>
            <a href="logout" class="logout-btn">Đăng xuất</a>
        </div>

        <div class="navbar">
            <a href="AdminDashboard">Home</a>
            <a href="user">Manage Users</a>
            <a href="Movies">Manage Movies</a>
            <a href="Showtime">Manage Showtimes</a>
            <a href="manageBookings.jsp">Manage Bookings</a>
            <a href="reviews">Manage Reviews</a>
            <a href="voucher">Manage Vouchers</a>
        </div>

        <div class="container">
            <div class="table-container">
                <h2 class="text-center">Danh sách đánh giá</h2>
                <form method="GET" action="reviews">
                    <label for="movieID">Lọc theo phim:</label>
                    <select name="movieID" id="movieID" onchange="this.form.submit()">
                        <option value="">Tất cả phim</option>
                        <% 
                            List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                            String selectedMovieID = request.getParameter("movieID"); // Lấy movieID đang chọn từ request
                            if (movies != null) {
                                for (Movie movie : movies) { 
                                    String selected = (selectedMovieID != null && selectedMovieID.equals(String.valueOf(movie.getMovieID()))) ? "selected" : "";
                        %>
                        <option value="<%= movie.getMovieID() %>" <%= selected %>><%= movie.getTitle() %></option>
                        <% } } %>
                    </select>
                </form>
                <%
                    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
                    double averageRating = 0;
                    if (reviews != null && !reviews.isEmpty()) {
                        double totalRating = 0;
                        for (Review review : reviews) {
                            totalRating += review.getRating();
                        }
                        averageRating = totalRating / reviews.size();
                    }
                %>
                <p>Average Rating: <%= reviews != null && !reviews.isEmpty() ? String.format("%.2f", averageRating) : "N/A" %></p>
                <table>
                    <thead>
                        <tr>
                            <th>Review ID</th>
                            <th>Customer</th>
                            <th>Movie</th>
                            <th>Rating</th>
                            <th>Comment</th>
                            <th>Review Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (reviews != null && !reviews.isEmpty()) {
                               for (Review review : reviews) { %>
                        <tr>
                            <td><%= review.getReviewID() %></td>
                            <td><%= review.getCustomerName() %></td>
                            <td><%= review.getMovieTitle() %></td>
                            <td><%= review.getRating() %></td>
                            <td><%= review.getComment() %></td>
                            <td><%= review.getReviewDate() %></td>
                            <td>
                                <form id="deleteForm-<%= review.getReviewID() %>" action="reviews" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="reviewID" value="<%= review.getReviewID() %>">
                                    <button type="button" class="delete-btn" onclick="confirmDelete('<%= review.getReviewID() %>')">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="7">Không có đánh giá nào.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
