<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map, java.util.HashSet, java.util.Set, model.Showtime" %>
<%@ page import="model.Movie, model.Screen, model.Admin" %>
<%@ page import="java.time.LocalDateTime, java.time.LocalDate" %>
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
        <title>Manage Showtimes</title>
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
            .add-btn {
                display: block;
                width: 200px;
                margin: 20px auto;
                padding: 10px;
                background-color: #2980b9;
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 5px;
            }
            .add-btn:hover {
                background-color: #1c5a85;
            }
            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
                border: 3px solid #2980b9;
                width: 400px;
            }

            .popup h3 {
                text-align: center;
                margin-bottom: 15px;
            }

            .popup form {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .popup label {
                font-weight: bold;
            }

            .popup select,
            .popup input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .popup .button-group {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }

            .popup .button-group button {
                width: 48%;
                padding: 8px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .popup .button-group button[type="submit"] {
                background-color: #2980b9;
                color: white;
            }

            .popup .button-group button[type="submit"]:hover {
                background-color: #1c5a85;
            }

            .popup .button-group button.close-btn {
                background-color: #e74c3c;
                color: white;
            }

            .popup .button-group button.close-btn:hover {
                background-color: #c0392b;
            }
            .header p {
                text-align: left;
                margin-left: 20px;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Admin Dashboard - Manage Showtimes</h1>
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
                <h2 class="text-center">Danh sách suất chiếu</h2>
                <input type="text" id="searchInput" placeholder="Tìm kiếm..." onkeyup="filterShowtime()">

                <button class="add-btn" onclick="openAddShowtimePopup()">Thêm suất chiếu</button>

                <!-- Date Filter Buttons -->
                <div class="date-buttons">
                    <% 
                        Set<String> availableDates = new HashSet<>();
                        List<Showtime> showtimes = (List<Showtime>) request.getAttribute("showtimes");
                        if (showtimes != null) {
                            for (Showtime showtime : showtimes) {
                                LocalDateTime startTime = showtime.getStartTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime();
                                availableDates.add(startTime.toLocalDate().toString());
                            }
                        }
                        for (String date : availableDates) {
                    %>
                    <button onclick="filterByDate('<%= date %>')"><%= date %></button>
                    <% } %>
                </div>

                <table id="showtimeTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Movie Title</th>
                            <th>Screen ID</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Admin ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="showtimeTableBody">
                        <% 
                            if (showtimes != null && !showtimes.isEmpty()) {
                                for (Showtime showtime : showtimes) { 
                                    LocalDateTime startTime = showtime.getStartTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime();
                        %>
                        <tr data-date="<%= startTime.toLocalDate().toString() %>">
                            <td><%= showtime.getShowtimeID() %></td>
                            <td><%= showtime.getMovieID().getTitle() %></td>
                            <td><%= showtime.getScreenID().getScreenName() %></td>
                            <td><%= showtime.getStartTime() %></td>
                            <td><%= showtime.getEndTime() %></td>
                            <td><%= showtime.getAdminID().getAdminId() %></td>
                            <td>
                                <button class="update-btn" onclick="openUpdateShowtimePopup(
                                                '<%= showtime.getShowtimeID() %>',
                                                '<%= showtime.getMovieID().getMovieID() %>',
                                                '<%= showtime.getScreenID().getScreenID() %>',
                                                '<%= showtime.getStartTime() %>',
                                                '<%= showtime.getEndTime() %>',
                                                '<%= showtime.getAdminID().getAdminId() %>')">Update</button>
                                <form action="Showtime" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="showtimeID" value="<%= showtime.getShowtimeID() %>">
                                    <button type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="7">Không có suất chiếu nào.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Popup Thêm Suất Chiếu -->
        <div id="addShowtimePopup" class="popup">
            <h3>Thêm Suất Chiếu</h3>
            <form action="Showtime" method="post">
                <input type="hidden" name="action" value="add">

                <!-- Dropdown chọn Movie -->
                <label for="movieID">Chọn Phim:</label>
                <select name="movieID" required>
                    <% 
                        List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                        if (movies != null) {
                            for (Movie movie : movies) { 
                    %>
                    <option value="<%= movie.getMovieID() %>"><%= movie.getTitle() %></option>
                    <% } } %>
                </select>

                <!-- Dropdown chọn Screen -->
                <label for="screenID">Chọn Phòng Chiếu:</label>
                <select name="screenID" required>
                    <% 
                        List<Screen> screens = (List<Screen>) request.getAttribute("screens");
                        if (screens != null) {
                            for (Screen screen : screens) { 
                    %>
                    <option value="<%= screen.getScreenID() %>"><%= screen.getScreenName() %></option>
                    <% } } %>
                </select>

                <label for="startTime">Thời Gian Bắt Đầu:</label>
                <input type="datetime-local" name="startTime" required>

                <label for="endTime">Thời Gian Kết Thúc:</label>
                <input type="datetime-local" name="endTime" required>

                <input type="hidden" name="adminID" value="<%= admin.getAdminId() %>">

                <div class="button-group">
                    <button type="submit">Thêm Suất Chiếu</button>
                    <button type="button" class="close-btn" onclick="closePopup('addShowtimePopup')">Close</button>
                </div>
            </form>
        </div>
        <div id="updateShowtimePopup" class="popup">
            <h3>Cập Nhật Suất Chiếu</h3>
            <form action="Showtime" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="updateShowtimeID" name="showtimeID">

                <label for="updateMovieID">Chọn Phim:</label>
                <select id="updateMovieID" name="movieID" required>
                    <% for (Movie movie : movies) { %>
                    <option value="<%= movie.getMovieID() %>"><%= movie.getTitle() %></option>
                    <% } %>
                </select>

                <label for="updateScreenID">Chọn Phòng Chiếu:</label>
                <select id="updateScreenID" name="screenID" required>
                    <% for (Screen screen : screens) { %>
                    <option value="<%= screen.getScreenID() %>"><%= screen.getScreenName() %></option>
                    <% } %>
                </select>

                <label for="updateStartTime">Thời Gian Bắt Đầu:</label>
                <input type="datetime-local" id="updateStartTime" name="startTime" required>

                <label for="updateEndTime">Thời Gian Kết Thúc:</label>
                <input type="datetime-local" id="updateEndTime" name="endTime" required>

                <label for="updateAdminID">Admin ID:</label>
                <input type="text" id="updateAdminID" name="adminID" required>

                <div class="button-group">
                    <button type="submit">Update Showtime</button>
                    <button type="button" class="close-btn" onclick="closeUpdateShowtimePopup()">Close</button>
                </div>
            </form>
        </div>
        <script>
            function openAddShowtimePopup() {
                document.getElementById("addShowtimePopup").style.display = "block";
            }

            function closePopup(popupId) {
                document.getElementById(popupId).style.display = "none";
            }

            function openUpdateShowtimePopup(id, movieID, screenID, startTime, endTime, adminID) {
                document.getElementById("updateShowtimeID").value = id;
                document.getElementById("updateMovieID").value = movieID;
                document.getElementById("updateScreenID").value = screenID;
                document.getElementById("updateStartTime").value = startTime.replace(" ", "T");
                document.getElementById("updateEndTime").value = endTime.replace(" ", "T");
                document.getElementById("updateAdminID").value = adminID;
                document.getElementById("updateShowtimePopup").style.display = "block";
            }

            function closeUpdateShowtimePopup() {
                document.getElementById("updateShowtimePopup").style.display = "none";
            }
            function filterShowtime() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("searchInput");
                filter = input.value.toLowerCase();
                table = document.getElementById("showtimeTable");
                tr = table.getElementsByTagName("tr");
                for (i = 1; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[1];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }
            function filterByDate(date) {
                var rows = document.querySelectorAll('#showtimeTableBody tr');
                rows.forEach(row => {
                    if (row.getAttribute('data-date') === date) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }
        </script>
    </body>
</html>
